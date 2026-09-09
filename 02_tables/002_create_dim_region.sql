USE BuildingMaterialsAnalytics;
GO
IF OBJECT_ID(N'dwh.DimRegion',N'U') IS NULL
BEGIN
 CREATE TABLE dwh.DimRegion
 (
  RegionKey tinyint IDENTITY(1,1) CONSTRAINT PK_DimRegion PRIMARY KEY,
  RegionCode char(2) NOT NULL CONSTRAINT UQ_DimRegion_Code UNIQUE,
  RegionName nvarchar(40) NOT NULL, SalesArea nvarchar(20) NOT NULL,
  PopulationBand varchar(10) NOT NULL
 );
END;
GO

