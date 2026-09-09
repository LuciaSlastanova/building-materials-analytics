USE BuildingMaterialsAnalytics;
GO
IF OBJECT_ID(N'dwh.FactCRMOpportunity',N'U') IS NULL
BEGIN
 CREATE TABLE dwh.FactCRMOpportunity
 (
  OpportunityKey bigint IDENTITY(1,1) CONSTRAINT PK_CRMOpportunity PRIMARY KEY,
  SalesforceOppId varchar(18) NOT NULL CONSTRAINT UQ_CRMOpportunity_Id UNIQUE,
  OpportunityName nvarchar(150) NOT NULL, CustomerKey int NOT NULL,
  ProductCategoryKey tinyint NOT NULL, SalesRepKey smallint NOT NULL,
  CreatedDateKey int NOT NULL, ExpectedCloseDateKey int NOT NULL, ClosedDateKey int NULL,
  StageName varchar(30) NOT NULL, ProbabilityPct tinyint NOT NULL,
  ExpectedRevenue decimal(14,2) NOT NULL,
  WeightedRevenue AS(ExpectedRevenue*ProbabilityPct/100.0) PERSISTED,
  LeadSource varchar(30) NOT NULL, IsWon bit NOT NULL CONSTRAINT DF_CRM_IsWon DEFAULT(0),
  IsClosed bit NOT NULL CONSTRAINT DF_CRM_IsClosed DEFAULT(0),
  LoadedAt datetime2(0) NOT NULL CONSTRAINT DF_CRM_LoadedAt DEFAULT(SYSDATETIME()),
  CONSTRAINT CK_CRM_Probability CHECK(ProbabilityPct BETWEEN 0 AND 100),
  CONSTRAINT CK_CRM_Revenue CHECK(ExpectedRevenue>=0),
  CONSTRAINT FK_CRM_Customer FOREIGN KEY(CustomerKey) REFERENCES dwh.DimCustomer(CustomerKey),
  CONSTRAINT FK_CRM_Category FOREIGN KEY(ProductCategoryKey) REFERENCES dwh.DimProductCategory(ProductCategoryKey),
  CONSTRAINT FK_CRM_SalesRep FOREIGN KEY(SalesRepKey) REFERENCES dwh.DimSalesRepresentative(SalesRepKey),
  CONSTRAINT FK_CRM_CreatedDate FOREIGN KEY(CreatedDateKey) REFERENCES dwh.DimDate(DateKey),
  CONSTRAINT FK_CRM_ExpectedDate FOREIGN KEY(ExpectedCloseDateKey) REFERENCES dwh.DimDate(DateKey),
  CONSTRAINT FK_CRM_ClosedDate FOREIGN KEY(ClosedDateKey) REFERENCES dwh.DimDate(DateKey)
 );
END;
GO

