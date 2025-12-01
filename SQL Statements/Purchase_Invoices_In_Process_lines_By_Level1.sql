-- Purchase Invoices In Process - Lines Aggregated by Level 1 ID
-- Returns one row per Level 1 ID with the sum of invoice line totals.
-- Assumptions:
--  - Invoice header = dbo.wakpfk__ (inv)
--  - Invoice lines  = dbo.wakpfl__ (lines)
--  - Invoice accounts = dbo.wakpfr__ (acc) (analytical levels)
--  - Level descriptions = dbo.ananiv__ (lvl)
--  - Multiple invoice line items with the same Level 1 ID are aggregated into a single row.

SELECT
    acc.aniv1ref       AS [Level 1 ID],
    lvl.omschr__       AS [Level 1 Desc],
    SUM(lines.tot___bm) AS [Total]
FROM dbo.wakpfl__ AS lines
INNER JOIN dbo.wakpfk__ AS inv
    ON inv.fak__ref = lines.fak__ref
INNER JOIN dbo.wakpfr__ AS acc
    ON acc.fak__ref  = lines.fak__ref
   AND acc.fakl_ref  = lines.fakl_ref
LEFT JOIN dbo.ananiv__ AS lvl
    ON lvl.aniv_ref = acc.aniv1ref
-- Group by Level 1 ID fields so we return one row per Level 1 ID.
GROUP BY
    acc.aniv1ref,
    lvl.omschr__
ORDER BY
    acc.aniv1ref;

-- Notes:
--  - This query aggregates all invoice lines by their Level 1 ID.
--  - If an invoice line has no associated account record, it will not appear in the results
--    (INNER JOIN on acc). To include such lines, change the join to LEFT JOIN
--    and handle NULL Level 1 IDs accordingly.
--  - The Total is the sum of invoice line totals (lines.tot___bm) for each Level 1 ID.
