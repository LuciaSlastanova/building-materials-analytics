USE BuildingMaterialsAnalytics;
GO
IF NOT EXISTS(SELECT 1 FROM etl.ETLBatch WHERE ProcessName='Initial Demo Load')
INSERT etl.ETLBatch(ProcessName,SourceFileName,StartTime,EndTime,Status,RowsRead,RowsInserted,RowsRejected)
VALUES('Initial Demo Load','generated_demo_data','20260901 06:00','20260901 06:15','SUCCESS',27000,27000,0);
GO
