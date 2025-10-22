-- Paginated report dataset query for Work Zone Clockings
-- Parameter: @JobID (text) - Job ID (order___.ord__ref)
-- Returns work zone clockings linked to the provided Job ID

SELECT
    z.idf_pnt2 AS [Clocking ID],
    z.dos__ref AS [Site ID],
    z.datum___ AS [Date],
    z.starten_ AS [Start],
    z.stoppen_ AS [Stop],
    z.wn___ref AS [Employee ID],
    z.wp___ref AS [Cost center ID],
    z.akt__ref AS [Activity ID],
    z.produktf AS [Productive],
    z.ord__ref AS [Job ID],
    z.suborder AS [Job part ID],
    z.kpn__ref AS [Press sheet ID],
    z.dg___ref AS [Press run ID],
    z.production_flow_id AS [Production flow ID],
    z.workstep_id AS [Workstep ID],
    z.run_id AS [Run ID],
    z.vrs_refs AS [Versions],
    z.vrm__ref AS [Print form ID],
    z.afg__ref AS [Product ID],
    z.aantal__ AS [Quantity],
    z.kom__ref AS [Comment ID],
    z.komment_ AS [Comment],
    z.prc_____ AS [Split % job grouping]
FROM dbo.w_pnt2__ AS z
WHERE z.ord__ref = CONVERT(nchar(6), @JobID)
ORDER BY z.datum___, z.starten_;
