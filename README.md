
---

# Customer Purchasing Behavior – RFM Segmentation Analysis

## Project Background

This project analyzes customer purchasing behavior for a UK-based e-commerce retailer specializing in seasonal, home, and lifestyle products. The company operates exclusively online and serves customers across the UK and Europe, with peak sales activity occurring in Q4 due to holiday shopping.

Although the company collects detailed transactional data, it has not fully leveraged it to inform targeted marketing and retention strategies. This analysis applies Recency, Frequency, and Monetary (RFM) segmentation to group customers based on their purchasing patterns over the past 12 months. The goal is to identify high-value customer groups, understand their engagement patterns, and highlight opportunities for revenue growth and customer retention.

Insights and recommendations are provided on the following key areas:

* Customer Segment Distribution
* Recency Trends
* Frequency Trends
* Monetary Contribution
* Monthly Revenue Trends

The SQL queries used to inspect and clean the data for this analysis can be found here: `[link]`
The targeted SQL queries for RFM segmentation and customer behavior can be found here: `[link]`
An interactive Tableau dashboard used to explore the findings can be found here: `[link]`

---

## Data Structure & Initial Checks

The company’s primary transactional dataset contains 4,305 unique customers over the last 12 months. The main table includes:

* **InvoiceNo** – Unique transaction ID
* **InvoiceDate** – Purchase timestamp
* **CustomerID** – Unique customer identifier
* **Quantity** – Number of items purchased
* **UnitPrice** – Price per item
* **Country** – Customer’s country
* **Revenue** – Calculated as Quantity × UnitPrice

Initial data quality checks included removing transactions with missing `CustomerID`, negative quantities, and zero/negative prices. Returns were excluded. The dataset was filtered to the most recent 12-month period.

---

## Executive Summary

The analysis revealed that a small number of customers contribute the majority of revenue. Champions, while only 15% of the customer base, generated over £3.9M (49% of total revenue) with frequent and recent purchases. Lost customers represented the largest group at 32% but contributed just £400K in total revenue.

The results show clear opportunities to strengthen mid-tier segments such as Loyal Customers and Potential Loyalists, while re-engaging At-Risk and Lost customers. Seasonal trends remain strong, with revenue spikes in November and December, but retention opportunities exist throughout the year.

---

## Insights Deep Dive

### Customer Segment Distribution

* Champions make up approximately 15% of the customer base (about 645 customers) and generate nearly half of total revenue.
* Lost customers are the largest group at 32% (about 1,380 customers) but contribute just 5% of total revenue, averaging less than £300 per customer.
* Loyal Customers (20%) and Potential Loyalists (19%) together make up nearly 40% of the base, offering strong potential for upselling and retention.

### Recency Trends

* Champions have the shortest recency, averaging 15 days since their last purchase, showing high engagement.
* Loyal Customers average 35 days, suggesting moderate but steady engagement.
* Potential Loyalists average 60 days, providing a window for targeted offers to shorten the purchase cycle.
* At-Risk customers (average 140 days) and Lost customers (average 165 days) require re-engagement strategies to return.

### Frequency Trends

* Champions average 15 orders per year, significantly above the overall average of 5.0.
* Loyal Customers average 7 orders annually, showing consistent repeat purchasing.
* Potential Loyalists average 4 orders, indicating room for loyalty growth.
* At-Risk customers average 3 orders, while Lost customers average fewer than 2.

### Monetary Contribution

* Champions generated approximately £3.9M (49% of total revenue).
* Loyal Customers contributed £1.8M (22%).
* Potential Loyalists generated about £1.1M, while At-Risk customers contributed £800K.
* Lost customers contributed £400K, despite being the largest group by size.

### Monthly Revenue Trends

* Champions drive the highest monthly revenue, peaking at over £550K in November.
* Loyal Customers and Potential Loyalists also see spikes in November–December, reflecting strong seasonality.
* At-Risk customers show steady revenue until a small lift in December.
* Lost customers have consistently low revenue, with minimal seasonal impact.

---

## Recommendations

Based on the findings, the following actions are recommended:

* **Enhance retention of Champions.** Maintain high engagement by offering exclusive loyalty perks, early access to seasonal sales, and personalized product recommendations to sustain their high purchase frequency and revenue contribution.
* **Upsell Loyal Customers and Potential Loyalists.** Introduce targeted bundles, cross-sells, and limited-time offers to increase order frequency and average order value, moving them toward the Champion segment.
* **Re-engage At-Risk customers.** Use targeted email campaigns with discounts or incentives to bring them back within 60–90 days of inactivity.
* **Win back Lost customers.** Launch reactivation campaigns featuring attractive offers on popular products, seasonal items, or free shipping to reinitiate purchases.
* **Leverage seasonal demand.** Build pre-holiday campaigns targeting all active customers, with segmented messaging to maximize Q4 revenue performance.

---

## Assumptions and Caveats

* Analysis is based on a 12-month snapshot and may not capture long-term trends.
* Transactions with missing IDs, negative quantities, or invalid pricing were excluded.
* Revenue figures exclude shipping charges and discounts.
* RFM segmentation was calculated using quintile-based scoring; alternative methods may yield different results.

---


