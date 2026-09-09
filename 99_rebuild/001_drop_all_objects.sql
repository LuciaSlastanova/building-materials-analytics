/* POZOR: Iba DEV/TEST. Tento skript vymaže všetky objekty projektu a ich dáta. */
USE BuildingMaterialsAnalytics;
GO
DROP VIEW IF EXISTS rpt.vw_DataQualityDashboard;
DROP VIEW IF EXISTS rpt.vw_CRMPipeline;
DROP VIEW IF EXISTS rpt.vw_BudgetForecastActual;
DROP VIEW IF EXISTS rpt.vw_MonthlyActual;
DROP VIEW IF EXISTS rpt.vw_SalesDetail;
GO
DROP PROCEDURE IF EXISTS etl.usp_LoadValidPriceList;
DROP PROCEDURE IF EXISTS etl.usp_ValidatePriceListImport;
GO
DROP FUNCTION IF EXISTS dwh.fn_VariancePct;
DROP FUNCTION IF EXISTS dwh.fn_CalculateMargin;
GO
DROP TABLE IF EXISTS etl.DataQualityIssue;
DROP TABLE IF EXISTS dwh.FactCRMOpportunity;
DROP TABLE IF EXISTS dwh.FactForecast;
DROP TABLE IF EXISTS dwh.FactBudget;
DROP TABLE IF EXISTS dwh.FactSales;
DROP TABLE IF EXISTS dwh.FactPriceList;
DROP TABLE IF EXISTS stg.PriceListImport;
DROP TABLE IF EXISTS etl.ETLBatch;
DROP TABLE IF EXISTS dwh.DimSalesRepresentative;
DROP TABLE IF EXISTS dwh.DimCustomer;
DROP TABLE IF EXISTS dwh.DimProduct;
DROP TABLE IF EXISTS dwh.DimProductCategory;
DROP TABLE IF EXISTS dwh.DimRegion;
DROP TABLE IF EXISTS dwh.DimDate;
GO
