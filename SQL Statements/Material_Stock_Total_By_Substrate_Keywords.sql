-- Return detailed stock rows for materials that share the same substrate keywords
-- Parameter: @GivenSubstrateID (nchar(6)) - Substrate ID (drgers__.drg__ref)
-- Returns: Rows with stock location, substrate ID, substrate keyword, substrate description,
--          material ID, material width, and in-stock quantity. Excludes zero stock.

DECLARE @GivenSubstrateID NCHAR(6) = 'XXXXXX'; -- Replace XXXXXX with actual Substrate ID

SELECT
    sku.vak__ref        AS [Stock Location],        -- Stock location (SKU level)
    s2.drg__ref         AS [Substrate ID],
    s2.drg__rpn         AS [Substrate Keyword],
    s2.drg__oms         AS [Substrate Description],
    mat.art__ref        AS [Material ID],
    mat.breedte_        AS [Material Width],
    sku.in_stock        AS [In Stock Quantity]
FROM
    dbo.drgers__ AS s1                       -- Source substrate (the given one)
    INNER JOIN dbo.drgers__ AS s2            -- All substrates with matching keywords
        ON s2.srtfrrpn = s1.srtfrrpn         -- Match Front keyword (Level 2)
        AND s2.srtlmrpn = s1.srtlmrpn        -- Match Adhesion keyword (Level 2)
        AND s2.srtrgrpn = s1.srtrgrpn        -- Match Backing keyword (Level 2)
    INNER JOIN dbo.artiky__ AS mat           -- Materials table
        ON mat.drg__ref = s2.drg__ref        -- Link materials to substrates
    INNER JOIN dbo.artikd__ AS sku           -- Material SKUs table
        ON sku.art__ref = mat.art__ref       -- Link SKUs to materials
WHERE
    s1.drg__ref = @GivenSubstrateID          -- Start with the given substrate
    AND sku.in_stock > 0                      -- Exclude materials with zero stock
ORDER BY
    sku.vak__ref, s2.drg__ref, mat.art__ref;
