-- Paginated report dataset query for Work Zone Material Consumptions
-- Parameter: @JobID (text) - Job ID (order___.ord__ref)
-- Returns work zone material consumptions linked to the provided Job ID

SELECT
    c.idf_vrb2 AS [Consumption ID],
    c.dos__ref AS [Site ID],
    c.datum___ AS [Date],
    c.uur_____ AS [Hour],
    c.art__srt AS [Material type],
    c.art__ref AS [Material ID],
    c.artd_ref AS [SKU ID],
    c.aantal__ AS [Quantity],
    c.rollen__ AS [No. of rolls],
    c.andro_kg AS [Other web substrate (kg)],
    c.papr_kgm AS [Paper input (kg/m)],
    c.art__vrd AS [Reduce stock only],
    c.ord__ref AS [Job ID],
    c.suborder AS [Job part ID],
    c.kpn__ref AS [Press sheet ID],
    c.dg___ref AS [Press run ID],
    c.production_flow_id AS [Production flow ID],
    c.workstep_id AS [Workstep ID],
    c.run_id AS [Run ID],
    c.produktf AS [Productive],
    c.volledig AS [Complete],
    c.kom__ref AS [Comment ID],
    c.komment_ AS [Comment],
    c.wp___ref AS [Cost center ID],
    c.wn___ref AS [Employee ID],
    c.bcrerek1 AS [Credit account 1],
    c.bcrerek2 AS [Credit account 2 (Surcharge)],
    c.bdebrek1 AS [Debit account 1],
    c.bdebrek2 AS [Debit account 2 (Surcharge)],
    c.bdebrek3 AS [Debit account 3 (Rework)],
    c.bdebrek4 AS [Debit account 4 (Rework Surcharge)]
FROM dbo.w_vrb2__ AS c
WHERE c.ord__ref = @JobID
ORDER BY c.datum___, c.uur_____, c.idf_vrb2;
