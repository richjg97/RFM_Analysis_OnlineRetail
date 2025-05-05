-- 01_create_tables.sql
-- This script creates the 'online_retail_transactions' table for analysis.
-- It includes fields related to customer transactions from an online retail dataset.
-- Dataset source: [UCI Machine Learning Repository – Online Retail II]
USE online_retail_ii;
CREATE TABLE online_retail_transactions (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description TEXT,
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(15, 4),
    -- Monetary precision
    CustomerID VARCHAR(20),
    Country VARCHAR(50)
);
-- Note: No primary key defined due to duplicate invoices or items in raw data.
-- Consider indexing on InvoiceDate or CustomerID for performance.