-- Paginated report dataset query for Job + related Customer and Contact
-- Parameter: @JobID (nvarchar(6))

SELECT
	[Job].*,
	[Clients Customers].*,
	[Clients Contacts].*
FROM dbo.order___ AS [Job]
LEFT JOIN dbo.klabas__ AS [Clients Customers]
	ON [Clients Customers].kla__ref = [Job].kla__ref
LEFT JOIN dbo.konpkl__ AS [Clients Contacts]
	ON [Clients Contacts].kla__ref = [Job].kla__ref
	AND [Clients Contacts].knp__ref = [Job].knp__ref
WHERE [Job].ord__ref = @JobID;
