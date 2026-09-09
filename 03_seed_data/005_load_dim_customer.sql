USE BuildingMaterialsAnalytics;
GO
;WITH N AS(SELECT TOP(120) ROW_NUMBER()OVER(ORDER BY(SELECT NULL))n FROM sys.all_objects),
S AS
(
 SELECT n,CONCAT('001SK',RIGHT(REPLICATE('0',13)+CONVERT(varchar(13),n),13)) SalesforceId,
 CONCAT('CUS-',RIGHT('0000'+CONVERT(varchar(4),n),4)) CustomerCode,
 CONCAT(CHOOSE(((n-1)%6)+1,N'Stavomarket',N'ProfiBuild',N'DomStav',N'Renova',N'Fasáda',N'MuroTech'),N' ',RIGHT('000'+CONVERT(varchar(3),n),3),N' s.r.o.')CustomerName,
 CHOOSE(((n-1)%4)+1,N'Stavebniny',N'Realizačná firma',N'Developer',N'Veľkoobchod')CustomerType,
 CHOOSE(((n-1)%8)+1,'BA','TT','TN','NR','ZA','BB','PO','KE')RegionCode,
 CHOOSE(((n-1)%16)+1,N'Bratislava',N'Trnava',N'Trenčín',N'Nitra',N'Žilina',N'Banská Bystrica',N'Prešov',N'Košice',N'Malacky',N'Piešťany',N'Prievidza',N'Nové Zámky',N'Martin',N'Zvolen',N'Poprad',N'Michalovce')City
 FROM N
)
INSERT dwh.DimCustomer(SalesforceId,CustomerCode,CustomerName,CustomerType,RegionKey,City,CreditLimit,CustomerSegment,CreatedDate,IsActive)
SELECT s.SalesforceId,s.CustomerCode,s.CustomerName,s.CustomerType,r.RegionKey,s.City,
 CONVERT(decimal(14,2),15000+((s.n*7919)%85000)),CASE WHEN s.n%10 IN(0,1)THEN'A' WHEN s.n%3=0 THEN'B' ELSE'C'END,
 DATEADD(day,-((s.n*37)%1200),CONVERT(date,'20240101')),IIF(s.n IN(37,89,113),0,1)
FROM S s JOIN dwh.DimRegion r ON r.RegionCode=s.RegionCode
WHERE NOT EXISTS(SELECT 1 FROM dwh.DimCustomer x WHERE x.CustomerCode=s.CustomerCode);
GO

