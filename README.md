# Building Materials Analytics

Portfolio project demonstrating the design of an MS SQL data warehouse and an interactive Power BI dashboard for a building materials company.

> Work in progress – the project is being developed continuously.

## Project goals

- Design a relational data warehouse in Microsoft SQL Server
- Create reusable T-SQL scripts for database deployment
- Model sales, budget, forecast, CRM and price-list data
- Implement ETL logging and data-quality controls
- Build an interactive Power BI management dashboard

## Technologies

- Microsoft SQL Server
- T-SQL
- SQL Server Management Studio
- Power BI Desktop
- Power Query
- DAX
- Git and GitHub

## Data model

The solution uses a star-schema-inspired model.

### Dimension tables

- `DimDate`
- `DimRegion`
- `DimProductCategory`
- `DimProduct`
- `DimCustomer`
- `DimSalesRepresentative`

### Fact tables

- `FactSales`
- `FactBudget`
- `FactForecast`
- `FactPriceList`
- `FactCRMOpportunity`

### ETL and data quality

- `ETLBatch`
- `DataQualityIssue`
- `PriceListImport`

## Current dataset

- 12,000 sales records
- 6,912 budget records
- 6,912 forecast records
- 1,000 CRM opportunities
- 120 customers
- 24 products
- 8 regions
- Calendar data from 2024 to 2027

## Power BI dashboard

The current report contains:

- Actual revenue
- Budget revenue
- Budget variance
- Budget achievement
- Gross margin
- Gross margin percentage
- Monthly sales development
- Sales by region
- Revenue share by product category
- Interactive year filtering

## Repository structure

```text
sql/          T-SQL database deployment scripts
power-bi/     Power BI report
screenshots/  Dashboard and data-model previews
docs/         Project documentation

## Planned development

- ETL and data-quality monitoring page
- CRM opportunity analysis
- Forecast accuracy analysis
- Automated data refresh
- Additional technical documentation
