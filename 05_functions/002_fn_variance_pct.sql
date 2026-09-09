USE BuildingMaterialsAnalytics;
GO
CREATE OR ALTER FUNCTION dwh.fn_VariancePct
(@Actual decimal(18,2),@Plan decimal(18,2))
RETURNS decimal(9,2)
AS
BEGIN
 RETURN CAST(CASE WHEN COALESCE(@Plan,0)=0 THEN NULL ELSE(@Actual-@Plan)/@Plan*100 END AS decimal(9,2));
END;
GO

