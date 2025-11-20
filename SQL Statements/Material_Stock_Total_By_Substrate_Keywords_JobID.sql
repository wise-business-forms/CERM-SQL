-- Return all materials and total stock for substrates matching the given job's substrate type components
-- Parameter: @JobID (nchar(6)) - Job ID (v4eti___.off__ref)
-- Returns: All materials with matching Front, Adhesive, or Backing keywords for the job's substrate
-- Shows: Substrate components, material details, and total feet in stock (aggregated by material)

DECLARE @JobID NCHAR(6) = 'XXXXXX'; -- Replace XXXXXX with actual Job ID

-- Look up the Substrate ID from the job
DECLARE @GivenSubstrateID NCHAR(6);
SELECT @GivenSubstrateID = drg__ref
FROM dbo.v4eti___
WHERE off__ref = @JobID;

SELECT
    s.typfrrpn                      AS [Front],
    s.typlmrpn                      AS [Adhesive],
    s.typrgrpn                      AS [Backing],
    s.drg__ref                      AS [Substrate ID],
    s.drg__rpn                      AS [Substrate Keyword],
    mat.art__ref                    AS [Material ID],
    s.drg__oms                      AS [Substrate Description],
    mat.breedte_                    AS [Material Width],
    sku.vak__ref                    AS [Stock Location],
    SUM(sku.in_stock)               AS [Total Feet In Stock]
FROM
    dbo.drgers__ AS s_given                   -- The given substrate (input)
    INNER JOIN dbo.drgers__ AS s              -- All substrates with matching components
        ON s.typfrrpn = s_given.typfrrpn      -- Match Front keyword
        AND s.typlmrpn = s_given.typlmrpn     -- AND match Adhesive keyword
        AND s.typrgrpn = s_given.typrgrpn     -- AND match Backing keyword
    INNER JOIN dbo.artiky__ AS mat            -- Materials table
        ON mat.drg__ref = s.drg__ref          -- Link materials to substrates
    INNER JOIN dbo.artikd__ AS sku            -- Material SKUs table
        ON sku.art__ref = mat.art__ref        -- Link SKUs to materials
WHERE
    s_given.drg__ref = @GivenSubstrateID      -- Start with the given substrate
    AND sku.in_stock > 0                      -- Exclude materials with zero stock
GROUP BY
    s.typfrrpn,
    s.typlmrpn,
    s.typrgrpn,
    s.drg__ref,
    s.drg__rpn,
    mat.art__ref,
    s.drg__oms,
    mat.breedte_,
    sku.vak__ref
ORDER BY
    s.drg__ref, mat.art__ref, sku.vak__ref;
