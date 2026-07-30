CREATE PROCEDURE Silver.sp_LoadDimCustomer
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        MERGE Silver.DimCustomer AS Target

        USING
        (
            SELECT DISTINCT
                CustomerID,
                PersonID,
                StoreID,
                TerritoryID,
                LTRIM(RTRIM(AccountNumber)) AS AccountNumber,
                ModifiedDate
            FROM dbo.SalesCustomer
        ) AS Source

        ON Target.CustomerID = Source.CustomerID

        WHEN MATCHED
        AND Target.ModifiedDate <> Source.ModifiedDate

        THEN UPDATE SET

            PersonID = Source.PersonID,
            StoreID = Source.StoreID,
            TerritoryID = Source.TerritoryID,
            AccountNumber = Source.AccountNumber,
            ModifiedDate = Source.ModifiedDate

        WHEN NOT MATCHED BY TARGET

        THEN INSERT
        (
            CustomerID,
            PersonID,
            StoreID,
            TerritoryID,
            AccountNumber,
            ModifiedDate
        )

        VALUES
        (
            Source.CustomerID,
            Source.PersonID,
            Source.StoreID,
            Source.TerritoryID,
            Source.AccountNumber,
            Source.ModifiedDate
        );

    END TRY

    BEGIN CATCH

        THROW;

    END CATCH

END;