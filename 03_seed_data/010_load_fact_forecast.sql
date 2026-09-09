USE BuildingMaterialsAnalytics;
GO
;WITH V AS
(
 SELECT 'FC_2026_03'Version,CONVERT(date,'20260331')Snapshot,CONVERT(decimal(6,3),.96)Factor UNION ALL
 SELECT 'FC_2026_06','20260630',1.02 UNION ALL SELECT 'FC_2026_09','20260901',.99
)
INSERT dwh.FactForecast(MonthDateKey,ProductKey,RegionKey,ForecastQuantity,ForecastRevenue,ForecastCost,ForecastVersion,SnapshotDate)
SELECT b.MonthDateKey,b.ProductKey,b.RegionKey,
 ROUND(b.BudgetQuantity*v.Factor*(1+(((b.ProductKey+b.RegionKey)%7)-3)/100.0),2),
 ROUND(b.BudgetRevenue*v.Factor*(1+(((b.ProductKey+b.RegionKey)%7)-3)/100.0),2),
 ROUND(b.BudgetCost*v.Factor,2),v.Version,v.Snapshot
FROM dwh.FactBudget b CROSS JOIN V v WHERE b.BudgetVersion='BUDGET_2026'
AND NOT EXISTS(SELECT 1 FROM dwh.FactForecast x WHERE x.MonthDateKey=b.MonthDateKey AND x.ProductKey=b.ProductKey AND x.RegionKey=b.RegionKey AND x.ForecastVersion=v.Version);
GO

