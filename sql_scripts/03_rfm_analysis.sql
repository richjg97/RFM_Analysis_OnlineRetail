-- Create the RFM view (✅ datetime-safe)
CREATE VIEW rfm_scores AS
SELECT CustomerID,
    DATEDIFF('2011-12-10', MAX(InvoiceDate)) AS Recency,
    -- Replace with max date if needed
    COUNT(DISTINCT InvoiceNo) AS Frequency,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Monetary
FROM online_retail_transactions
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID;
-- Create the segmented table using NTILE
CREATE TABLE rfm_segmented_customers AS
SELECT *,
    NTILE(5) OVER (
        ORDER BY Recency ASC
    ) AS R_Score,
    NTILE(5) OVER (
        ORDER BY Frequency DESC
    ) AS F_Score,
    NTILE(5) OVER (
        ORDER BY Monetary DESC
    ) AS M_Score
FROM rfm_scores;
-- Add and update the Segment column
ALTER TABLE rfm_segmented_customers
ADD COLUMN Segment VARCHAR(30);
UPDATE rfm_segmented_customers
SET Segment = CASE
        WHEN R_Score = 5
        AND F_Score = 5
        AND M_Score = 5 THEN 'Champions'
        WHEN R_Score >= 4
        AND F_Score >= 4
        AND M_Score >= 4 THEN 'Loyal Customers'
        WHEN R_Score >= 4
        AND F_Score <= 2
        AND M_Score <= 2 THEN 'Potential Loyalist'
        WHEN R_Score = 5
        AND F_Score = 1 THEN 'New Customers'
        WHEN R_Score <= 2
        AND F_Score >= 4 THEN 'At Risk'
        WHEN R_Score <= 2
        AND F_Score <= 2
        AND M_Score <= 2 THEN 'Hibernating'
        WHEN R_Score = 1
        AND F_Score = 1
        AND M_Score = 1 THEN 'Lost'
        ELSE 'Others'
    END;
-- Select the final segmented customers
SELECT *
FROM rfm_segmented_customers
ORDER BY Segment;
SELECT Segment,
    COUNT(*) AS Customer_Count
FROM rfm_segmented_customers
GROUP BY Segment
ORDER BY Customer_Count DESC;
UPDATE rfm_segmented_customers
SET Segment = CASE
        WHEN R_Score >= 4
        AND F_Score >= 4
        AND M_Score >= 4 THEN 'Champions'
        WHEN R_Score >= 4
        AND F_Score >= 3 THEN 'Loyal Customers'
        WHEN R_Score >= 3
        AND F_Score <= 2 THEN 'Potential Loyalist'
        WHEN R_Score = 5
        AND F_Score = 1 THEN 'New Customers'
        WHEN R_Score <= 2
        AND F_Score >= 4 THEN 'At Risk'
        WHEN R_Score <= 2
        AND F_Score <= 2
        AND M_Score <= 2 THEN 'Hibernating'
        WHEN R_Score = 1
        AND F_Score = 1
        AND M_Score = 1 THEN 'Lost'
        ELSE 'About to Sleep'
    END;
-- Select the final segmented customers
SELECT Segment,
    COUNT(*) AS Customer_Count
FROM rfm_segmented_customers
GROUP BY Segment
ORDER BY Customer_Count DESC;
-- Select the final segmented customers 
SELECT *
FROM rfm_segmented_customers;
UPDATE rfm_segmented_customers
SET Segment = CASE
        -- 🏆 Champions: most recent, frequent, AND highest spenders
        WHEN R_Score >= 4
        AND F_Score >= 4
        AND M_Score = 5 THEN 'Champions' -- 💎 Loyal Customers: frequent and high spenders, but not always top recency
        WHEN R_Score >= 3
        AND F_Score >= 4
        AND M_Score >= 4 THEN 'Loyal Customers' -- 🚀 Big Spenders: high spending, but not necessarily recent or frequent
        WHEN M_Score = 5
        AND F_Score <= 2
        AND R_Score <= 3 THEN 'Big Spenders' -- 🌱 Potential Loyalists: recently active with moderate frequency and spending
        WHEN R_Score >= 3
        AND F_Score >= 2
        AND M_Score >= 3 THEN 'Potential Loyalists' -- 🆕 New Customers: very recent, first-time or low-spend buyers
        WHEN R_Score = 5
        AND F_Score = 1
        AND M_Score <= 3 THEN 'New Customers' -- ⚠️ At Risk: used to be active/spending, but haven’t bought recently
        WHEN R_Score <= 2
        AND (
            F_Score >= 3
            OR M_Score >= 3
        ) THEN 'At Risk' -- ❄️ Hibernating: haven’t bought in a long time, low frequency and spend
        WHEN R_Score <= 2
        AND F_Score <= 2
        AND M_Score <= 2 THEN 'Hibernating' -- ❌ Lost: worst across all metrics
        WHEN R_Score = 1
        AND F_Score = 1
        AND M_Score = 1 THEN 'Lost' -- 😴 Everything else
        ELSE 'About to Sleep'
    END;
SELECT *
FROM rfm_segmented_customers;