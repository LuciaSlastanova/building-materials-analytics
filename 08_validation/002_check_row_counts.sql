USE BuildingMaterialsAnalytics;
GO
SELECT 'DimDate'TableName,COUNT_BIG(*)RowCount FROM dwh.DimDate
UNION ALL SELECT'DimRegion',COUNT_BIG(*)FROM dwh.DimRegion
UNION ALL SELECT'DimProductCategory',COUNT_BIG(*)FROM dwh.DimProductCategory
UNION ALL SELECT'DimProduct',COUNT_BIG(*)FROM dwh.DimProduct
UNION ALL SELECT'DimCustomer',COUNT_BIG(*)FROM dwh.DimCustomer
UNION ALL SELECT'DimSalesRepresentative',COUNT_BIG(*)FROM dwh.DimSalesRepresentative
UNION ALL SELECT'FactPriceList',COUNT_BIG(*)FROM dwh.FactPriceList
UNION ALL SELECT'FactSales',COUNT_BIG(*)FROM dwh.FactSales
UNION ALL SELECT'FactBudget',COUNT_BIG(*)FROM dwh.FactBudget
UNION ALL SELECT'FactForecast',COUNT_BIG(*)FROM dwh.FactForecast
UNION ALL SELECT'FactCRMOpportunity',COUNT_BIG(*)FROM dwh.FactCRMOpportunity
UNION ALL SELECT'PriceListImport',COUNT_BIG(*)FROM stg.PriceListImport
UNION ALL SELECT'ETLBatch',COUNT_BIG(*)FROM etl.ETLBatch
UNION ALL SELECT'DataQualityIssue',COUNT_BIG(*)FROM etl.DataQualityIssue;
GO

