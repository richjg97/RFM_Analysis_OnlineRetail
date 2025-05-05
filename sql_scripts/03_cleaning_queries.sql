-- Retrieve first 10 rows from the table
SELECT *
FROM online_retail_transactions
LIMIT 10;
-- Check table structure
DESCRIBE online_retail_transactions;
-- Count total rows
SELECT COUNT(*) AS TotalRows
FROM online_retail_transactions;
-- Calculate the total number of duplicate rows
SELECT SUM(duplicate_count - 1) AS total_duplicate_rows
FROM (
        SELECT COUNT(*) AS duplicate_count
        FROM online_retail_transactions
        GROUP BY InvoiceNo,
            StockCode,
            Description,
            Quantity,
            InvoiceDate,
            UnitPrice,
            CustomerID,
            Country
        HAVING COUNT(*) > 1
    ) AS subquery;
-- Display the first 25 duplicate transactions for review
SELECT InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    COUNT(*) AS DuplicateCount
FROM online_retail_transactions
GROUP BY InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
HAVING COUNT(*) > 1
LIMIT 25;
-- Check if a primary key exists in the table
SHOW KEYS
FROM online_retail_transactions
WHERE Key_name = 'PRIMARY';
-- Add a new column as a unique primary key for easier handling of duplicates
ALTER TABLE online_retail_transactions
ADD id INT AUTO_INCREMENT PRIMARY KEY;
-- Verify the primary key has been added
SHOW KEYS
FROM online_retail_transactions
WHERE Key_name = 'PRIMARY';
-- Get distinct duplicate counts for rows appearing more than once in the dataset
SELECT DISTINCT COUNT(*) AS duplicate_count
FROM online_retail_transactions
GROUP BY InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;
-- Remove duplicate rows while keeping one instance
WITH CTE AS (
    SELECT id,
        ROW_NUMBER() OVER (
            PARTITION BY InvoiceNo,
            StockCode,
            Description,
            Quantity,
            InvoiceDate,
            UnitPrice,
            CustomerID,
            Country
            ORDER BY InvoiceDate
        ) AS row_num
    FROM online_retail_transactions
)
DELETE FROM online_retail_transactions
WHERE id IN (
        SELECT id
        FROM CTE
        WHERE row_num > 1
    );
-- Verify no duplicate rows remain
SELECT InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    COUNT(*)
FROM online_retail_transactions
GROUP BY InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
HAVING COUNT(*) > 1;
-- Get the total number of rows in the cleaned dataset
SELECT COUNT(*) AS TotalRows
FROM online_retail_transactions;
-- Check for null values in key columns
SELECT COUNT(*) AS total_rows,
    SUM(
        CASE
            WHEN InvoiceNo IS NULL THEN 1
            ELSE 0
        END
    ) AS missing_invoices,
    SUM(
        CASE
            WHEN StockCode IS NULL THEN 1
            ELSE 0
        END
    ) AS missing_stock_codes,
    SUM(
        CASE
            WHEN Description IS NULL THEN 1
            ELSE 0
        END
    ) AS missing_descriptions,
    SUM(
        CASE
            WHEN Quantity IS NULL THEN 1
            ELSE 0
        END
    ) AS missing_quantities,
    SUM(
        CASE
            WHEN UnitPrice IS NULL THEN 1
            ELSE 0
        END
    ) AS missing_unit_prices,
    SUM(
        CASE
            WHEN CustomerID IS NULL THEN 1
            ELSE 0
        END
    ) AS missing_customers,
    SUM(
        CASE
            WHEN Country IS NULL THEN 1
            ELSE 0
        END
    ) AS missing_countries
FROM online_retail_transactions;
-- Retrieve all rows with missing (NULL) values in any of the key columns.
SELECT *
FROM online_retail_transactions
WHERE InvoiceNo IS NULL
    OR StockCode IS NULL
    OR Description IS NULL
    OR Quantity IS NULL
    OR UnitPrice IS NULL
    OR CustomerID IS NULL
    OR Country IS NULL;
-- Identify InvoiceNos with missing CustomerID but valid CustomerID in other rows, 
-- to assess the feasibility of imputing missing CustomerID values.
SELECT DISTINCT t1.InvoiceNo
FROM online_retail_transactions t1
    JOIN online_retail_transactions t2 ON t1.InvoiceNo = t2.InvoiceNo
WHERE t1.CustomerID IS NULL
    AND t2.CustomerID IS NOT NULL;
-- Delete rows with missing CostumerID
DELETE FROM online_retail_transactions
WHERE CustomerID IS NULL;
SELECT COUNT(*) AS total_rows_after_deletion
FROM online_retail_transactions;
SELECT COUNT(*) AS remaining_missing_customers
FROM online_retail_transactions
WHERE CustomerID IS NULL;
-- Retrieves all rows from the 'online_retail_transactions' table where the 'InvoiceNo' contains at least one alphabetic character. It also selects the 'InvoiceNo', 'UnitPrice', and 'Quantity' columns for further analysis.
SELECT InvoiceNo,
    UnitPrice,
    Quantity
