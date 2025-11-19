-- Calculate Total Stock of Materials Sharing the Same Substrate Keywords
-- Parameter: @GivenSubstrateID (nchar(6)) - Substrate ID (drgers__.drg__ref)
-- Returns: Single value representing the total stock of all materials that share
--          the same front, adhesion, and backing keywords (Level 2) as the given substrate
-- Note: Excludes materials with zero stock

DECLARE @GivenSubstrateID NCHAR(6) = 'XXXXXX'; -- Replace XXXXXX with actual Substrate ID

SELECT 
    SUM(sku.in_stock) AS [Total Stock]
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
    AND sku.in_stock > 0;                    -- Exclude materials with zero stock
