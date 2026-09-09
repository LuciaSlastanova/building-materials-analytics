USE BuildingMaterialsAnalytics;
GO
INSERT dwh.DimSalesRepresentative(EmployeeCode,FullName,RegionKey,TeamName,HireDate)
SELECT v.EmployeeCode,v.FullName,r.RegionKey,v.TeamName,v.HireDate
FROM(VALUES
 ('SR001',N'Martin Novák','BA',N'Západ',CONVERT(date,'20190301')),('SR002',N'Jana Kováčová','BA',N'Západ','20210615'),
 ('SR003',N'Peter Horváth','TT',N'Západ','20180510'),('SR004',N'Lucia Vargová','TN',N'Západ','20220201'),
 ('SR005',N'Tomáš Baláž','NR',N'Západ','20200920'),('SR006',N'Mária Poláková','ZA',N'Stred','20170411'),
 ('SR007',N'Andrej Kováč','BB',N'Stred','20230110'),('SR008',N'Zuzana Tóthová','PO',N'Východ','20181105'),
 ('SR009',N'Michal Hudec','KE',N'Východ','20210322'),('SR010',N'Veronika Urbanová','KE',N'Východ','20240501')
)v(EmployeeCode,FullName,RegionCode,TeamName,HireDate)
JOIN dwh.DimRegion r ON r.RegionCode=v.RegionCode
WHERE NOT EXISTS(SELECT 1 FROM dwh.DimSalesRepresentative x WHERE x.EmployeeCode=v.EmployeeCode);
GO
