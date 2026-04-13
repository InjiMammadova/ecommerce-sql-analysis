# E-Commerce SQL Analysis

## Project Overview
This project analyzes an e-commerce dataset using SQL to understand customer behavior, revenue patterns, churn, and overall business performance.
The analysis focuses on identifying key business drivers and uncovering potential performance issues.

---

## Data Preparation
- Missing values in the `Returns` column were treated as 0 (no return)
- No exact duplicate records were identified
- The dataset was validated and prepared for analytical queries

---

## Key Insights

### 1. Data Overview
- Approximately 250K transactions and 50K customers provide sufficient analytical scale
- The dataset includes multiple product categories and payment methods
- Distributions are balanced across key dimensions

---

### 2. Product & Sales Analysis
- Revenue is evenly distributed across categories with no dominant segment
- Transaction volume is high, but repeat purchase frequency is low
- Average order value remains stable across the dataset

**Insight**: Growth depends more on increasing customer engagement than expanding sales volume.  
**Action**: Focus on retention strategies such as loyalty programs and personalized offers.

---

### 3. Customer Analysis
- Most customers have low purchase frequency
- High spenders are not always frequent buyers
- Customer value distribution is weakly differentiated

**Insight**: Different strategies are required for high-value and frequent customers.

---

### 4. Payment Analysis
- Payment methods are evenly distributed
- Revenue and average order value are similar across all methods
- No strong customer preference is observed

---

### 5. Return Analysis
- Return volume is very high (approximately 1M items)
- Average of around 4 returned items per order
- Return behavior is consistent across all categories

**Insight**: Indicates a systemic issue, likely related to product quality or fulfillment.  
**Action**: Improve product quality control and optimize return policies.

---

### 6. Demographic Analysis
- Gender distribution is balanced
- Average customer age is approximately 43
- Customers aged 45+ generate the highest revenue

**Insight**: The core customer base is middle-aged.

---

### 7. Churn Analysis
- Approximately 20% churn rate across the dataset
- Churn is consistent across categories and payment methods
- Churned and active customers show similar spending behavior

**Insight**: Churn is not driven by product or payment differences.  
**Action**: Implement retention campaigns targeting at-risk customers.

---

### 8. Churn Impact on Revenue
- Non-churn customers generate the majority of revenue
- Churned customers still contribute a significant portion (approximately 136M)

**Insight**: Customer churn leads to direct revenue loss, making retention critical.

---

### 9. Time Analysis
- Revenue remains stable between 2020 and 2022
- A significant decline is observed in 2023 (approximately -30%)
- No strong seasonal patterns are detected

**Insight**: The decline in 2023 suggests a structural business issue.  
**Action**: Investigate operational or market changes that may have caused the revenue drop.

---

### 10. RFM Analysis (Customer Segmentation)
- The majority of customers fall into the Low Value segment
- Very few customers qualify as high-value
- Low frequency and high recency indicate weak customer engagement

**Insight**: Customer loyalty is low, and reactivation strategies are required.

---

## Final Conclusion
Despite having a large customer base, the analysis reveals several critical issues:

- Low customer engagement and purchase frequency
- A consistently high churn rate (~20%)
- Weak customer loyalty, with most users in the low-value segment
- Extremely high return rates, indicating potential operational or product issues

These factors directly contributed to the significant revenue decline observed in 2023.

From a business perspective, the main challenge is customer retention and engagement rather than customer acquisition.

To address this, the business should prioritize:
- Retention strategies such as loyalty programs and personalized offers
- Root cause analysis of high return rates
- Reactivation campaigns for inactive customers
- Continuous monitoring of churn and customer lifetime value

---
## Tools Used
- SQL (SQL Server)
