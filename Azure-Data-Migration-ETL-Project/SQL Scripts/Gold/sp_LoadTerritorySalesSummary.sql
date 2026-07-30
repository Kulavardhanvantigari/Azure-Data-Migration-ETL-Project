CREATE   PROCEDURE Gold.sp_LoadTerritorySalesSummary
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        TRUNCATE TABLE Gold.TerritorySalesSummary;

        INSERT INTO Gold.TerritorySalesSummary
        (
            TerritoryID,
            TotalOrders,
            TotalRevenue,
            AverageOrderValue
        )
        SELECT
            TerritoryID,
            COUNT(SalesOrderID),
            SUM(TotalDue),
            AVG(TotalDue)
        FROM Silver.FactSalesOrderHeader
        WHERE TerritoryID IS NOT NULL
        GROUP BY TerritoryID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;