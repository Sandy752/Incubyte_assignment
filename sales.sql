SELECT * FROM sale;

-- Convert TransactionDate into proper format (YYYY-MM-DD)

UPDATE sale
SET TransactionDate = STR_TO_DATE(TransactionDate, '%m/%d/%Y %H:%i');

-- Removing NULL values

DELETE
FROM sale
WHERE CustomerID IS NULL
    OR TransactionDate IS NULL
    OR PaymentMethod is NULL
    OR StoreType is NULL
    OR CustomerAge is NULL
    OR CustomerGender is NULL
    OR ProductName is NULL
    OR Region is NULL;

-- Key Insights from Aggregate Analysis

-- Total Sales
SELECT ROUND(SUM(TransactionAmount), 1)
FROM sale;

-- Average Discount

SELECT AVG(DiscountPercent) from sale

-- Monthly Sales Trend

SELECT MONTHNAME(TransactionDate),ROUND(SUM(TransactionAmount),1)
FROM sale
GROUP BY MONTHNAME(TransactionDate);

-- Products by Sales

SELECT ProductName,ROUND(SUM(TransactionAmount),1) as Total_sales,
ROUND((SUM(TransactionAmount) / (SELECT SUM(TransactionAmount) FROM sale) * 100),1) AS percentage_of_total_sales
FROM sale
GROUP BY ProductName
ORDER BY 
percentage_of_total_sales DESC;

--Sales by Region

select ROUND(SUM(TransactionAmount),1),Region from sale
GROUP BY Region;
