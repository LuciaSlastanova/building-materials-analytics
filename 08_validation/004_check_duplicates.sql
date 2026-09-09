USE BuildingMaterialsAnalytics;
GO
SELECT InvoiceNumber,ProductKey,COUNT(*)DuplicateCount FROM dwh.FactSales
GROUP BY InvoiceNumber,ProductKey HAVING COUNT(*)>1;
SELECT MonthDateKey,ProductKey,RegionKey,BudgetVersion,COUNT(*)DuplicateCount FROM dwh.FactBudget
GROUP BY MonthDateKey,ProductKey,RegionKey,BudgetVersion HAVING COUNT(*)>1;
SELECT SalesforceOppId,COUNT(*)DuplicateCount FROM dwh.FactCRMOpportunity
GROUP BY SalesforceOppId HAVING COUNT(*)>1;
GO

