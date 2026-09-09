USE BuildingMaterialsAnalytics;
GO
INSERT dwh.DimProduct(ProductCode,ProductName,ProductCategoryKey,UnitOfMeasure,PackageWeightKg,StandardCost,ListPrice,ValidFrom)
SELECT v.ProductCode,v.ProductName,c.ProductCategoryKey,v.UnitOfMeasure,v.PackageWeightKg,v.StandardCost,v.ListPrice,'20240101'
FROM (VALUES
 ('OM-001',N'Jadrová omietka Standard 25 kg','PLASTER','bag',25,5.10,8.20),
 ('OM-002',N'Vápennocementová omietka 40 kg','PLASTER','bag',40,6.90,10.90),
 ('OM-003',N'Strojová omietka Plus 35 kg','PLASTER','bag',35,7.40,11.80),
 ('OM-004',N'Sanačná omietka 25 kg','PLASTER','bag',25,10.90,17.40),
 ('PO-001',N'Cementový poter 25 kg','SCREED','bag',25,4.80,7.10),
 ('PO-002',N'Samonivelizačný poter 25 kg','SCREED','bag',25,11.20,16.50),
 ('PO-003',N'Rýchlotuhnúci poter 25 kg','SCREED','bag',25,13.50,19.90),
 ('PO-004',N'Anhydritový poter 40 kg','SCREED','bag',40,8.30,12.10),
 ('LE-001',N'Lepidlo na obklad Flex 25 kg','ADHESIVE','bag',25,7.80,12.60),
 ('LE-002',N'Lepiaca stierka Profi 25 kg','ADHESIVE','bag',25,6.20,10.30),
 ('LE-003',N'Lepidlo EPS 25 kg','ADHESIVE','bag',25,5.70,9.40),
 ('LE-004',N'Lepidlo Minerál 25 kg','ADHESIVE','bag',25,7.10,11.70),
 ('ET-001',N'EPS fasádna doska 100 mm','ETICS','m2',NULL,8.90,12.90),
 ('ET-002',N'Minerálna doska 100 mm','ETICS','m2',NULL,15.80,22.50),
 ('ET-003',N'Kotva fasádna 160 mm','ETICS','pcs',NULL,0.21,0.38),
 ('ET-004',N'Sklotextilná mriežka 50 m2','ETICS','roll',NULL,28.00,43.50),
 ('FA-001',N'Silikónová omietka 25 kg','FACADE','bucket',25,32.00,51.00),
 ('FA-002',N'Silikátová omietka 25 kg','FACADE','bucket',25,28.50,46.00),
 ('FA-003',N'Fasádna farba 14 l','FACADE','bucket',NULL,38.00,62.00),
 ('FA-004',N'Penetračný náter 10 l','FACADE','bucket',NULL,18.00,29.50),
 ('MA-001',N'Murovacia malta 25 kg','MORTAR','bag',25,4.10,6.20),
 ('MA-002',N'Tenkovrstvová malta 25 kg','MORTAR','bag',25,5.60,8.50),
 ('MA-003',N'Zakladacia malta 25 kg','MORTAR','bag',25,6.00,9.20),
 ('MA-004',N'Tepelnoizolačná malta 25 kg','MORTAR','bag',25,9.20,14.50)
)v(ProductCode,ProductName,CategoryCode,UnitOfMeasure,PackageWeightKg,StandardCost,ListPrice)
JOIN dwh.DimProductCategory c ON c.CategoryCode=v.CategoryCode
WHERE NOT EXISTS(SELECT 1 FROM dwh.DimProduct x WHERE x.ProductCode=v.ProductCode);
GO

