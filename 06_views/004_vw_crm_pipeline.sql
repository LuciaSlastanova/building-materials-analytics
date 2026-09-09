USE BuildingMaterialsAnalytics;
GO
CREATE OR ALTER VIEW rpt.vw_CRMPipeline AS
SELECT o.SalesforceOppId,o.OpportunityName,c.CustomerName,pc.CategoryName,sr.FullName SalesRepresentative,r.RegionName,
cd.FullDate CreatedDate,ed.FullDate ExpectedCloseDate,o.StageName,o.ProbabilityPct,o.ExpectedRevenue,o.WeightedRevenue,o.LeadSource,o.IsWon,o.IsClosed
FROM dwh.FactCRMOpportunity o JOIN dwh.DimCustomer c ON c.CustomerKey=o.CustomerKey
JOIN dwh.DimRegion r ON r.RegionKey=c.RegionKey JOIN dwh.DimProductCategory pc ON pc.ProductCategoryKey=o.ProductCategoryKey
JOIN dwh.DimSalesRepresentative sr ON sr.SalesRepKey=o.SalesRepKey
JOIN dwh.DimDate cd ON cd.DateKey=o.CreatedDateKey JOIN dwh.DimDate ed ON ed.DateKey=o.ExpectedCloseDateKey;
GO

