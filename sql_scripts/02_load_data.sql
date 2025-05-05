-- Loads retail transaction data from CSV into the 'online_retail_transactions' table.
-- CSV must be placed in MySQL's secure 'Uploads' folder.
USE online_retail_ii;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/online_retail_final.csv' INTO TABLE online_retail_transactions FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS (
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
);