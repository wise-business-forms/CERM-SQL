-- Find Substrates with Matching Keywords
-- Parameter: @SubstrateID (nchar(6)) - Substrate ID (drgers__.drg__ref)
-- Returns all substrates that share the same Front, Adh., and Backing keywords
-- Excludes the input substrate from the results

DECLARE @SubstrateID NCHAR(6) = 'XXXXXX'; -- Replace XXXXXX with actual Substrate ID

SELECT 
    s2.*
FROM dbo.drgers__ AS s1
INNER JOIN dbo.drgers__ AS s2
    ON s2.typfrrpn = s1.typfrrpn      -- Match Front keyword (Level 1)
    AND s2.typlmrpn = s1.typlmrpn     -- Match Adh. keyword (Level 1)
    AND s2.typrgrpn = s1.typrgrpn     -- Match Backing keyword (Level 1)
    AND s2.drg__ref <> s1.drg__ref    -- Exclude the original substrate
WHERE 
    s1.drg__ref = @SubstrateID;
