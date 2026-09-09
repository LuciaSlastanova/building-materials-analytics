USE BuildingMaterialsAnalytics;
GO
;WITH Y AS
(
 SELECT 2024 Yr,CONVERT(decimal(6,3),0.91)Factor UNION ALL
 SELECT 2025,0.96 UNION ALL SELECT 2026,1.00
)
INSERT dwh.FactPriceList(ProductKey,ValidFrom,ValidTo,ListPrice)
SELECT p.ProductKey,DATEFROMPARTS(y.Yr,1,1),DATEFROMPARTS(y.Yr,12,31),ROUND(p.ListPrice*y.Factor,2)
FROM dwh.DimProduct p CROSS JOIN Y y
WHERE NOT EXISTS(SELECT 1 FROM dwh.FactPriceList x WHERE x.ProductKey=p.ProductKey AND x.ValidFrom=DATEFROMPARTS(y.Yr,1,1));
GO

