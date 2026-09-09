USE BuildingMaterialsAnalytics;
GO
IF OBJECT_ID(N'dwh.DimProductCategory',N'U') IS NULL
BEGIN
 CREATE TABLE dwh.DimProductCategory
 (
  ProductCategoryKey tinyint IDENTITY(1,1) CONSTRAINT PK_DimProductCategory PRIMARY KEY,
  CategoryCode varchar(10) NOT NULL CONSTRAINT UQ_DimProductCategory_Code UNIQUE,
  CategoryName nvarchar(60) NOT NULL,
  MarginTargetPct decimal(5,2) NOT NULL CONSTRAINT CK_Category_Margin CHECK(MarginTargetPct BETWEEN 0 AND 100),
  IsActive bit NOT NULL CONSTRAINT DF_Category_IsActive DEFAULT(1)
 );
END;
GO

