CREATE   PROCEDURE Gold.sp_LoadProductSalesSummary
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        TRUNCATE TABLE Gold.ProductSalesSummary;

        INSERT INTO Gold.ProductSalesSummary
        (
            ProductID,
            ProductName,
            TotalQuantitySold,
            TotalRevenue
        )
        SELECT
            P.ProductID,
            P.Name AS ProductName,
            SUM(D.OrderQty) AS TotalQuantitySold,
            SUM(D.LineTotal) AS TotalRevenue
        FROM Silver.FactSalesOrderDetail 
        INNER JOIN Silver.DimProduct 
            ON D.ProductID = P.ProductID
        GROUP BY
            P.ProductID,
            P.Name;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;