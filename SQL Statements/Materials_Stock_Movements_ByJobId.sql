-- Paginated report dataset query for Materials Stock Movements
-- Parameter: @JobID (text) - Job ID (order___.ord__ref)
-- Returns all material stock movements linked to the provided Job ID

SELECT
    m.ord__ref  AS [Job ID],
    m.jobnr_vw  AS [Process ID],
    m.soort___  AS [Kind of movement],
    m.datum___  AS [Date],
    m.uur_____  AS [Time],
    m.user____  AS [User],
    m.art__ref  AS [Material ID],
    m.artd_ref  AS [SKU ID],
    m.zyn__ref  AS [Ref. at supplier],
    m.art__srt  AS [Material type],
    m.aantal__  AS [Quantity],
    m.rollen__  AS [Rolls],
    m.prijs___  AS [Job unit price],
    m.markt___  AS [Market price],
    m.kost____  AS [Cost],
    m.toeslag_  AS [Surcharge],
    m.kla__ref  AS [Customer ID],
    m.lev__ref  AS [Supplier ID],
    m.grbonref  AS [Order ID],
    m.grs__vnr  AS [Order line item ID],
    m.jobnrlev  AS [Process ID (Supplier)],
    m.mat__ref  AS [Material note],
    m.job__inl  AS [Process ID (CAPTOR)],
    m.fkgr_ref  AS [Invoice ID (Price)],
    m.suborder  AS [Job part ID],
    m.kpn__ref  AS [Press sheet ID],
    m.dg___ref  AS [Press run ID],
    m.production_flow_id AS [Production flow ID],
    m.workstep_id        AS [Workstep ID],
    m.run_id             AS [Run ID],
    m.produktf  AS [Productive],
    m.rbk__ref  AS [Cost category ID],
    m.wp___ref  AS [Cost center ID],
    m.wn___ref  AS [Employee ID],
    m.res__ref  AS [Reservation ID]
FROM dbo.stobew__ AS m
WHERE m.ord__ref = CONVERT(nchar(6), @JobID)
ORDER BY m.datum___, m.uur_____;
