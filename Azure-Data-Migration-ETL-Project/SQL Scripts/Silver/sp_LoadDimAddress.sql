CREATE   PROCEDURE Silver.sp_LoadDimAddress
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        MERGE Silver.DimAddress AS Target

        USING
        (
            SELECT DISTINCT
                AddressID,
                LTRIM(RTRIM(AddressLine1)) AS AddressLine1,
                NULLIF(LTRIM(RTRIM(AddressLine2)), '') AS AddressLine2,
                LTRIM(RTRIM(City)) AS City,
                StateProvinceID,
                LTRIM(RTRIM(PostalCode)) AS PostalCode,
                SpatialLocation,
                ModifiedDate
            FROM dbo.Address
        ) AS Source

        ON Target.AddressID = Source.AddressID

        WHEN MATCHED
        AND Target.ModifiedDate <> Source.ModifiedDate

        THEN UPDATE SET


            AddressLine1 = Source.AddressLine1,
            AddressLine2 = Source.AddressLine2,
            City = Source.City,
            StateProvinceID = Source.StateProvinceID,
            PostalCode = Source.PostalCode,
            SpatialLocation = Source.SpatialLocation,
            ModifiedDate = Source.ModifiedDate

        WHEN NOT MATCHED BY TARGET

        THEN INSERT
        (
            AddressID,
            AddressLine1,
            AddressLine2,
            City,
            StateProvinceID,
            PostalCode,
            SpatialLocation,
            ModifiedDate
        )

        VALUES
        (
            Source.AddressID,
            Source.AddressLine1,
            Source.AddressLine2,
            Source.City,
            Source.StateProvinceID,
            Source.PostalCode,
            Source.SpatialLocation,
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