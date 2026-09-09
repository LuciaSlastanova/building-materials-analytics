USE BuildingMaterialsAnalytics;
GO
IF OBJECT_ID(N'dwh.FactBudget',N'U') IS NULL
BEGIN
 CREATE TABLE dwh.FactBudget
 (
  BudgetKey bigint IDENTITY(1,1) CONSTRAINT PK_FactBudget PRIMARY KEY,
  MonthDateKey int NOT NULL, ProductKey int NOT NULL, RegionKey tinyint NOT NULL,
  BudgetQuantity decimal(14,2) NOT NULL, BudgetRevenue decimal(14,2) NOT NULL,
  BudgetCost decimal(14,2) NOT NULL, BudgetVersion varchar(20) NOT NULL,
  LoadedAt datetime2(0) NOT NULL CONSTRAINT DF_Budget_LoadedAt DEFAULT(SYSDATETIME()),
  CONSTRAINT CK_Budget_Qty CHECK(BudgetQuantity>=0), CONSTRAINT CK_Budget_Revenue CHECK(BudgetRevenue>=0),
  CONSTRAINT CK_Budget_Cost CHECK(BudgetCost>=0),
  CONSTRAINT FK_Budget_Date FOREIGN KEY(MonthDateKey) REFERENCES dwh.DimDate(DateKey),
  CONSTRAINT FK_Budget_Product FOREIGN KEY(ProductKey) REFERENCES dwh.DimProduct(ProductKey),
  CONSTRAINT FK_Budget_Region FOREIGN KEY(RegionKey) REFERENCES dwh.DimRegion(RegionKey),
  CONSTRAINT UQ_Budget UNIQUE(MonthDateKey,ProductKey,RegionKey,BudgetVersion)
 );
END;
GO

