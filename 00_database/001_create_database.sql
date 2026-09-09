USE master;
GO
IF DB_ID(N'BuildingMaterialsAnalytics') IS NULL
BEGIN
    CREATE DATABASE BuildingMaterialsAnalytics;
END;
GO
ALTER DATABASE BuildingMaterialsAnalytics SET RECOVERY SIMPLE;
GO

