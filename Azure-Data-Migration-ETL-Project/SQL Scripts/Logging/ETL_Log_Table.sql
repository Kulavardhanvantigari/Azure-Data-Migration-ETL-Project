CREATE TABLE dbo.ETL_Log
(
    LogID INT IDENTITY(1,1) PRIMARY KEY,

    PipelineName NVARCHAR(200),

    ProcedureName NVARCHAR(200),

    TableName NVARCHAR(200),

    Status NVARCHAR(50),

    StartTime DATETIME2,

    EndTime DATETIME2,

    DurationSeconds INT,

    ErrorMessage NVARCHAR(MAX),

    CreatedDate DATETIME2 DEFAULT GETDATE()
);