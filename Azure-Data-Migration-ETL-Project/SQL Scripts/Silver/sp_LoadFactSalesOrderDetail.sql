CREATE   PROCEDURE Silver.sp_LoadFactSalesOrderDetail
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        MERGE Silver.FactSalesOrderDetail AS Target

        USING
        (
            SELECT DISTINCT
                SalesOrderID,
                SalesOrderDetailID,
                NULLIF(LTRIM(RTRIM(CarrierTrackingNumber)), '') AS CarrierTrackingNumber,
                OrderQty,
                ProductID,
                SpecialOfferID,
                UnitPrice,
               UnitPriceDiscount,
                LineTotal,
                ModifiedDate
            FROM dbo.SalesOrderDetail
        ) AS Source

        ON Target.SalesOrderID = Source.SalesOrderID
        AND Target.SalesOrderDetailID = Source.SalesOrderDetailID

        WHEN MATCHED
        AND Target.ModifiedDate <> Source.ModifiedDate

        THEN UPDATE SET

            CarrierTrackingNumber = Source.CarrierTrackingNumber,
            OrderQty = Source.OrderQty,
            ProductID = Source.ProductID,
           SpecialOfferID = Source.SpecialOfferID,
            UnitPrice = Source.UnitPrice,
            UnitPriceDiscount = Source.UnitPriceDiscount,
            LineTotal = Source.LineTotal,
            ModifiedDate = Source.ModifiedDate

        WHEN NOT MATCHED BY TARGET

        THEN INSERT
        (
            SalesOrderID,
            SalesOrderDetailID,
            CarrierTrackingNumber,
            OrderQty,
            ProductID,
            SpecialOfferID,
            UnitPrice,
            UnitPriceDiscount,
            LineTotal,
            ModifiedDate
        )

        VALUES
        (
            Source.SalesOrderID,
            Source.SalesOrderDetailID,
            Source.CarrierTrackingNumber,
            Source.OrderQty,
            Source.ProductID,
            Source.SpecialOfferID,
            Source.UnitPrice,
            Source.UnitPriceDiscount,
            Source.LineTotal,
            Source.ModifiedDate
        );

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH

       IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH
END;