FROM online_retail_transactions
WHERE InvoiceNo REGEXP '[A-Za-z]';
-- This query retrieves all rows where the 'StockCode' contains at least one alphabetic character.
-- It selects 'InvoiceNo', 'StockCode', 'Description', 'Quantity', and 'UnitPrice' for further analysis.
SELECT InvoiceNo,
    StockCode,
    Description,
    Quantity,
    UnitPrice
FROM online_retail_transactions
WHERE StockCode REGEXP '[A-Za-z]';
-- Identify postage rows 
SELECT *
FROM online_retail_transactions
WHERE Description LIKE '%Postage%';
-- Delete rows containing 'Postage' anywhere in the description
DELETE FROM online_retail_transactions
WHERE Description LIKE '%Postage%';
-- Identify Discount rows
SELECT *
FROM online_retail_transactions
WHERE Description LIKE '%Discount%';
-- Delete rows containing 'Discount' anywhere in the description
DELETE FROM online_retail_transactions
WHERE Description LIKE '%Discount%';
-- Identify all transactions with "Manual" in the description
SELECT *
FROM online_retail_transactions
WHERE Description LIKE '%Manual%';
-- Delete rows containing 'Manual' anywhere in the description
DELETE FROM online_retail_transactions
WHERE Description LIKE '%Manual%';
-- Identify remaining total rows after cleaning 
SELECT COUNT(*) AS TotalRows
FROM online_retail_transactions;
-- Rows with negative or zero quantities 
SELECT *
FROM online_retail_transactions
WHERE Quantity <= 0
LIMIT 10;
-- Rows with negative or 0 unit prices 
SELECT *
FROM online_retail_transactions
WHERE UnitPrice <= 0
LIMIT 10;
-- Count the number and percentage of rows where UnitPrice is 0
SELECT COUNT(*) AS ZeroPriceCount,
    COUNT(*) * 100.0 / (
        SELECT COUNT(*)
        FROM online_retail_transactions
    ) AS Percentage
FROM online_retail_transactions
WHERE UnitPrice = 0;
-- Retrieve details of transactions with UnitPrice set to 0
SELECT InvoiceNo,
    Description,
    Quantity,
    CustomerID,
    Country,
    UnitPrice
FROM online_retail_transactions
WHERE UnitPrice = 0;
-- Validate rows before deletion
SELECT *
FROM online_retail_transactions
WHERE UnitPrice = 0;
-- Delete rows where the UnitPrice is 0
DELETE FROM online_retail_transactions
WHERE UnitPrice = 0;
-- Remaining rows with '0' as the UnitPrice
SELECT COUNT(*) AS RemainingZeroPriceRows
FROM online_retail_transactions
WHERE UnitPrice = 0;
-- Delete rows with negative quantities
DELETE FROM online_retail_transactions
WHERE Quantity < 0;
SELECT COUNT(*) AS Remaining_Negative_Quantity_Rows
FROM online_retail_transactions
WHERE Quantity < 0;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Calculate Mean, Median, Mode, and Range for UnitPrice
WITH stats AS (
    SELECT -- Mean
        ROUND(AVG(UnitPrice), 2) AS UnitPrice_Mean,
        -- Median
        (
            SELECT ROUND(UnitPrice, 2)
            FROM (
                    SELECT UnitPrice,
                        ROW_NUMBER() OVER (
                            ORDER BY UnitPrice
                        ) AS row_num,
                        COUNT(*) OVER () AS total_rows
                    FROM online_retail_transactions
                ) AS ranked
            WHERE row_num IN (
                    FLOOR((total_rows + 1) / 2),
                    CEIL((total_rows + 1) / 2)
                )
            LIMIT 1
        ) AS UnitPrice_Median,
        -- Mode
        (
            SELECT UnitPrice
            FROM online_retail_transactions
            GROUP BY UnitPrice
            ORDER BY COUNT(*) DESC,
                UnitPrice ASC
            LIMIT 1
        ) AS UnitPrice_Mode,
        -- Range
        MAX(UnitPrice) - MIN(UnitPrice) AS UnitPrice_Range
    FROM online_retail_transactions
)
SELECT *
FROM stats;
-- Calculate Mean, Median, Mode, and Range for Quantity
WITH stats AS (
    SELECT -- Mean
        ROUND(AVG(Quantity), 2) AS Quantity_Mean,
        -- Median
        (
            SELECT ROUND(Quantity, 2)
            FROM (
                    SELECT Quantity,
                        ROW_NUMBER() OVER (
                            ORDER BY Quantity
                        ) AS row_num,
                        COUNT(*) OVER () AS total_rows
                    FROM online_retail_transactions
                ) AS ranked
            WHERE row_num IN (
                    FLOOR((total_rows + 1) / 2),
                    CEIL((total_rows + 1) / 2)
                )
            LIMIT 1
        ) AS Quantity_Median,
        -- Mode
        (
            SELECT Quantity
            FROM online_retail_transactions
            GROUP BY Quantity
            ORDER BY COUNT(*) DESC,
                Quantity ASC
            LIMIT 1
        ) AS Quantity_Mode,
        -- Range
        MAX(Quantity) - MIN(Quantity) AS Quantity_Range
    FROM online_retail_transactions
)
SELECT *
FROM stats;
-- Retrieve the full dataset from the online_retail_transactions table
SELECT *
FROM online_retail_transactions;
-- Show all high outliers for Quantity
SELECT *
FROM online_retail_transactions
WHERE Quantity > 27
ORDER BY Quantity DESC;
-- Show all high outliers for UnitPrice
SELECT *
FROM online_retail_transactions
WHERE UnitPrice > 7.5
ORDER BY UnitPrice DESC;
-- Group high Quantity outliers by Description to review legitimacy
SELECT Description,
    COUNT(*) AS NumOccurrences,
    MAX(Quantity) AS MaxQty
