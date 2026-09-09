USE BuildingMaterialsAnalytics;
GO
IF OBJECT_ID(N'etl.DataQualityIssue',N'U') IS NULL
BEGIN
 CREATE TABLE etl.DataQualityIssue
 (
  DataQualityIssueKey bigint IDENTITY(1,1) CONSTRAINT PK_DataQualityIssue PRIMARY KEY,
  ETLBatchKey int NULL, SourceTable varchar(100) NOT NULL, SourceRowId int NULL,
  RuleCode varchar(40) NOT NULL, Severity varchar(10) NOT NULL,
  ColumnName varchar(100) NULL, InvalidValue nvarchar(200) NULL,
  IssueDescription nvarchar(500) NOT NULL,
  DetectedAt datetime2(0) NOT NULL CONSTRAINT DF_DQ_DetectedAt DEFAULT(SYSDATETIME()),
  ResolutionStatus varchar(20) NOT NULL CONSTRAINT DF_DQ_Status DEFAULT('OPEN'), ResolvedAt datetime2(0) NULL,
  CONSTRAINT CK_DQ_Severity CHECK(Severity IN('INFO','WARNING','ERROR')),
  CONSTRAINT CK_DQ_Status CHECK(ResolutionStatus IN('OPEN','IN_PROGRESS','RESOLVED','ACCEPTED')),
  CONSTRAINT FK_DQ_Batch FOREIGN KEY(ETLBatchKey) REFERENCES etl.ETLBatch(ETLBatchKey)
 );
END;
GO
