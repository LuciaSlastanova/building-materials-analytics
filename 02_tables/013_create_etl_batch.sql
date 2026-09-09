USE BuildingMaterialsAnalytics;
GO
IF OBJECT_ID(N'etl.ETLBatch',N'U') IS NULL
BEGIN
 CREATE TABLE etl.ETLBatch
 (
  ETLBatchKey int IDENTITY(1,1) CONSTRAINT PK_ETLBatch PRIMARY KEY,
  ProcessName varchar(80) NOT NULL, SourceFileName varchar(150) NULL,
  StartTime datetime2(0) NOT NULL, EndTime datetime2(0) NULL,
  Status varchar(20) NOT NULL, RowsRead int NOT NULL CONSTRAINT DF_ETL_Read DEFAULT(0),
  RowsInserted int NOT NULL CONSTRAINT DF_ETL_Inserted DEFAULT(0),
  RowsRejected int NOT NULL CONSTRAINT DF_ETL_Rejected DEFAULT(0), ErrorMessage nvarchar(1000) NULL,
  CONSTRAINT CK_ETL_Status CHECK(Status IN('RUNNING','SUCCESS','WARNING','FAILED'))
 );
END;
GO

