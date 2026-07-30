 CREATE   PROCEDURE Gold.sp_LoadMonthlySalesSummary
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        TRUNCATE TABLE Gold.MonthlySalesSummary;

        INSERT INTO Gold.MonthlySalesSummary
        (
            SalesYear,
            SalesMonth,
            TotalOrders,
            TotalRevenue,
            AverageOrderValue
        )
        SELECT
            YEAR(OrderDate) AS SalesYear,
            MONTH(OrderDate) AS SalesMonth,
            COUNT(DISTINCT SalesOrderID) AS TotalOrders,
            SUM(TotalDue) AS TotalRevenue,
            AVG(TotalDue) AS AverageOrderValue
        FROM Silver.FactSalesOrderHeader
        GROUP BY
            YEAR(OrderDate),
            MONTH(OrderDate);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;