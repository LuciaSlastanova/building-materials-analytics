USE BuildingMaterialsAnalytics;
GO
CREATE OR ALTER VIEW rpt.vw_DataQualityDashboard AS
SELECT q.DataQualityIssueKey,q.SourceTable,q.SourceRowId,q.RuleCode,q.Severity,q.ColumnName,q.InvalidValue,
q.IssueDescription,q.DetectedAt,q.ResolutionStatus,b.ProcessName,b.SourceFileName,b.Status ETLStatus
FROM etl.DataQualityIssue q LEFT JOIN etl.ETLBatch b ON b.ETLBatchKey=q.ETLBatchKey;
GO
