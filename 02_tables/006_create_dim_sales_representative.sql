USE BuildingMaterialsAnalytics;
GO
IF OBJECT_ID(N'dwh.DimSalesRepresentative',N'U') IS NULL
BEGIN
 CREATE TABLE dwh.DimSalesRepresentative
 (
  SalesRepKey smallint IDENTITY(1,1) CONSTRAINT PK_DimSalesRep PRIMARY KEY,
  EmployeeCode varchar(10) NOT NULL CONSTRAINT UQ_SalesRep_Code UNIQUE,
  FullName nvarchar(80) NOT NULL, RegionKey tinyint NOT NULL,
  TeamName nvarchar(30) NOT NULL, HireDate date NOT NULL,
  IsActive bit NOT NULL CONSTRAINT DF_SalesRep_IsActive DEFAULT(1),
  CONSTRAINT FK_SalesRep_Region FOREIGN KEY(RegionKey) REFERENCES dwh.DimRegion(RegionKey)
 );
END;
GO
