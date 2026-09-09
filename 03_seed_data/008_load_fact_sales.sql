USE BuildingMaterialsAnalytics;
GO
;WITH N AS
(
 SELECT TOP(12000)ROW_NUMBER()OVER(ORDER BY a.object_id,b.object_id)n
 FROM sys.all_objects a CROSS JOIN sys.all_objects b
),B AS
(
 SELECT n,DATEADD(day,(n*17)%974,CONVERT(date,'20240101'))SaleDate,
 ((n*7-1)%24)+1 ProductNo,((n*13-1)%120)+1 CustomerNo,
 CONVERT(decimal(12,2),10+((n*29)%240))Quantity,
 CONVERT(decimal(5,2),CHOOSE((n%6)+1,0,3,5,7.5,10,12.5))DiscountPct FROM N
),R AS
(
 SELECT b.*,p.ProductKey,p.ListPrice,p.StandardCost,c.CustomerKey,c.RegionKey
 FROM B b JOIN dwh.DimProduct p ON p.ProductKey=b.ProductNo
 JOIN dwh.DimCustomer c ON c.CustomerKey=b.CustomerNo
)
INSERT dwh.FactSales(InvoiceNumber,DateKey,ProductKey,CustomerKey,RegionKey,SalesRepKey,SalesChannel,Quantity,UnitPrice,DiscountPct,Revenue,CostAmount)
SELECT CONCAT('INV-',YEAR(r.SaleDate),'-',RIGHT('000000'+CONVERT(varchar(6),r.n),6)),
 CONVERT(int,CONVERT(char(8),r.SaleDate,112)),r.ProductKey,r.CustomerKey,r.RegionKey,sr.SalesRepKey,
 CHOOSE((r.n%4)+1,'Direct','Distributor','E-shop','Project'),r.Quantity,
 ROUND(r.ListPrice*CASE YEAR(r.SaleDate)WHEN 2024 THEN .91 WHEN 2025 THEN .96 ELSE 1 END,2),r.DiscountPct,
 ROUND(r.Quantity*r.ListPrice*CASE YEAR(r.SaleDate)WHEN 2024 THEN .91 WHEN 2025 THEN .96 ELSE 1 END*(1-r.DiscountPct/100.0),2),
 ROUND(r.Quantity*r.StandardCost*(1+(YEAR(r.SaleDate)-2024)*.025),2)
FROM R r
JOIN dwh.DimSalesRepresentative sr ON sr.EmployeeCode=
 CASE r.RegionKey WHEN 1 THEN IIF(r.n%2=0,'SR001','SR002') WHEN 2 THEN'SR003'
  WHEN 3 THEN'SR004' WHEN 4 THEN'SR005' WHEN 5 THEN'SR006' WHEN 6 THEN'SR007'
  WHEN 7 THEN'SR008' ELSE IIF(r.n%2=0,'SR009','SR010') END
WHERE NOT EXISTS(SELECT 1 FROM dwh.FactSales x WHERE x.InvoiceNumber=CONCAT('INV-',YEAR(r.SaleDate),'-',RIGHT('000000'+CONVERT(varchar(6),r.n),6)));
GO
