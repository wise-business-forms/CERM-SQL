-- Paginated report dataset query for Customer table
-- Parameter: @JobID (text) - Job ID (order___.ord__ref)
-- Returns the customer linked to the provided Job ID

SELECT
    c.kla__ref AS [Customer ID],
    c.naam____ AS [Name],
    c.kla__rpn AS [Keyword],
    c.cdeklaap AS [Other software ID],
    c.postnaam AS [City],
    c.state___ AS [State]
FROM dbo.order___ AS o
INNER JOIN dbo.klabas__ AS c
    ON c.kla__ref = o.kla__ref
WHERE o.ord__ref = @JobID;
