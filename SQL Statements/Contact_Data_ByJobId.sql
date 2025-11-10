-- Paginated report dataset query for Contact table
-- Parameter: @JobID (text) - Job ID (order___.ord__ref)
-- Returns the customer contact linked to the provided Job ID

SELECT
    k.kla__ref AS [Customer ID],
    k.knp__ref AS [Contact ID],
    k.knp__nam AS [Contact name],
    k.knp__vnm AS [First name],
    k.email___ AS [E-mail],
    k.telefoon AS [Phone],
    k.tel_auto AS [Mobile],
    k.postnaam AS [City],
    k.state___ AS [State],
    k.funktie_ AS [Function],
    k.taal_ref AS [Language],
    k.cdeklaap AS [Other software ID]
FROM dbo.order___ AS o
INNER JOIN dbo.konpkl__ AS k
    ON k.kla__ref = o.kla__ref
   AND k.knp__ref = o.knp__ref
WHERE o.ord__ref = @JobID;
