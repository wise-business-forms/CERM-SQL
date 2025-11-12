-- Purchase Invoices In Process query
-- Returns invoice data with supplier information and cost category (Level 1) breakdown
-- Aggregates amounts by Supplier Document No and Level 1 ID

SELECT
    inv.fak__ref AS [Invoice ID],
    inv.dossier_ AS [Site],
    inv.lev__ref AS [Supplier ID],
    sup.naam____ AS [Supplier Name],
    inv.doknrlev AS [Supplier Document No],
    line.rbk__ref AS [Level 1 ID],
    cc.omschr__ AS [Level 1 Description],
    SUM(line.tot___bm) AS [Amount]
FROM dbo.wakpfk__ AS inv
INNER JOIN dbo.wakpfl__ AS line
    ON line.fak__ref = inv.fak__ref
LEFT JOIN dbo.levbas__ AS sup
    ON sup.lev__ref = inv.lev__ref
LEFT JOIN dbo.rbk_vk__ AS cc
    ON cc.rbk__ref = line.rbk__ref
GROUP BY 
    inv.fak__ref,
    inv.dossier_,
    inv.lev__ref,
    sup.naam____,
    inv.doknrlev,
    line.rbk__ref,
    cc.omschr__;
