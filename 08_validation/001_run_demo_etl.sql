USE BuildingMaterialsAnalytics;
GO
EXEC etl.usp_ValidatePriceListImport @ImportFileName='PriceList_2027.csv';
EXEC etl.usp_LoadValidPriceList @ImportFileName='PriceList_2027.csv';
GO

