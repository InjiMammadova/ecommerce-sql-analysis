
/* =====================================================
   E-COMMERCE ANALYTICS PROJECT (SQL)
   Customer Behavior | Sales | Churn | RFM Segmentation

   Author: Inji Mammadova
   ===================================================== */


/* =========================================================
   1. DATA QUALITY CHECK
   ========================================================= */

-- 1.1 Missing values check
SELECT 
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(Customer_ID) AS missing_customer_id,
    COUNT(*) - COUNT(Purchase_Date) AS missing_purchase_date,
    COUNT(*) - COUNT(Product_Category) AS missing_product_category,
    COUNT(*) - COUNT(Product_Price) AS missing_product_price,
    COUNT(*) - COUNT(Quantity) AS missing_quantity,
    COUNT(*) - COUNT(Total_Purchase_Amount) AS missing_total_purchase_amount,
    COUNT(*) - COUNT(Payment_Method) AS missing_payment_method,
    COUNT(*) - COUNT(Customer_Age) AS missing_customer_age,
    COUNT(*) - COUNT(Returns) AS missing_returns,
    COUNT(*) - COUNT(Customer_Name) AS missing_customer_name,
    COUNT(*) - COUNT(Age) AS missing_age,
    COUNT(*) - COUNT(Gender) AS missing_gender,
    COUNT(*) - COUNT(Churn) AS missing_churn
FROM dbo.ecomm2;

-- 1.2 Full-row duplicate check
SELECT 
    Customer_ID,
    Purchase_Date,
    Product_Category,
    Product_Price,
    Quantity,
    Total_Purchase_Amount,
    Payment_Method,
    Customer_Age,
    Returns,
    Customer_Name,
    Age,
    Gender,
    Churn,
    COUNT(*) AS duplicate_count
FROM dbo.ecomm2
GROUP BY 
    Customer_ID,
    Purchase_Date,
    Product_Category,
    Product_Price,
    Quantity,
    Total_Purchase_Amount,
    Payment_Method,
    Customer_Age,
    Returns,
    Customer_Name,
    Age,
    Gender,
    Churn
HAVING COUNT(*) > 1;

-- 1.3 Quality review
SELECT TOP 10 *
FROM dbo.ecomm2;


/* =========================================================
   2. DATA OVERVIEW
   ========================================================= */

-- 2.1 Dataset size and structure
SELECT 
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT Customer_ID) AS unique_customers,
    COUNT(DISTINCT Product_Category) AS total_categories,
    COUNT(DISTINCT Payment_Method) AS total_payment_methods
FROM dbo.ecomm2;

-- 2.2 Category distribution
SELECT 
    Product_Category AS product_category,
    COUNT(*) AS transaction_count
FROM dbo.ecomm2
GROUP BY Product_Category
ORDER BY transaction_count DESC;

-- 2.3 Payment method distribution
SELECT 
    Payment_Method AS payment_method,
    COUNT(*) AS transaction_count
FROM dbo.ecomm2
GROUP BY Payment_Method
ORDER BY transaction_count DESC;


/* =========================================================
   3. REVENUE ANALYSIS
   ========================================================= */

-- 3.1 Overall revenue and order value
SELECT 
    SUM(Total_Purchase_Amount) AS total_revenue,
    AVG(Total_Purchase_Amount) AS average_order_value,
    MIN(Total_Purchase_Amount) AS minimum_order_value,
    MAX(Total_Purchase_Amount) AS maximum_order_value
FROM dbo.ecomm2;

-- 3.2 Revenue by category
SELECT 
    Product_Category AS product_category,
    SUM(Total_Purchase_Amount) AS total_revenue_by_category
FROM dbo.ecomm2
GROUP BY Product_Category
ORDER BY total_revenue_by_category DESC;

-- 3.3 Revenue share by category
SELECT 
    Product_Category AS product_category,
    SUM(Total_Purchase_Amount) AS category_revenue,
    SUM(Total_Purchase_Amount) * 1.0 /
    (SELECT SUM(Total_Purchase_Amount) FROM dbo.ecomm2) AS revenue_share_ratio
FROM dbo.ecomm2
GROUP BY Product_Category
ORDER BY category_revenue DESC;


/* =========================================================
   4. PRODUCT & CATEGORY ANALYSIS
   ========================================================= */

-- 4.1 Quantity sold by category
SELECT 
    Product_Category AS product_category,
    SUM(Quantity) AS total_units_sold
FROM dbo.ecomm2
GROUP BY Product_Category
ORDER BY total_units_sold DESC;

