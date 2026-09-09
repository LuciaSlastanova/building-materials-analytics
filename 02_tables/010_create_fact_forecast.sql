USE BuildingMaterialsAnalytics;
GO
IF OBJECT_ID(N'dwh.FactForecast',N'U') IS NULL
BEGIN
 CREATE TABLE dwh.FactForecast
 (
  ForecastKey bigint IDENTITY(1,1) CONSTRAINT PK_FactForecast PRIMARY KEY,
  MonthDateKey int NOT NULL, ProductKey int NOT NULL, RegionKey tinyint NOT NULL,
  ForecastQuantity decimal(14,2) NOT NULL, ForecastRevenue decimal(14,2) NOT NULL,
  ForecastCost decimal(14,2) NOT NULL, ForecastVersion varchar(20) NOT NULL,
  SnapshotDate date NOT NULL,
  LoadedAt datetime2(0) NOT NULL CONSTRAINT DF_Forecast_LoadedAt DEFAULT(SYSDATETIME()),
  CONSTRAINT CK_Forecast_Qty CHECK(ForecastQuantity>=0),
  CONSTRAINT FK_Forecast_Date FOREIGN KEY(MonthDateKey) REFERENCES dwh.DimDate(DateKey),
  CONSTRAINT FK_Forecast_Product FOREIGN KEY(ProductKey) REFERENCES dwh.DimProduct(ProductKey),
  CONSTRAINT FK_Forecast_Region FOREIGN KEY(RegionKey) REFERENCES dwh.DimRegion(RegionKey),
  CONSTRAINT UQ_Forecast UNIQUE(MonthDateKey,ProductKey,RegionKey,ForecastVersion)
 );
END;
GO

