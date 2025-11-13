-- Purchase Invoices In Process query
-- Returns invoice data with supplier information and analytical level 1 breakdown
-- Aggregates amounts by Supplier Document No and Level 1 ID

SELECT
    inv.fak__ref AS [Invoice ID],
    inv.dossier_ AS [Site],
    inv.lev__ref AS [Supplier ID],
    sup.naam____ AS [Supplier Name],
    inv.doknrlev AS [Supplier Document No],
    acc.aniv1ref AS [Level 1 ID],
    lvl.omschr__ AS [Level 1 Description],
    SUM(acc.bedr__bm) AS [Amount]
FROM dbo.wakpfk__ AS inv
INNER JOIN dbo.wakpfr__ AS acc
    ON acc.fak__ref = inv.fak__ref
LEFT JOIN dbo.levbas__ AS sup
    ON sup.lev__ref = inv.lev__ref
LEFT JOIN dbo.ananiv__ AS lvl
    ON lvl.aniv_ref = acc.aniv1ref
GROUP BY 
    inv.fak__ref,
    inv.dossier_,
    inv.lev__ref,
    sup.naam____,
    inv.doknrlev,
    acc.aniv1ref,
    lvl.omschr__;