-- 4.2 Average product price by category
SELECT 
    Product_Category AS product_category,
    AVG(Product_Price) AS average_product_price
FROM dbo.ecomm2
GROUP BY Product_Category
ORDER BY average_product_price DESC;

-- 4.3 Category performance summary
SELECT 
    Product_Category AS product_category,
    COUNT(*) AS total_orders,
    SUM(Quantity) AS total_units_sold,
    SUM(Total_Purchase_Amount) AS total_revenue,
    AVG(Total_Purchase_Amount) AS average_order_value
FROM dbo.ecomm2
GROUP BY Product_Category
ORDER BY total_revenue DESC;


/* =========================================================
   5. CUSTOMER ANALYSIS
   ========================================================= */

-- 5.1 Customer purchase frequency
SELECT 
    Customer_ID,
    COUNT(*) AS total_transactions
FROM dbo.ecomm2
GROUP BY Customer_ID
ORDER BY total_transactions DESC;

-- 5.2 Top customers by spending
SELECT TOP 10
    Customer_ID,
    Customer_Name,
    SUM(Total_Purchase_Amount) AS total_customer_spending
FROM dbo.ecomm2
GROUP BY Customer_ID, Customer_Name
ORDER BY total_customer_spending DESC;

-- 5.3 Customer average order value
SELECT TOP 10
    Customer_ID,
    Customer_Name,
    AVG(Total_Purchase_Amount) AS average_order_value
FROM dbo.ecomm2
GROUP BY Customer_ID, Customer_Name
ORDER BY average_order_value DESC;

--5.4 Customer segmentation
SELECT
    Customer_ID,
    SUM(Total_Purchase_Amount) AS total_spending,
    CASE 
        WHEN SUM(Total_Purchase_Amount) >= 45000 THEN 'High Value'
        WHEN SUM(Total_Purchase_Amount) >= 30000 THEN 'Mid Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM dbo.ecomm2
GROUP BY Customer_ID;


--5.5 Segment distribution
SELECT
    customer_segment,
    COUNT(*) AS customer_count
FROM (
    SELECT
        Customer_ID,
        CASE 
            WHEN SUM(Total_Purchase_Amount) >= 45000 THEN 'High Value'
            WHEN SUM(Total_Purchase_Amount) >= 30000 THEN 'Mid Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM dbo.ecomm2
    GROUP BY Customer_ID
) t
GROUP BY customer_segment
ORDER BY customer_count DESC;


/* =========================================================
   6. PAYMENT ANALYSIS
   ========================================================= */

-- 6.1 Payment method usage
SELECT 
    Payment_Method AS payment_method,
    COUNT(*) AS transaction_count
FROM dbo.ecomm2
GROUP BY Payment_Method
ORDER BY transaction_count DESC;

-- 6.2 Revenue by payment method
SELECT 
    Payment_Method AS payment_method,
    SUM(Total_Purchase_Amount) AS total_revenue
FROM dbo.ecomm2
GROUP BY Payment_Method
ORDER BY total_revenue DESC;

-- 6.3 Average order value by payment method
SELECT 
    Payment_Method AS payment_method,
    AVG(Total_Purchase_Amount) AS average_order_value
FROM dbo.ecomm2
GROUP BY Payment_Method
ORDER BY average_order_value DESC;


/* =========================================================
   7. RETURNS ANALYSIS
   ========================================================= */

-- 7.1 Overall return behavior
SELECT 
    COUNT(*) AS total_orders,
    SUM(ISNULL(Returns, 0)) AS total_returns,
    AVG(CAST(ISNULL(Returns, 0) AS FLOAT)) AS average_returns_per_order
FROM dbo.ecomm2;

-- 7.2 Return level by category
SELECT 
    Product_Category AS product_category,
    SUM(ISNULL(Returns, 0)) AS total_returns,
    AVG(CAST(ISNULL(Returns, 0) AS FLOAT)) AS average_returns_per_order
FROM dbo.ecomm2
GROUP BY Product_Category
ORDER BY total_returns DESC;

-- 7.3 Revenue impact of returns
SELECT 
    CASE 
        WHEN ISNULL(Returns, 0) = 0 THEN 'No Return'
        ELSE 'Returned'
    END AS return_status,
    COUNT(*) AS transaction_count,
    SUM(Total_Purchase_Amount) AS total_revenue,
    AVG(Total_Purchase_Amount) AS average_order_value
FROM dbo.ecomm2
GROUP BY 
    CASE 
        WHEN ISNULL(Returns, 0) = 0 THEN 'No Return'
        ELSE 'Returned'
    END
ORDER BY total_revenue DESC;


