USE BuildingMaterialsAnalytics;
GO
;WITH M AS(SELECT DateKey,[Year],MonthNumber FROM dwh.DimDate WHERE DayOfMonth=1 AND[Year]BETWEEN 2024 AND 2026)
INSERT dwh.FactBudget(MonthDateKey,ProductKey,RegionKey,BudgetQuantity,BudgetRevenue,BudgetCost,BudgetVersion)
SELECT m.DateKey,p.ProductKey,r.RegionKey,q.Qty,
 ROUND(q.Qty*p.ListPrice*CASE m.[Year]WHEN 2024 THEN .91 WHEN 2025 THEN .96 ELSE 1 END,2),
 ROUND(q.Qty*p.StandardCost*(1+(m.[Year]-2024)*.025),2),CONCAT('BUDGET_',m.[Year])
FROM M m CROSS JOIN dwh.DimProduct p CROSS JOIN dwh.DimRegion r
CROSS APPLY(SELECT CONVERT(decimal(14,2),280+((p.ProductKey*41+r.RegionKey*67+m.MonthNumber*31)%520)
 +CASE WHEN m.MonthNumber BETWEEN 3 AND 10 THEN 180 ELSE 0 END+CASE WHEN r.RegionKey IN(1,7,8)THEN 120 ELSE 0 END+(m.[Year]-2024)*45)Qty)q
WHERE NOT EXISTS(SELECT 1 FROM dwh.FactBudget x WHERE x.MonthDateKey=m.DateKey AND x.ProductKey=p.ProductKey AND x.RegionKey=r.RegionKey AND x.BudgetVersion=CONCAT('BUDGET_',m.[Year]));
GO

