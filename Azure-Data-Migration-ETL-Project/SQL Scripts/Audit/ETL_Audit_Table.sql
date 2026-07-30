CREATE TABLE dbo.ETL_Audit
(
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    PipelineName NVARCHAR(200),
    SourceTable NVARCHAR(200),
    TargetTable NVARCHAR(200),
    RowsProcessed INT,
    RowsInserted INT,
    RowsUpdated INT,
    RowsDeleted INT,
    ExecutionStatus NVARCHAR(50),
    ExecutionTime DATETIME2 DEFAULT GETDATE(),
    Remarks NVARCHAR(MAX)
);
