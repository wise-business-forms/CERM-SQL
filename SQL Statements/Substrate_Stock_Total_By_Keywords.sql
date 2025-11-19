-- Material Stock Total by Substrate Keywords
-- This query calculates the total stock of all materials that share the same front, adhesion, and backing keywords as a given substrate
-- Parameter: @GivenSubstrateID (nchar(6)) - Substrate ID from drgers__ table
-- Returns: Single value representing the total calculated stock

-- Step 1: Declare variable for input Substrate ID
DECLARE @GivenSubstrateID nchar(6) = 'XXXXXX';  -- Replace XXXXXX with actual Substrate ID

-- Step 2-4: Calculate total stock for materials with matching substrate keywords
SELECT 
    SUM(sku.in_stock) AS [Total Stock]
FROM 
    drgers__ sub_given                          -- Substrates table (for given substrate)
    INNER JOIN drgers__ sub_match               -- Substrates table (for matching substrates)
        ON sub_match.srtfrrpn = sub_given.srtfrrpn  -- Match on Front keyword (Level 2)
        AND sub_match.srtlmrpn = sub_given.srtlmrpn -- Match on Adhesion keyword (Level 2)
        AND sub_match.srtrgrpn = sub_given.srtrgrpn -- Match on Backing keyword (Level 2)
    INNER JOIN artiky__ mat                     -- Materials table
        ON mat.drg__ref = sub_match.drg__ref    -- Link materials to matching substrates
    INNER JOIN artikd__ sku                     -- Material SKUs table
        ON sku.art__ref = mat.art__ref          -- Link SKUs to materials
WHERE 
    sub_given.drg__ref = @GivenSubstrateID;     -- Filter for the given Substrate ID
