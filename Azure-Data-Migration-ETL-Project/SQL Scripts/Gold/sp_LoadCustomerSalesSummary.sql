CREATE   PROCEDURE Gold.sp_LoadCustomerSalesSummary
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        TRUNCATE TABLE Gold.CustomerSalesSummary;

        INSERT INTO Gold.CustomerSalesSummary
        (
            CustomerID,
            AccountNumber,
            TotalOrders,
            TotalRevenue,
            LastOrderDate
        )
        SELECT
            CustomerID,
            AccountNumber,
            COUNT(SalesOrderID) AS TotalOrders,
            SUM(TotalDue) AS TotalRevenue,
            MAX(OrderDate) AS LastOrderDate
        FROM Silver.FactSalesOrderHeader
        GROUP BY
            CustomerID,
            AccountNumber;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;