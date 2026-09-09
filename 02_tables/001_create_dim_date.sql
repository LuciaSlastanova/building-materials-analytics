USE BuildingMaterialsAnalytics;
GO
IF OBJECT_ID(N'dwh.DimDate',N'U') IS NULL
BEGIN
 CREATE TABLE dwh.DimDate
 (
  DateKey int NOT NULL CONSTRAINT PK_DimDate PRIMARY KEY,
  FullDate date NOT NULL CONSTRAINT UQ_DimDate_FullDate UNIQUE,
  [Year] smallint NOT NULL, QuarterNumber tinyint NOT NULL, QuarterName varchar(2) NOT NULL,
  MonthNumber tinyint NOT NULL, MonthName nvarchar(20) NOT NULL, YearMonth char(7) NOT NULL,
  DayOfMonth tinyint NOT NULL, DayOfWeekNumber tinyint NOT NULL,
  DayName nvarchar(20) NOT NULL, IsWeekend bit NOT NULL
 );
END;
GO

