USE BuildingMaterialsAnalytics;
GO
IF NOT EXISTS(SELECT 1 FROM stg.PriceListImport WHERE ImportFileName='PriceList_2027.csv')
BEGIN
 INSERT stg.PriceListImport(ImportFileName,ProductCode,ProductName,NewListPrice,ValidFromText,CurrencyCode)
 SELECT 'PriceList_2027.csv',ProductCode,ProductName,ROUND(ListPrice*1.035,2),'2027-01-01','EUR' FROM dwh.DimProduct;
 INSERT stg.PriceListImport(ImportFileName,ProductCode,ProductName,NewListPrice,ValidFromText,CurrencyCode)
 VALUES('PriceList_2027.csv','OM-001',N'Duplicitná položka',8.49,'2027-01-01','EUR'),
 ('PriceList_2027.csv','XX-999',N'Neznámy produkt',19.99,'2027-01-01','EUR'),
 ('PriceList_2027.csv',NULL,N'Chýbajúci kód',12.50,'2027-01-01','EUR'),
 ('PriceList_2027.csv','LE-002',N'Nulová cena',0,'2027-01-01','EUR'),
 ('PriceList_2027.csv','ET-003',N'Nesprávny dátum',.42,'31.02.2027','EUR'),
 ('PriceList_2027.csv','FA-004',N'Nesprávna mena',31.20,'2027-01-01','USD');
END;
GO

