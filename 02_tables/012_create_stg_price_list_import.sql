USE BuildingMaterialsAnalytics;
GO
IF OBJECT_ID(N'stg.PriceListImport',N'U') IS NULL
BEGIN
 CREATE TABLE stg.PriceListImport
 (
  ImportRowId int IDENTITY(1,1) CONSTRAINT PK_PriceListImport PRIMARY KEY,
  ImportFileName varchar(100) NOT NULL, ProductCode varchar(20) NULL,
  ProductName nvarchar(100) NULL, NewListPrice decimal(12,2) NULL,
  ValidFromText varchar(20) NULL, CurrencyCode varchar(5) NULL,
  ImportedAt datetime2(0) NOT NULL CONSTRAINT DF_Import_ImportedAt DEFAULT(SYSDATETIME()),
  ProcessingStatus varchar(20) NOT NULL CONSTRAINT DF_Import_Status DEFAULT('NEW')
 );
END;
GO

