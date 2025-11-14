-- Purchase Invoices In Process - Invoice Lines
-- Returns one row per invoice line with requested fields.
-- Assumptions:
--  - Invoice header = dbo.wakpfk__ (inv)
--  - Invoice lines  = dbo.wakpfl__ (lines)
--  - Invoice accounts = dbo.wakpfr__ (acc) (analytical levels)
--  - Level descriptions = dbo.ananiv__ (lvl)
--  - If there are multiple account (acc) rows for a single invoice line,
--    this query groups them and returns the MIN(Level1ID) + MIN(Level1Desc).
--    It uses the invoice line total (lines.tot___bm) for the requested Total field.

SELECT
    lines.fak__ref     AS [Invoice ID],
    lines.fakl_ref     AS [Invoice Line Item ID],
    inv.dossier_       AS [Site],
    inv.doknrlev       AS [Supplier Doc No],
    lines.bon__ref     AS [Purchase Order ID],
    MIN(acc.aniv1ref)  AS [Level 1 ID],
    MIN(lvl.omschr__)  AS [Level 1 Desc],
    lines.tot___bm     AS [Total]
FROM dbo.wakpfl__ AS lines
INNER JOIN dbo.wakpfk__ AS inv
    ON inv.fak__ref = lines.fak__ref
LEFT JOIN dbo.wakpfr__ AS acc
    ON acc.fak__ref  = lines.fak__ref
   AND acc.fakl_ref  = lines.fakl_ref
LEFT JOIN dbo.ananiv__ AS lvl
    ON lvl.aniv_ref = acc.aniv1ref
-- Group by invoice-line level fields so we return one row per invoice line.
GROUP BY
    lines.fak__ref,
    lines.fakl_ref,
    inv.dossier_,
    inv.doknrlev,
    lines.bon__ref,
    lines.tot___bm
ORDER BY
    lines.fak__ref,
    lines.fakl_ref;

-- Notes / alternatives:
--  - If you prefer one row per account record (showing every Level1 mapping), remove the GROUP BY and
--    select acc.aniv1ref / lvl.omschr__ directly (that will return multiple rows per invoice line).
--  - If you want the Total to be the sum of related account rows instead of the invoice line total,
--    replace `lines.tot___bm` with SUM(acc.bedr__bm) in the select and GROUP BY accordingly.
