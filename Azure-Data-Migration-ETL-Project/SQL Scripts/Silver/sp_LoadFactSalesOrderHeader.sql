CREATE   PROCEDURE Silver.sp_LoadFactSalesOrderHeader
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        MERGE Silver.FactSalesOrderHeader AS Target

        USING
        (
            SELECT DISTINCT
                SalesOrderID,
                OrderDate,
                DueDate,
                ShipDate,
                Status,
                OnlineOrderFlag,
                LTRIM(RTRIM(SalesOrderNumber)) AS SalesOrderNumber,
                NULLIF(LTRIM(RTRIM(PurchaseOrderNumber)), '') AS PurchaseOrderNumber,
                NULLIF(LTRIM(RTRIM(AccountNumber)), '') AS AccountNumber,
                CustomerID,
                SalesPersonID,
                TerritoryID,
                BillToAddressID,
                ShipToAddressID,
                ShipMethodID,
                CreditCardID,
                CurrencyRateID,
                SubTotal,
                TaxAmt,
                Freight,
                TotalDue,
                ModifiedDate
            FROM dbo.SalesOrderHeader
        ) AS Source

        ON Target.SalesOrderID = Source.SalesOrderID

        WHEN MATCHED
        AND Target.ModifiedDate <> Source.ModifiedDate

        THEN UPDATE SET

            OrderDate = Source.OrderDate,
            DueDate = Source.DueDate,
            ShipDate = Source.ShipDate,
            Status = Source.Status,
            OnlineOrderFlag = Source.OnlineOrderFlag,
            SalesOrderNumber = Source.SalesOrderNumber,
            PurchaseOrderNumber = Source.PurchaseOrderNumber,
            AccountNumber = Source.AccountNumber,
            CustomerID = Source.CustomerID,
            SalesPersonID = Source.SalesPersonID,
            TerritoryID = Source.TerritoryID,
            BillToAddressID = Source.BillToAddressID,
            ShipToAddressID = Source.ShipToAddressID,
            ShipMethodID = Source.ShipMethodID,
            CreditCardID = Source.CreditCardID,
            CurrencyRateID = Source.CurrencyRateID,
            SubTotal = Source.SubTotal,
           TaxAmt = Source.TaxAmt,
            Freight = Source.Freight,
            TotalDue = Source.TotalDue,
            ModifiedDate = Source.ModifiedDate

        WHEN NOT MATCHED BY TARGET

        THEN INSERT
        (
            SalesOrderID,
            OrderDate,
            DueDate,
            ShipDate,
            Status,
            OnlineOrderFlag,
            SalesOrderNumber,
            PurchaseOrderNumber,
            AccountNumber,
            CustomerID,
            SalesPersonID,
            TerritoryID,
            BillToAddressID,
            ShipToAddressID,
            ShipMethodID,
            CreditCardID,
            CurrencyRateID,
            SubTotal,
            TaxAmt,
            Freight,
            TotalDue,
            ModifiedDate
        )

        VALUES
        (
            Source.SalesOrderID,
            Source.OrderDate,
            Source.DueDate,
            Source.ShipDate,
            Source.Status,
            Source.OnlineOrderFlag,
            Source.SalesOrderNumber,
            Source.PurchaseOrderNumber,
            Source.AccountNumber,
            Source.CustomerID,
            Source.SalesPersonID,
            Source.TerritoryID,
            Source.BillToAddressID,
            Source.ShipToAddressID,
            Source.ShipMethodID,
            Source.CreditCardID,
            Source.CurrencyRateID,
            Source.SubTotal,
            Source.TaxAmt,
            Source.Freight,
            Source.TotalDue,
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