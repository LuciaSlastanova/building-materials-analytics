USE BuildingMaterialsAnalytics;
GO
IF OBJECT_ID(N'dwh.DimProduct',N'U') IS NULL
BEGIN
 CREATE TABLE dwh.DimProduct
 (
  ProductKey int IDENTITY(1,1) CONSTRAINT PK_DimProduct PRIMARY KEY,
  ProductCode varchar(20) NOT NULL CONSTRAINT UQ_DimProduct_Code UNIQUE,
  ProductName nvarchar(100) NOT NULL, ProductCategoryKey tinyint NOT NULL,
  UnitOfMeasure varchar(10) NOT NULL, PackageWeightKg decimal(8,2) NULL,
  StandardCost decimal(12,2) NOT NULL, ListPrice decimal(12,2) NOT NULL,
  ValidFrom date NOT NULL, ValidTo date NULL,
  IsActive bit NOT NULL CONSTRAINT DF_Product_IsActive DEFAULT(1),
  CONSTRAINT CK_Product_Cost CHECK(StandardCost>0),
  CONSTRAINT CK_Product_Price CHECK(ListPrice>=StandardCost),
  CONSTRAINT FK_Product_Category FOREIGN KEY(ProductCategoryKey)
   REFERENCES dwh.DimProductCategory(ProductCategoryKey)
 );
END;
GO

