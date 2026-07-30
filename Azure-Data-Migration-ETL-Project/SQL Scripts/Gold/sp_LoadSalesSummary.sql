CREATE   PROCEDURE Gold.sp_LoadSalesSummary
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM Gold.SalesSummary
        WHERE SummaryDate = CAST(GETDATE() AS DATE);

        INSERT INTO Gold.SalesSummary
        (
            SummaryDate,
            TotalOrders,
            TotalCustomers,
            TotalRevenue,
            AverageOrderValue
        )
        SELECT
            CAST(GETDATE() AS DATE),
            COUNT(DISTINCT SalesOrderID),
            COUNT(DISTINCT CustomerID),
            SUM(TotalDue),
            AVG(TotalDue)
        FROM Silver.FactSalesOrderHeader;

        COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;