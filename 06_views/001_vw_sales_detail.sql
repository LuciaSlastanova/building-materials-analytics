USE BuildingMaterialsAnalytics;
GO
CREATE OR ALTER VIEW rpt.vw_SalesDetail AS
SELECT s.SalesKey,d.FullDate,d.[Year],d.QuarterName,d.MonthNumber,d.MonthName,d.YearMonth,
p.ProductCode,p.ProductName,pc.CategoryName,c.CustomerCode,c.CustomerName,c.CustomerType,c.CustomerSegment,
r.RegionCode,r.RegionName,r.SalesArea,sr.FullName SalesRepresentative,s.SalesChannel,
s.Quantity,s.UnitPrice,s.DiscountPct,s.Revenue,s.CostAmount,s.GrossMargin,
CAST(CASE WHEN s.Revenue=0 THEN 0 ELSE s.GrossMargin/s.Revenue*100 END AS decimal(8,2))GrossMarginPct
FROM dwh.FactSales s JOIN dwh.DimDate d ON d.DateKey=s.DateKey
JOIN dwh.DimProduct p ON p.ProductKey=s.ProductKey
JOIN dwh.DimProductCategory pc ON pc.ProductCategoryKey=p.ProductCategoryKey
JOIN dwh.DimCustomer c ON c.CustomerKey=s.CustomerKey JOIN dwh.DimRegion r ON r.RegionKey=s.RegionKey
JOIN dwh.DimSalesRepresentative sr ON sr.SalesRepKey=s.SalesRepKey;
GO

