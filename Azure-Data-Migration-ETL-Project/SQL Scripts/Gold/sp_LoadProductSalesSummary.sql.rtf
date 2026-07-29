{\rtf1\ansi\ansicpg1252\cocoartf2870
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 CREATE   PROCEDURE Gold.sp_LoadProductSalesSummary\
AS\
BEGIN\
    SET NOCOUNT ON;\
\
    BEGIN TRY\
        BEGIN TRANSACTION;\
\
        TRUNCATE TABLE Gold.ProductSalesSummary;\
\
        INSERT INTO Gold.ProductSalesSummary\
        (\
            ProductID,\
            ProductName,\
            TotalQuantitySold,\
            TotalRevenue\
        )\
        SELECT\
            P.ProductID,\
            P.Name AS ProductName,\
            SUM(D.OrderQty) AS TotalQuantitySold,\
            SUM(D.LineTotal) AS TotalRevenue\
        FROM Silver.FactSalesOrderDetail D\
        INNER JOIN Silver.DimProduct P\
            ON D.ProductID = P.ProductID\
        GROUP BY\
            P.ProductID,\
            P.Name;\
\
        COMMIT TRANSACTION;\
    END TRY\
    BEGIN CATCH\
        IF @@TRANCOUNT > 0\
            ROLLBACK TRANSACTION;\
\
        THROW;\
    END CATCH\
END;}