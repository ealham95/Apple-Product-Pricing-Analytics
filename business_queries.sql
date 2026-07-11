-- Apple Product Pricing & Market Intelligence Dashboard
-- Business Analytics SQL Queries
-- Author: Ealham Hossain

-- Data Exploration

SELECT *
FROM AppleProducts
LIMIT 10;

SELECT DISTINCT Platform
FROM AppleProducts;

SELECT COUNT(DISTINCT Platform) AS Total_Platforms
FROM AppleProducts;

SELECT COUNT(*) AS Total_Products
FROM AppleProducts;


-- Pricing Analysis

SELECT Platform,
       ROUND(AVG(Discount_Pct), 2) AS Average_Discount
FROM AppleProducts
GROUP BY Platform
ORDER BY Average_Discount DESC;

SELECT Product_Category,
       ROUND(AVG(Discount_Pct), 2) AS Average_Discount
FROM AppleProducts
GROUP BY Product_Category
ORDER BY Average_Discount DESC;

SELECT Platform,
       ROUND(AVG(Current_Price_USD), 2) AS Average_Current_Price
FROM AppleProducts
GROUP BY Platform
ORDER BY Average_Current_Price DESC;

SELECT Product_Category,
       ROUND(AVG(Price_Retention_Pct), 2) AS Average_Price_Retention
FROM AppleProducts
GROUP BY Product_Category
ORDER BY Average_Price_Retention DESC;


-- Customer Analysis

SELECT Product_Category,
       ROUND(AVG(Rating), 2) AS Average_Rating
FROM AppleProducts
GROUP BY Product_Category
ORDER BY Average_Rating DESC;

SELECT Platform,
       ROUND(AVG(Rating), 2) AS Average_Rating
FROM AppleProducts
GROUP BY Platform
ORDER BY Average_Rating DESC;

SELECT Model_Name,
       SUM(Reviews_Count) AS Total_Reviews
FROM AppleProducts
GROUP BY Model_Name
ORDER BY Total_Reviews DESC
LIMIT 10;

SELECT Model_Name,
       Platform,
       Rating
FROM AppleProducts
WHERE Rating >= 4.8
ORDER BY Rating DESC;

SELECT Model_Name,
       Platform,
       Rating
FROM AppleProducts
WHERE Product_Category = 'iPhone'
  AND Rating > 4.7;


-- Sales Analysis

SELECT Sale_Event,
       ROUND(AVG(Discount_Pct), 2) AS Average_Discount
FROM AppleProducts
GROUP BY Sale_Event
ORDER BY Average_Discount DESC;


-- HAVING Examples

SELECT Platform,
       ROUND(AVG(Rating), 2) AS Average_Rating
FROM AppleProducts
GROUP BY Platform
HAVING AVG(Rating) > 4.6
ORDER BY Average_Rating DESC;

SELECT Product_Category,
       ROUND(AVG(Discount_Pct), 2) AS Average_Discount
FROM AppleProducts
GROUP BY Product_Category
HAVING AVG(Discount_Pct) > 20
ORDER BY Average_Discount DESC;


-- CASE WHEN

SELECT Model_Name,
       Discount_Pct,
       CASE
           WHEN Discount_Pct >= 30 THEN 'High Discount'
           WHEN Discount_Pct >= 15 THEN 'Medium Discount'
           ELSE 'Low Discount'
       END AS Discount_Category
FROM AppleProducts;

SELECT CASE
           WHEN Discount_Pct >= 30 THEN 'High Discount'
           WHEN Discount_Pct >= 15 THEN 'Medium Discount'
           ELSE 'Low Discount'
       END AS Discount_Category,
       ROUND(AVG(Rating), 2) AS Average_Rating
FROM AppleProducts
GROUP BY Discount_Category
ORDER BY Average_Rating DESC;


-- Window Functions

SELECT Product_Category,
       Model_Name,
       Rating,
       RANK() OVER (
           PARTITION BY Product_Category
           ORDER BY Rating DESC
       ) AS Product_Rank
FROM AppleProducts;


-- Common Table Expression (CTE)

WITH RankedProducts AS (
    SELECT Product_Category,
           Model_Name,
           Rating,
           RANK() OVER (
               PARTITION BY Product_Category
               ORDER BY Rating DESC
           ) AS Product_Rank
    FROM AppleProducts
)
SELECT *
FROM RankedProducts
WHERE Product_Rank = 1;
