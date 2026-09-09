USE BuildingMaterialsAnalytics;
GO
CREATE OR ALTER PROCEDURE etl.usp_ValidatePriceListImport @ImportFileName varchar(100)
AS
BEGIN
 SET NOCOUNT ON; SET XACT_ABORT ON;
 DECLARE @BatchKey int;
 INSERT etl.ETLBatch(ProcessName,SourceFileName,StartTime,Status,RowsRead)
 SELECT 'Validate Price List',@ImportFileName,SYSDATETIME(),'RUNNING',COUNT(*) FROM stg.PriceListImport WHERE ImportFileName=@ImportFileName;
 SET @BatchKey=SCOPE_IDENTITY();
 BEGIN TRY
  DELETE q FROM etl.DataQualityIssue q JOIN stg.PriceListImport s ON s.ImportRowId=q.SourceRowId
  WHERE q.SourceTable='stg.PriceListImport' AND s.ImportFileName=@ImportFileName;
  INSERT etl.DataQualityIssue(ETLBatchKey,SourceTable,SourceRowId,RuleCode,Severity,ColumnName,InvalidValue,IssueDescription)
  SELECT @BatchKey,'stg.PriceListImport',s.ImportRowId,v.RuleCode,v.Severity,v.ColumnName,v.InvalidValue,v.Description
  FROM stg.PriceListImport s CROSS APPLY
  (
   SELECT 'PRODUCT_CODE_REQUIRED','ERROR','ProductCode',CONVERT(nvarchar(200),s.ProductCode),N'Kód produktu je povinný.' WHERE s.ProductCode IS NULL
   UNION ALL SELECT 'UNKNOWN_PRODUCT','ERROR','ProductCode',s.ProductCode,N'Produkt nie je v master dátach.' WHERE s.ProductCode IS NOT NULL AND NOT EXISTS(SELECT 1 FROM dwh.DimProduct p WHERE p.ProductCode=s.ProductCode)
   UNION ALL SELECT 'INVALID_PRICE','ERROR','NewListPrice',CONVERT(nvarchar(200),s.NewListPrice),N'Cena musí byť väčšia ako nula.' WHERE s.NewListPrice IS NULL OR s.NewListPrice<=0
   UNION ALL SELECT 'INVALID_DATE','ERROR','ValidFromText',s.ValidFromText,N'Dátum nie je platný.' WHERE TRY_CONVERT(date,s.ValidFromText)IS NULL
   UNION ALL SELECT 'INVALID_CURRENCY','WARNING','CurrencyCode',s.CurrencyCode,N'Očakáva sa mena EUR.' WHERE s.CurrencyCode<>'EUR'
   UNION ALL SELECT 'DUPLICATE_PRODUCT','ERROR','ProductCode',s.ProductCode,N'Produkt je v súbore duplicitný.' WHERE s.ProductCode IS NOT NULL AND(SELECT COUNT(*)FROM stg.PriceListImport x WHERE x.ImportFileName=s.ImportFileName AND x.ProductCode=s.ProductCode)>1
  )v(RuleCode,Severity,ColumnName,InvalidValue,Description) WHERE s.ImportFileName=@ImportFileName;
  UPDATE s SET ProcessingStatus=CASE WHEN EXISTS(SELECT 1 FROM etl.DataQualityIssue q WHERE q.ETLBatchKey=@BatchKey AND q.SourceRowId=s.ImportRowId AND q.Severity='ERROR')THEN'REJECTED'
  WHEN EXISTS(SELECT 1 FROM etl.DataQualityIssue q WHERE q.ETLBatchKey=@BatchKey AND q.SourceRowId=s.ImportRowId)THEN'WARNING' ELSE'VALID'END
  FROM stg.PriceListImport s WHERE s.ImportFileName=@ImportFileName;
  UPDATE etl.ETLBatch SET EndTime=SYSDATETIME(),RowsRejected=(SELECT COUNT(*)FROM stg.PriceListImport WHERE ImportFileName=@ImportFileName AND ProcessingStatus='REJECTED'),
  Status=CASE WHEN EXISTS(SELECT 1 FROM stg.PriceListImport WHERE ImportFileName=@ImportFileName AND ProcessingStatus='REJECTED')THEN'WARNING' ELSE'SUCCESS'END WHERE ETLBatchKey=@BatchKey;
 END TRY
 BEGIN CATCH
  UPDATE etl.ETLBatch SET EndTime=SYSDATETIME(),Status='FAILED',ErrorMessage=ERROR_MESSAGE()WHERE ETLBatchKey=@BatchKey;
  THROW;
 END CATCH;
END;
GO

