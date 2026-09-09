USE BuildingMaterialsAnalytics;
GO
IF OBJECT_ID(N'dwh.DimCustomer',N'U') IS NULL
BEGIN
 CREATE TABLE dwh.DimCustomer
 (
  CustomerKey int IDENTITY(1,1) CONSTRAINT PK_DimCustomer PRIMARY KEY,
  SalesforceId varchar(18) NOT NULL CONSTRAINT UQ_Customer_SalesforceId UNIQUE,
  CustomerCode varchar(20) NOT NULL CONSTRAINT UQ_Customer_Code UNIQUE,
  CustomerName nvarchar(120) NOT NULL, CustomerType nvarchar(40) NOT NULL,
  RegionKey tinyint NOT NULL, City nvarchar(60) NOT NULL,
  CreditLimit decimal(14,2) NOT NULL, CustomerSegment char(1) NOT NULL,
  CreatedDate date NOT NULL, IsActive bit NOT NULL CONSTRAINT DF_Customer_IsActive DEFAULT(1),
  CONSTRAINT CK_Customer_Credit CHECK(CreditLimit>=0),
  CONSTRAINT CK_Customer_Segment CHECK(CustomerSegment IN('A','B','C')),
  CONSTRAINT FK_Customer_Region FOREIGN KEY(RegionKey) REFERENCES dwh.DimRegion(RegionKey)
 );
END;
GO

