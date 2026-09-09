USE BuildingMaterialsAnalytics;
GO
CREATE OR ALTER PROCEDURE etl.usp_LoadValidPriceList @ImportFileName varchar(100)
AS
BEGIN
 SET NOCOUNT ON; SET XACT_ABORT ON;
 BEGIN TRY
  BEGIN TRANSACTION;
  INSERT dwh.FactPriceList(ProductKey,ValidFrom,ValidTo,ListPrice,CurrencyCode,SourceSystem)
  SELECT p.ProductKey,CONVERT(date,s.ValidFromText),DATEFROMPARTS(YEAR(CONVERT(date,s.ValidFromText)),12,31),s.NewListPrice,s.CurrencyCode,'CSV_IMPORT'
  FROM stg.PriceListImport s JOIN dwh.DimProduct p ON p.ProductCode=s.ProductCode
  WHERE s.ImportFileName=@ImportFileName AND s.ProcessingStatus IN('VALID','WARNING')
  AND NOT EXISTS(SELECT 1 FROM dwh.FactPriceList f WHERE f.ProductKey=p.ProductKey AND f.ValidFrom=CONVERT(date,s.ValidFromText));
  UPDATE stg.PriceListImport SET ProcessingStatus='LOADED' WHERE ImportFileName=@ImportFileName AND ProcessingStatus IN('VALID','WARNING');
  COMMIT TRANSACTION;
 END TRY
 BEGIN CATCH
  IF @@TRANCOUNT>0 ROLLBACK TRANSACTION;
  THROW;
 END CATCH;
END;
GO