/* =========================================================
   8. DEMOGRAPHIC ANALYSIS
   ========================================================= */

-- 8.1 Customer distribution by gender
SELECT 
    Gender,
    COUNT(*) AS customer_count
FROM dbo.ecomm2
GROUP BY Gender
ORDER BY customer_count DESC;

-- 8.2 Average age and age range
SELECT 
    AVG(Age) AS average_age,
    MIN(Age) AS minimum_age,
    MAX(Age) AS maximum_age
FROM dbo.ecomm2;

-- 8.3 Revenue by age group
SELECT 
    CASE 
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        ELSE '45+'
    END AS age_group,
    COUNT(*) AS transaction_count,
    SUM(Total_Purchase_Amount) AS total_revenue,
    AVG(Total_Purchase_Amount) AS average_order_value
FROM dbo.ecomm2
GROUP BY 
    CASE 
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        ELSE '45+'
    END
ORDER BY total_revenue DESC;


/* =========================================================
   9. CHURN ANALYSIS
   ========================================================= */

-- 9.1 Overall churn distribution
SELECT 
    Churn,
    COUNT(*) AS customer_count
FROM dbo.ecomm2
GROUP BY Churn
ORDER BY customer_count DESC;

-- 9.2 Churn by category
SELECT 
    Product_Category AS product_category,
    AVG(CAST(Churn AS FLOAT)) AS churn_rate
FROM dbo.ecomm2
GROUP BY Product_Category
ORDER BY churn_rate DESC;

-- 9.3 Churn by payment method
SELECT 
    Payment_Method AS payment_method,
    AVG(CAST(Churn AS FLOAT)) AS churn_rate
FROM dbo.ecomm2
GROUP BY Payment_Method
ORDER BY churn_rate DESC;

-- 9.4 Churn impact on revenue  
SELECT 
    Churn,
    COUNT(*) AS customer_count,
    SUM(Total_Purchase_Amount) AS total_revenue,
    AVG(Total_Purchase_Amount) AS avg_order_value
FROM dbo.ecomm2
GROUP BY Churn;


/* =========================================================
   10. TIME ANALYSIS
   ========================================================= */

-- 10.1 Yearly revenue trend
SELECT 
    YEAR(Purchase_Date) AS order_year,
    SUM(Total_Purchase_Amount) AS total_revenue
FROM dbo.ecomm2
GROUP BY YEAR(Purchase_Date)
ORDER BY order_year;

-- 10.2 Monthly revenue trend
SELECT 
    MONTH(Purchase_Date) AS order_month,
    SUM(Total_Purchase_Amount) AS total_revenue
FROM dbo.ecomm2
GROUP BY MONTH(Purchase_Date)
ORDER BY order_month;

-- 10.3 Revenue by weekday
SELECT 
    DATENAME(WEEKDAY, Purchase_Date) AS day_of_week,
    COUNT(*) AS transaction_count,
    SUM(Total_Purchase_Amount) AS total_revenue
FROM dbo.ecomm2
GROUP BY DATENAME(WEEKDAY, Purchase_Date)
ORDER BY total_revenue DESC;

--10.4 Yearly growth rate   

WITH yearly AS (
    SELECT 
        YEAR(Purchase_Date) AS year,
        SUM(Total_Purchase_Amount) AS revenue
    FROM dbo.ecomm2
    GROUP BY YEAR(Purchase_Date)
)
SELECT 
    year,
    revenue,
    LAG(revenue) OVER (ORDER BY year) AS prev_year,
    (revenue - LAG(revenue) OVER (ORDER BY year)) * 1.0 
    / LAG(revenue) OVER (ORDER BY year) AS growth_rate
FROM yearly;

--11.CUSTOMER SEGMENTATION (RFM ANALYSIS) 

SELECT 
    Customer_ID,
    DATEDIFF(DAY, MAX(Purchase_Date), GETDATE()) AS recency,
    COUNT(*) AS frequency,
    SUM(Total_Purchase_Amount) AS monetary
FROM dbo.ecomm2
GROUP BY Customer_ID;

--Segmentation

SELECT *,
CASE 
    WHEN monetary >= 40000 AND frequency >= 15 THEN 'High Value'
    WHEN monetary >= 20000 THEN 'Mid Value'
    ELSE 'Low Value'
END AS rfm_segment
FROM (
    SELECT 
        Customer_ID,
        DATEDIFF(DAY, MAX(Purchase_Date), GETDATE()) AS recency,
        COUNT(*) AS frequency,
        SUM(Total_Purchase_Amount) AS monetary
    FROM dbo.ecomm2
    GROUP BY Customer_ID
) t;