CREATE   PROCEDURE Silver.sp_LoadDimProduct
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        MERGE Silver.DimProduct AS Target

        USING
        (
            SELECT DISTINCT
                ProductID,
                LTRIM(RTRIM(Name)) AS Name,
                LTRIM(RTRIM(ProductNumber)) AS ProductNumber,
                NULLIF(LTRIM(RTRIM(Color)), '') AS Color,
                StandardCost,
                ListPrice,
                ProductSubcategoryID,
                ModifiedDate
            FROM dbo.Product
        ) AS Source

        ON Target.ProductID = Source.ProductID

        WHEN MATCHED
        AND Target.ModifiedDate <> Source.ModifiedDate

        THEN UPDATE SET

            Name = Source.Name,
            ProductNumber = Source.ProductNumber,
            Color = Source.Color,
            StandardCost = Source.StandardCost,
            ListPrice = Source.ListPrice,
            ProductSubcategoryID = Source.ProductSubcategoryID,
            ModifiedDate = Source.ModifiedDate

        WHEN NOT MATCHED BY TARGET

        THEN INSERT
        (
            ProductID,
            Name,
            ProductNumber,
            Color,
            StandardCost,
            ListPrice,
            ProductSubcategoryID,
            ModifiedDate
        )

        VALUES
        (
            Source.ProductID,
            Source.Name,
            Source.ProductNumber,
            Source.Color,
            Source.StandardCost,
            Source.ListPrice,
            Source.ProductSubcategoryID,
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