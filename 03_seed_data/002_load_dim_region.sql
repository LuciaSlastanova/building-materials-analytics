USE BuildingMaterialsAnalytics;
GO
INSERT dwh.DimRegion(RegionCode,RegionName,SalesArea,PopulationBand)
SELECT v.RegionCode,v.RegionName,v.SalesArea,v.PopulationBand
FROM (VALUES
 ('BA',N'Bratislavský',N'Západ','High'),('TT',N'Trnavský',N'Západ','Medium'),
 ('TN',N'Trenčiansky',N'Západ','Medium'),('NR',N'Nitriansky',N'Západ','Medium'),
 ('ZA',N'Žilinský',N'Stred','Medium'),('BB',N'Banskobystrický',N'Stred','Medium'),
 ('PO',N'Prešovský',N'Východ','High'),('KE',N'Košický',N'Východ','High')
)v(RegionCode,RegionName,SalesArea,PopulationBand)
WHERE NOT EXISTS(SELECT 1 FROM dwh.DimRegion x WHERE x.RegionCode=v.RegionCode);
GO

