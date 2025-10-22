-- Paginated report dataset query for SKU Details Consumptions
-- Parameter: @JobID (text) - Job ID (order___.ord__ref)
-- Returns SKU detail consumptions linked to the provided Job ID

SELECT
    d.idf_vrbr AS [Consumption ID],
    d.volgnr__ AS [Sequence no.],
    d.artd_ref AS [SKU ID],
    d.aantal__ AS [Quantity],
    d.art__vrd AS [Reduce stock only]
FROM dbo.w_vrbd__ AS d
INNER JOIN dbo.w_vrbr__ AS h
    ON h.idf_vrbr = d.idf_vrbr
WHERE h.ord__ref = CONVERT(nchar(6), @JobID)
ORDER BY d.idf_vrbr, d.volgnr__;
