-- Paginated report dataset query for Job Calculations
-- Parameter: @JobID (text) - Job ID (order___.ord__ref)
-- Returns the calculation linked to the provided Job ID

SELECT
    calc.off__ref AS [Calculation ID],
    calc.off__rpn AS [Calculation keyword],
    calc.bon__ref AS [Estimate ID],
    calc.kla__ref AS [Customer ID],
    calc.knp__ref AS [Contact ID],
    calc.omschr__ AS [Description],
    calc.oplage__ AS [Quantity],
    calc.prys_srt AS [Price type],
    calc.vkp____b AS [Sales price (incl. commissions)],
    calc.stdvkp_b AS [Sales price (excl. commissions)],
    calc.kst____b AS [Total cost],
    calc.marge__b AS [Markup % (cost)],
    calc.gross_margin AS [Gross margin],
    calc.gross_margin_pct AS [Gross margin %],
    calc.user____ AS [Calculator],
    calc.wij__dat AS [Latest change date]
FROM dbo.order___ AS o
INNER JOIN dbo.v4off___ AS calc
    ON calc.off__ref = o.off__ref
WHERE o.ord__ref = CONVERT(nchar(6), @JobID);
