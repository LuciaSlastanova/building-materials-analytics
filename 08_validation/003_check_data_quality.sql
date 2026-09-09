USE BuildingMaterialsAnalytics;
GO
SELECT * FROM rpt.vw_DataQualityDashboard ORDER BY Severity,RuleCode;
SELECT TOP(20)*FROM rpt.vw_BudgetForecastActual ORDER BY MonthDate,ProductCode,RegionCode;
SELECT TOP(20)*FROM rpt.vw_CRMPipeline ORDER BY ExpectedCloseDate DESC;
GO

