-- Material Stock Total by Site
-- This query returns the total stock quantity for each material at each site
-- Main data point: SUM of artikd__.in_stock (In Stock from Material SKUs table)
-- Stock location connection: artikd__.vak__ref -> dosbas__.vak__ref -> dosbas__.dos__ref (Site ID)

SELECT 
    d.dos__ref AS [Site ID],
    m.drg__ref AS [Substrate ID],
    m.art__ref AS [Material ID],
    m.art_oms1 AS [Material Description],
    m.breedte_ AS [Width],
    SUM(s.in_stock) AS [In Stock]
FROM 
    artikd__ s                          -- Material SKUs table
    INNER JOIN artiky__ m               -- Materials table
        ON s.art__ref = m.art__ref      -- Join on Material ID
    LEFT JOIN dosbas__ d                -- General Site Data table
        ON s.vak__ref = d.vak__ref      -- Join on Stock location
WHERE 
    s.in_stock > 0                      -- Only include SKUs with stock
    AND m.drg__ref = 'XXXXXX'           -- Filter by specific Substrate ID (replace XXXXXX with actual Substrate ID)
GROUP BY 
    d.dos__ref,
    m.drg__ref,
    m.art__ref,
    m.art_oms1,
    m.breedte_
ORDER BY 
    d.dos__ref,
    m.art__ref;
