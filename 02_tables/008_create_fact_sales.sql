USE BuildingMaterialsAnalytics;
GO
IF OBJECT_ID(N'dwh.FactSales',N'U') IS NULL
BEGIN
 CREATE TABLE dwh.FactSales
 (
  SalesKey bigint IDENTITY(1,1) CONSTRAINT PK_FactSales PRIMARY KEY,
  InvoiceNumber varchar(20) NOT NULL, DateKey int NOT NULL, ProductKey int NOT NULL,
  CustomerKey int NOT NULL, RegionKey tinyint NOT NULL, SalesRepKey smallint NOT NULL,
  SalesChannel varchar(20) NOT NULL, Quantity decimal(12,2) NOT NULL,
  UnitPrice decimal(12,2) NOT NULL, DiscountPct decimal(5,2) NOT NULL,
  Revenue decimal(14,2) NOT NULL, CostAmount decimal(14,2) NOT NULL,
  GrossMargin AS(Revenue-CostAmount) PERSISTED,
  SourceSystem varchar(20) NOT NULL CONSTRAINT DF_Sales_Source DEFAULT('ERP'),
  LoadedAt datetime2(0) NOT NULL CONSTRAINT DF_Sales_LoadedAt DEFAULT(SYSDATETIME()),
  CONSTRAINT UQ_Sales_InvoiceLine UNIQUE(InvoiceNumber,ProductKey),
  CONSTRAINT CK_Sales_Qty CHECK(Quantity>0), CONSTRAINT CK_Sales_UnitPrice CHECK(UnitPrice>0),
  CONSTRAINT CK_Sales_Discount CHECK(DiscountPct BETWEEN 0 AND 40),
  CONSTRAINT FK_Sales_Date FOREIGN KEY(DateKey) REFERENCES dwh.DimDate(DateKey),
  CONSTRAINT FK_Sales_Product FOREIGN KEY(ProductKey) REFERENCES dwh.DimProduct(ProductKey),
  CONSTRAINT FK_Sales_Customer FOREIGN KEY(CustomerKey) REFERENCES dwh.DimCustomer(CustomerKey),
  CONSTRAINT FK_Sales_Region FOREIGN KEY(RegionKey) REFERENCES dwh.DimRegion(RegionKey),
  CONSTRAINT FK_Sales_SalesRep FOREIGN KEY(SalesRepKey) REFERENCES dwh.DimSalesRepresentative(SalesRepKey)
 );
END;
GO

