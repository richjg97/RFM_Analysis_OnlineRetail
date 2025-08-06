# Customer Purchasing Behavior – RFM Segmentation Analysis

## Project Background
This project analyzes customer purchasing patterns for a UK-based e-commerce retailer specializing in seasonal, home, and lifestyle products. The company sells exclusively online and serves customers across the UK and Europe, with the highest sales occurring in Q4 due to holiday shopping.  

Although the company collects detailed transaction records, it had not fully leveraged this data to guide marketing and retention strategies. This analysis uses Recency, Frequency, and Monetary (RFM) segmentation to group customers based on their purchasing patterns from the past 12 months. The purpose of this segmentation is to identify high-value customer groups, understand their behavior, and highlight opportunities to increase retention and re-engagement through targeted campaigns.  

Insights and recommendations are provided in the following key areas:  
- Customer Segment Distribution  
- Recency Trends  
- Frequency Trends  
- Monetary Contribution  
- Monthly Revenue Trends  

The SQL queries used to inspect and clean the data for this analysis can be found here: `[link]`  
The targeted SQL queries for RFM scoring and customer behavior can be found here: `[link]`  
An interactive Tableau dashboard used to explore segment behavior can be found here: `[link]`

---

## Data Structure & Initial Checks
The dataset contains 4,305 unique customers over the most recent 12-month period. The key fields are as follows:  

| Field         | Description |
|---------------|-------------|
| InvoiceNo     | Unique transaction ID |
| InvoiceDate   | Date and time of purchase |
| CustomerID    | Unique customer identifier |
| Quantity      | Number of items purchased |
| UnitPrice     | Price per item |
| Country       | Country of the customer |
| Revenue       | Calculated as Quantity × UnitPrice |

Before analysis, the dataset was cleaned to remove rows with missing customer IDs, negative quantities, or zero/negative prices. Transactions were filtered to include only the most recent 12 months of activity. Returns and cancellations were excluded, and revenue was calculated at the order level.

---

## Executive Summary
The analysis revealed that a small percentage of the customer base generates the majority of revenue. Champions represent 13 percent of customers but contribute approximately $4.0 million in annual revenue through frequent and recent purchases. Lost customers make up 31 percent of the customer base but account for only 5 percent of total revenue. Loyal Customers and Potential Loyalists form a strong middle tier with significant upsell and retention opportunities. Seasonal peaks occur in November and December, although December 2022 revenue was slightly lower than in December 2021.

---

## Insights Deep Dive

### Customer Segment Distribution
Champions make up approximately 13 percent of customers (around 560 individuals) but generate nearly $4.0 million annually, averaging $7,100 per customer. Loyal Customers represent 19 percent of the customer base and generate about $1.84 million in revenue. Potential Loyalists account for 20 percent of customers, generating around $1.0 million annually. At-Risk customers represent 15 percent of customers and bring in about $800,000. Lost customers form the largest segment at 31 percent but generate only $400,000 in total revenue, averaging less than $300 per customer.

### Recency Trends
Champions purchase on average every 8 days, indicating consistent engagement throughout the year. Loyal Customers average 20 days between purchases, showing they are responsive to regular promotions. Potential Loyalists purchase approximately every 40 days, suggesting an opportunity to shorten this cycle through targeted offers. At-Risk customers average 150 days since their last purchase, showing clear signs of disengagement. Lost customers have an average recency of 162 days, indicating they are unlikely to return without a significant reactivation effort.

### Frequency Trends
Champions place an average of 15 orders per year, making them the most active group by a wide margin. Loyal Customers make an average of 6 orders annually, showing steady engagement. Potential Loyalists place around 4 orders per year, indicating moderate loyalty that can be developed further. At-Risk customers average 3 purchases annually, while Lost customers make only 1 or 2 purchases before becoming inactive.

### Monetary Contribution
Champions contribute approximately $4.02 million annually, accounting for 50 percent of total revenue. Loyal Customers generate $1.84 million, representing 23 percent of revenue. Potential Loyalists contribute $1.0 million, and At-Risk customers add $800,000. Despite being the largest group, Lost customers account for just $400,000 annually.

### Monthly Revenue Trends
Champions generated over $500,000 in December 2021 and approximately $450,000 in December 2022. Loyal Customers peaked at $180,000 in December 2021 and $160,000 in December 2022. Potential Loyalists held steady at approximately $90,000 per month, rising to $120,000 in the holiday season. At-Risk customers experienced a mid-year decline but recovered to $90,000 by December. Lost customers showed little seasonal variation, averaging $35,000 per month.

---

## Recommendations
Based on the findings from this analysis, the following actions are recommended:

- **Focus on Champions:** Maintain engagement with VIP programs, early access sales, and exclusive discounts to preserve their high purchase frequency and spending.
- **Upsell Loyal Customers and Potential Loyalists:** Introduce bundles and personalized recommendations to increase order value and encourage more frequent purchases.
- **Win Back At-Risk Customers:** Implement targeted reactivation campaigns using time-limited discounts and personalized messaging to reduce churn.
- **Re-Engage Lost Customers:** Use win-back email flows and special offers before high-sales periods such as Q4 to encourage reactivation.
- **Leverage Seasonal Peaks:** Increase marketing investments in November and December to maximize revenue during the busiest months.

---

## Assumptions and Caveats
- The analysis is based on the most recent 12 months of data and may not reflect longer-term customer trends.
- Transactions with missing customer IDs, negative quantities, or invalid pricing were excluded from the dataset.
- Revenue estimates exclude shipping charges and discounts.
- RFM scoring was performed using quintile-based ranking; using different scoring methods may produce different segment groupings.
- No demographic or behavioral data beyond transactional history was available for enrichment.

