USE BuildingMaterialsAnalytics;
GO
;WITH N AS(SELECT TOP(1000)ROW_NUMBER()OVER(ORDER BY a.object_id,b.object_id)n FROM sys.all_objects a CROSS JOIN sys.all_objects b),
B AS(SELECT n,DATEADD(day,(n*11)%850,CONVERT(date,'20240101'))CreatedDate,
 CHOOSE((n%6)+1,'Prospecting','Qualification','Proposal','Negotiation','Closed Won','Closed Lost')StageName FROM N),
C AS(SELECT *,DATEADD(day,20+(n*7)%100,CreatedDate)ExpectedCloseDate,
 CASE StageName WHEN'Prospecting'THEN 10 WHEN'Qualification'THEN 25 WHEN'Proposal'THEN 50 WHEN'Negotiation'THEN 75 WHEN'Closed Won'THEN 100 ELSE 0 END ProbabilityPct FROM B)
INSERT dwh.FactCRMOpportunity(SalesforceOppId,OpportunityName,CustomerKey,ProductCategoryKey,SalesRepKey,CreatedDateKey,ExpectedCloseDateKey,ClosedDateKey,StageName,ProbabilityPct,ExpectedRevenue,LeadSource,IsWon,IsClosed)
SELECT CONCAT('006SK',RIGHT(REPLICATE('0',13)+CONVERT(varchar(13),c.n),13)),CONCAT(N'Projekt ',RIGHT('0000'+CONVERT(varchar(4),c.n),4)),
 cu.CustomerKey,pc.ProductCategoryKey,sr.SalesRepKey,CONVERT(int,CONVERT(char(8),c.CreatedDate,112)),CONVERT(int,CONVERT(char(8),c.ExpectedCloseDate,112)),
 CASE WHEN c.StageName IN('Closed Won','Closed Lost')THEN CONVERT(int,CONVERT(char(8),c.ExpectedCloseDate,112))END,
 c.StageName,c.ProbabilityPct,CONVERT(decimal(14,2),2500+((c.n*3571)%97500)),
 CHOOSE((c.n%5)+1,'Website','Sales Representative','Trade Fair','Referral','Campaign'),IIF(c.StageName='Closed Won',1,0),IIF(c.StageName IN('Closed Won','Closed Lost'),1,0)
FROM C c JOIN dwh.DimCustomer cu ON cu.CustomerKey=((c.n*13-1)%120)+1
JOIN dwh.DimProductCategory pc ON pc.ProductCategoryKey=((c.n*5-1)%6)+1
JOIN dwh.DimSalesRepresentative sr ON sr.SalesRepKey=((c.n-1)%10)+1
WHERE NOT EXISTS(SELECT 1 FROM dwh.FactCRMOpportunity x WHERE x.SalesforceOppId=CONCAT('006SK',RIGHT(REPLICATE('0',13)+CONVERT(varchar(13),c.n),13)));
GO

