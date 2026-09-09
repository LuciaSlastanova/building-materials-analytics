USE BuildingMaterialsAnalytics;
GO
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name=N'dwh') EXEC(N'CREATE SCHEMA dwh');
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name=N'stg') EXEC(N'CREATE SCHEMA stg');
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name=N'etl') EXEC(N'CREATE SCHEMA etl');
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name=N'rpt') EXEC(N'CREATE SCHEMA rpt');
GO

