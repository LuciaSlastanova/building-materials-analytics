USE BuildingMaterialsAnalytics;
GO
INSERT dwh.DimProductCategory(CategoryCode,CategoryName,MarginTargetPct)
SELECT v.CategoryCode,v.CategoryName,v.MarginTargetPct
FROM (VALUES
 ('PLASTER',N'Omietky',31.00),('SCREED',N'Potery',27.00),('ADHESIVE',N'Lepidlá a stierky',34.00),
 ('ETICS',N'Zatepľovacie systémy',29.00),('FACADE',N'Fasádne omietky a farby',36.00),
 ('MORTAR',N'Murovacie malty',25.00)
)v(CategoryCode,CategoryName,MarginTargetPct)
WHERE NOT EXISTS(SELECT 1 FROM dwh.DimProductCategory x WHERE x.CategoryCode=v.CategoryCode);
GO