FROM online_retail_transactions
WHERE Quantity > 27
GROUP BY Description
ORDER BY MaxQty DESC;
-- ==========================================================
-- 📦 Flag high Quantity outliers: Delete, Review, Keep
-- ==========================================================
WITH quantity_outliers AS (
    SELECT Description,
        MAX(Quantity) AS MaxQty,
        COUNT(*) AS NumOccurrences,
        -- 🎯 Label each product with an action
        CASE
            WHEN MAX(Quantity) > 1000
            AND COUNT(*) = 1 THEN 'Delete'
            WHEN MAX(Quantity) BETWEEN 100 AND 1000
            AND COUNT(*) <= 2 THEN 'Review'
            ELSE 'Keep'
        END AS Action
    FROM online_retail_transactions
    WHERE Quantity > 27 -- 👈 Based on IQR upper fence
    GROUP BY Description
) -- ✅ Final SELECT to view the results
SELECT *
FROM quantity_outliers
ORDER BY CASE
        WHEN Action = 'Delete' THEN 1
        WHEN Action = 'Review' THEN 2
        ELSE 3
    END,
    MaxQty DESC;
DELETE FROM online_retail_transactions
WHERE Description = 'PAPER CRAFT , LITTLE BIRDIE'
    AND Quantity = 88995;
-- =====================================================
-- 📦 Step: Identify & Review High Quantity Outliers
-- Goal: View all transactions where Quantity is high
--       and the product was flagged as "Review"
-- =====================================================
-- Step 1: Label each product based on quantity outlier logic
WITH quantity_outliers AS (
    SELECT Description,
        MAX(Quantity) AS MaxQty,
        -- Highest quantity sold for that product
        COUNT(*) AS NumOccurrences,
        -- How many times it had high quantities
        -- 🎯 Label the product based on your outlier rules
        CASE
            WHEN MAX(Quantity) > 1000
            AND COUNT(*) = 1 THEN 'Delete'
            WHEN MAX(Quantity) BETWEEN 100 AND 1000
            AND COUNT(*) <= 2 THEN 'Review'
            ELSE 'Keep'
        END AS Action
    FROM online_retail_transactions
    WHERE Quantity > 27 -- Using IQR-based outlier threshold
    GROUP BY Description
) -- Step 2: Join back to your full dataset to see all rows where Action = 'Review'
SELECT t.*
FROM online_retail_transactions t
    JOIN quantity_outliers q ON t.Description = q.Description
WHERE q.Action = 'Review'
ORDER BY t.Quantity DESC;
-- So you see the highest quantities first
-- ===========================================================
-- 💸 Detect High UnitPrice Outliers and Recommend an Action
-- ===========================================================
WITH unitprice_outliers AS (
    SELECT Description,
        MAX(UnitPrice) AS MaxPrice,
        COUNT(*) AS NumOccurrences,
        -- 🎯 Assign action based on price + how often it occurs
        CASE
            WHEN MAX(UnitPrice) > 300
            AND COUNT(*) = 1 THEN 'Delete'
            WHEN MAX(UnitPrice) BETWEEN 50 AND 300
            AND COUNT(*) <= 2 THEN 'Review'
            ELSE 'Keep'
        END AS Action
    FROM online_retail_transactions
    WHERE UnitPrice > 7.5 -- Based on box plot threshold
    GROUP BY Description
) -- ✅ Step 2: Show all flagged results and sort by severity
SELECT *
FROM unitprice_outliers
ORDER BY CASE
        WHEN Action = 'Delete' THEN 1
        WHEN Action = 'Review' THEN 2
        ELSE 3
    END,
    MaxPrice DESC;