USE BuildingMaterialsAnalytics;
GO
CREATE OR ALTER FUNCTION dwh.fn_CalculateMargin
(@Revenue decimal(14,2),@CostAmount decimal(14,2))
RETURNS decimal(14,2)
AS
BEGIN
 RETURN COALESCE(@Revenue,0)-COALESCE(@CostAmount,0);
END;
GO

