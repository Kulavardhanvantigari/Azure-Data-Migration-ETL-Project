CREATE TABLE dbo.Watermark
(
    TableName NVARCHAR(200) PRIMARY KEY,

    LastLoadDate DATETIME2,

    LastModifiedDate DATETIME2,

    LastRunStatus NVARCHAR(50),

    UpdatedOn DATETIME2 DEFAULT GETDATE()
);