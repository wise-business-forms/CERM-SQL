PARAMETERS [Enter Job ID] Text ( 6 );
SELECT jobs.off__ref AS [Job ID], s.typfrrpn AS Front, s.typlmrpn AS Adhesive, s.typrgrpn AS Backing, s.drg__ref AS [Substrate ID], s.drg__rpn AS [Substrate Keyword], mat.art__ref AS [Material ID], s.drg__oms AS [Substrate Description], mat.breedte_ AS [Material Width], sku.vak__ref AS [Stock Location], SUM(sku.in_stock) AS [Total Feet In Stock]
FROM (((dbo_v4eti___ AS jobs INNER JOIN dbo_drgers__ AS s_given ON jobs.drg__ref = s_given.drg__ref) INNER JOIN dbo_drgers__ AS s ON (s.typrgrpn = s_given.typrgrpn) AND (s.typlmrpn = s_given.typlmrpn) AND (s.typfrrpn = s_given.typfrrpn)) INNER JOIN dbo_artiky__ AS mat ON mat.drg__ref = s.drg__ref) INNER JOIN dbo_artikd__ AS sku ON sku.art__ref = mat.art__ref
WHERE jobs.off__ref = [Enter Job ID]
    AND sku.in_stock > 0
GROUP BY jobs.off__ref, s.typfrrpn, s.typlmrpn, s.typrgrpn, s.drg__ref, s.drg__rpn, mat.art__ref, s.drg__oms, mat.breedte_, sku.vak__ref
ORDER BY s.drg__ref, mat.art__ref, sku.vak__ref;
