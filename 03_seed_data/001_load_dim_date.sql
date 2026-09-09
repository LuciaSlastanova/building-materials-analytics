USE BuildingMaterialsAnalytics;
GO
;WITH Dates AS
(
 SELECT CONVERT(date,'20240101') FullDate
 UNION ALL SELECT DATEADD(day,1,FullDate) FROM Dates WHERE FullDate<'20271231'
)
INSERT dwh.DimDate(DateKey,FullDate,[Year],QuarterNumber,QuarterName,MonthNumber,MonthName,YearMonth,DayOfMonth,DayOfWeekNumber,DayName,IsWeekend)
SELECT CONVERT(int,CONVERT(char(8),x.FullDate,112)),x.FullDate,YEAR(x.FullDate),DATEPART(quarter,x.FullDate),
 CONCAT('Q',DATEPART(quarter,x.FullDate)),MONTH(x.FullDate),
 CHOOSE(MONTH(x.FullDate),N'Január',N'Február',N'Marec',N'Apríl',N'Máj',N'Jún',N'Júl',N'August',N'September',N'Október',N'November',N'December'),
 CONVERT(char(7),x.FullDate,126),DAY(x.FullDate),((DATEDIFF(day,'19000101',x.FullDate)%7)+1),
 CHOOSE(((DATEDIFF(day,'19000101',x.FullDate)%7)+1),N'Pondelok',N'Utorok',N'Streda',N'Štvrtok',N'Piatok',N'Sobota',N'Nedeľa'),
 IIF(((DATEDIFF(day,'19000101',x.FullDate)%7)+1) IN(6,7),1,0)
FROM Dates x WHERE NOT EXISTS(SELECT 1 FROM dwh.DimDate d WHERE d.FullDate=x.FullDate)
OPTION(MAXRECURSION 2000);
GO

