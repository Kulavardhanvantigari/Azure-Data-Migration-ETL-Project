CREATE   PROCEDURE Silver.sp_LoadDimProductCategory
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        MERGE Silver.DimProductCategory AS Target

        USING
        (
            SELECT DISTINCT
                ProductCategoryID,
                LTRIM(RTRIM(Name)) AS Name,
                ModifiedDate
            FROM dbo.ProductCategory
        ) AS Source

        ON Target.ProductCategoryID = Source.ProductCategoryID

        WHEN MATCHED
        AND Target.ModifiedDate <> Source.ModifiedDate

        THEN UPDATE SET

            Name = Source.Name,
            ModifiedDate = Source.ModifiedDate

        WHEN NOT MATCHED BY TARGET

        THEN INSERT
        (
            ProductCategoryID,
            Name,
            ModifiedDate
        )

        VALUES
        (
            Source.ProductCategoryID,
            Source.Name,
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