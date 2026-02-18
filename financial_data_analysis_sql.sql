-- Automated Financial Data Cleaning & Reporting System Project --


CREATE DATABASE finance_project;

USE finance_project;

CREATE TABLE transactions (
step INT,
customer VARCHAR(20),
age_group VARCHAR(20),
gender VARCHAR(5),
merchant VARCHAR(20),
category VARCHAR(50),
amount DECIMAL(10,2),
fraud INT
);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/financial_cleaned.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM transactions;

SELECT * FROM transactions;

-- 1.Total transactions --
SELECT COUNT(*) AS total_transactions 
FROM transactions;

-- 2. Total revenue --
SELECT ROUND(SUM(amount),2) AS total_revenue
FROM transactions;

-- 3. Fraud transactions --
SELECT COUNT(*) AS fraud_transactions
FROM transactions
WHERE fraud = 1;


-- 4. Category wise revenue --
-- Which category generating the most revenue --
SELECT 
category,
ROUND(SUM(amount),2) AS total_revenue
FROM transactions
GROUP BY category
ORDER BY total_revenue DESC;


-- 5. Category wise transactions --
-- Which category has the most transactions -- 
SELECT 
category,
COUNT(*) AS total_transactions
FROM transactions
GROUP BY category
ORDER BY total_transactions DESC;


-- 6. Fraud by category (powerful insight) --
-- which category has highest fraud --
SELECT 
category,
COUNT(*) AS fraud_count
FROM transactions
WHERE fraud = 1
GROUP BY category
ORDER BY fraud_count DESC;



-- Customer & demographic insights --
-- 7. Age group wise spending --
SELECT 
age_group,
ROUND(SUM(amount),2) AS total_spending
FROM transactions
GROUP BY age_group
ORDER BY total_spending DESC;


-- 8. Gender wise spending -- 
SELECT 
gender,
ROUND(SUM(amount),2) AS total_spending
FROM transactions
GROUP BY gender;


-- 9. Fraud percentage --
SELECT 
ROUND((SUM(CASE WHEN fraud=1 THEN 1 ELSE 0 END)/COUNT(*))*100,2) 
AS fraud_percentage
FROM transactions;




