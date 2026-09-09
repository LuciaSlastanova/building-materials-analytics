USE BuildingMaterialsAnalytics;
GO
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name='IX_FactSales_Date_Product_Region' AND object_id=OBJECT_ID('dwh.FactSales'))
 CREATE INDEX IX_FactSales_Date_Product_Region ON dwh.FactSales(DateKey,ProductKey,RegionKey) INCLUDE(Quantity,Revenue,CostAmount,DiscountPct);
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name='IX_FactSales_Customer' AND object_id=OBJECT_ID('dwh.FactSales'))
 CREATE INDEX IX_FactSales_Customer ON dwh.FactSales(CustomerKey) INCLUDE(DateKey,ProductKey,Revenue,GrossMargin);
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name='IX_FactBudget_Month_Product_Region' AND object_id=OBJECT_ID('dwh.FactBudget'))
 CREATE INDEX IX_FactBudget_Month_Product_Region ON dwh.FactBudget(MonthDateKey,ProductKey,RegionKey) INCLUDE(BudgetQuantity,BudgetRevenue,BudgetCost);
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name='IX_FactForecast_Version_Month' AND object_id=OBJECT_ID('dwh.FactForecast'))
 CREATE INDEX IX_FactForecast_Version_Month ON dwh.FactForecast(ForecastVersion,MonthDateKey,ProductKey,RegionKey) INCLUDE(ForecastQuantity,ForecastRevenue,ForecastCost);
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name='IX_CRM_Stage_CloseDate' AND object_id=OBJECT_ID('dwh.FactCRMOpportunity'))
 CREATE INDEX IX_CRM_Stage_CloseDate ON dwh.FactCRMOpportunity(StageName,ExpectedCloseDateKey) INCLUDE(CustomerKey,ExpectedRevenue,ProbabilityPct,IsWon);
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name='IX_DQ_Status_Severity' AND object_id=OBJECT_ID('etl.DataQualityIssue'))
 CREATE INDEX IX_DQ_Status_Severity ON etl.DataQualityIssue(ResolutionStatus,Severity) INCLUDE(RuleCode,SourceTable,DetectedAt);
GO

