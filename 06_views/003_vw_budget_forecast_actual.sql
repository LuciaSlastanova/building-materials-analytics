USE BuildingMaterialsAnalytics;
GO
CREATE OR ALTER VIEW rpt.vw_BudgetForecastActual AS
WITH B AS(SELECT MonthDateKey,ProductKey,RegionKey,SUM(BudgetQuantity)BudgetQuantity,SUM(BudgetRevenue)BudgetRevenue,SUM(BudgetCost)BudgetCost FROM dwh.FactBudget GROUP BY MonthDateKey,ProductKey,RegionKey),
F AS(SELECT MonthDateKey,ProductKey,RegionKey,ForecastQuantity,ForecastRevenue,ForecastCost FROM dwh.FactForecast WHERE ForecastVersion='FC_2026_09'),
K AS(SELECT MonthDateKey,ProductKey,RegionKey FROM B UNION SELECT MonthDateKey,ProductKey,RegionKey FROM F UNION SELECT MonthDateKey,ProductKey,RegionKey FROM rpt.vw_MonthlyActual)
SELECT k.MonthDateKey,d.FullDate MonthDate,d.[Year],d.MonthNumber,d.MonthName,d.YearMonth,p.ProductCode,p.ProductName,pc.CategoryName,r.RegionCode,r.RegionName,
COALESCE(a.ActualQuantity,0)ActualQuantity,COALESCE(a.ActualRevenue,0)ActualRevenue,COALESCE(a.ActualCost,0)ActualCost,COALESCE(a.ActualGrossMargin,0)ActualGrossMargin,
COALESCE(b.BudgetQuantity,0)BudgetQuantity,COALESCE(b.BudgetRevenue,0)BudgetRevenue,COALESCE(b.BudgetCost,0)BudgetCost,
COALESCE(f.ForecastQuantity,0)ForecastQuantity,COALESCE(f.ForecastRevenue,0)ForecastRevenue,COALESCE(f.ForecastCost,0)ForecastCost,
COALESCE(a.ActualRevenue,0)-COALESCE(b.BudgetRevenue,0)RevenueVsBudget,
dwh.fn_VariancePct(COALESCE(a.ActualRevenue,0),b.BudgetRevenue)RevenueVsBudgetPct
FROM K k JOIN dwh.DimDate d ON d.DateKey=k.MonthDateKey JOIN dwh.DimProduct p ON p.ProductKey=k.ProductKey
JOIN dwh.DimProductCategory pc ON pc.ProductCategoryKey=p.ProductCategoryKey JOIN dwh.DimRegion r ON r.RegionKey=k.RegionKey
LEFT JOIN B b ON b.MonthDateKey=k.MonthDateKey AND b.ProductKey=k.ProductKey AND b.RegionKey=k.RegionKey
LEFT JOIN F f ON f.MonthDateKey=k.MonthDateKey AND f.ProductKey=k.ProductKey AND f.RegionKey=k.RegionKey
LEFT JOIN rpt.vw_MonthlyActual a ON a.MonthDateKey=k.MonthDateKey AND a.ProductKey=k.ProductKey AND a.RegionKey=k.RegionKey;
GO

