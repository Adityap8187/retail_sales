SELECT * FROM public.retail_sales


SELECT * FROM public.retail_sales
WHERE quantiy IS NULL;


SELECT COUNT(*) FROM public.retail_sales
WHERE quantiy IS NOT NULL;


-- INSTEAD OF CHECKING EACH ROW, USE THIS

SELECT * FROM public.retail_sales
WHERE transactions_id IS NULL
   OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	or
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL

-- DELETE NULL VALUES
-- DATA CLEANING

DELETE FROM public.retail_sales
WHERE transactions_id IS NULL
   OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	or
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL

-- DATA EXPLORATION

-- HOW MANY SALES WE HAVE

SELECT COUNT(*) AS total_sales FROM public.retail_sales;

-- HOW MANY UNIQUE CUSTOMERS WE HAVE

SELECT COUNT(DISTINCT customer_id) AS total_sales FROM public.retail_sales;

-- HOW MANY CATEGORY AND WHAT CATEGORY WE HAVE

SELECT COUNT(DISTINCT CATEGORY) AS total_sales FROM public.retail_sales;
SELECT DISTINCT CATEGORY FROM public.retail_sales;



-- DATA ANALYSIS OR BUSINESS KEY PROBLEMS & ANSWERS

-- Q1 WRITE A SQL QUERY TO RETRIEVE ALL COLUMNS FOR SALES MADE ON 2022-11-05

SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05'

-- Q2 WRITE A SQL QUERY TO RETRIEVE ALL TRANSACTION WHERE THE CATEGORY IS 'CLOTHING' AND THE QUANTITY IS SOLD MORE THEN 4 IN MONTH OF NOV-2022

SELECT * FROM retail_sales
WHERE category = 'Clothing'
AND
TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
AND 
quantiy >= 4

SELECT * FROM retail_sales
WHERE total_sale >= 500
AND 
category = 'Electronics'
AND 
TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'


-- Q3 WRITE A SQL QUERY TO CALCULATE THE TOTAL SALES FOR EACH CATEGORY

SELECT 
category,
SUM (total_sale) as net_sales,
COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1


-- Q4 WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM THE 'BEAUTY' CATEGORY

SELECT 
  ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'


--Q5 WRITE A SQL TO FIND ALL TRANSACTIONS WHERE HE total_sale IS GREATER THAN 1000


SELECT 
*
FROM retail_sales
WHERE 
total_sale > 1000

-- Q6 WRITE A SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSACTIONS (transactions_id) MADE BY EACH GENDER IN EACH CATEGORY

SELECT 
category,
gender,
COUNT(*) AS total_trans
FROM retail_sales
GROUP BY
category,
gender
ORDER BY 1


-- Q7 WRITE SQL QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH. FIND OUT THE BEST SELLING MONTH IN EACH YEAR



SELECT 
year,
month,
avg_sale
FROM
(
	SELECT 
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	AVG(total_sale) as  avg_sale,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
	FROM retail_sales
	GROUP BY 1, 2
) AS t1
WHERE rank = 1



-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

SELECT 
customer_id,
SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5



-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.


SELECT 
category,
COUNT( DISTINCT customer_id) AS count_uni_cust
FROM retail_sales
GROUP BY category




-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening ›17)



WITH hourly_sales
AS
(
SELECT *,
     CASE
	  WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'MORNING'
	  WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
	  ELSE 'EVENING'
	 END AS shift_time
FROM retail_sales
)
SELECT 
shift_time,
COUNT(*) as total_orders
FROM hourly_sales
GROUP BY shift_time



-- END OF PROJECT
