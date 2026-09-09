USE BuildingMaterialsAnalytics;
GO
IF OBJECT_ID(N'dwh.FactPriceList',N'U') IS NULL
BEGIN
 CREATE TABLE dwh.FactPriceList
 (
  PriceListKey bigint IDENTITY(1,1) CONSTRAINT PK_FactPriceList PRIMARY KEY,
  ProductKey int NOT NULL, ValidFrom date NOT NULL, ValidTo date NOT NULL,
  ListPrice decimal(12,2) NOT NULL, CurrencyCode char(3) NOT NULL CONSTRAINT DF_Price_Currency DEFAULT('EUR'),
  SourceSystem varchar(20) NOT NULL CONSTRAINT DF_Price_Source DEFAULT('ERP'),
  LoadedAt datetime2(0) NOT NULL CONSTRAINT DF_Price_LoadedAt DEFAULT(SYSDATETIME()),
  CONSTRAINT FK_Price_Product FOREIGN KEY(ProductKey) REFERENCES dwh.DimProduct(ProductKey),
  CONSTRAINT UQ_Price_ProductDate UNIQUE(ProductKey,ValidFrom),
  CONSTRAINT CK_Price_Value CHECK(ListPrice>0),
  CONSTRAINT CK_Price_Dates CHECK(ValidTo>=ValidFrom)
 );
END;
GO

