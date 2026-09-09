USE BuildingMaterialsAnalytics;
GO
CREATE OR ALTER VIEW rpt.vw_MonthlyActual AS
SELECT CONVERT(int,CONVERT(char(8),DATEFROMPARTS(d.[Year],d.MonthNumber,1),112))MonthDateKey,
s.ProductKey,s.RegionKey,SUM(s.Quantity)ActualQuantity,SUM(s.Revenue)ActualRevenue,
SUM(s.CostAmount)ActualCost,SUM(s.GrossMargin)ActualGrossMargin
FROM dwh.FactSales s JOIN dwh.DimDate d ON d.DateKey=s.DateKey
GROUP BY d.[Year],d.MonthNumber,s.ProductKey,s.RegionKey;
GO

