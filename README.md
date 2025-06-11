
# 🛍️ Retail Sales Analysis with SQL

This project showcases a complete SQL-based analysis of a retail sales dataset. From cleaning raw data to answering key business questions, the goal is to gain insights into customer behavior, sales performance, and product trends.

---

## 📂 Files Included

- `retail_sales.sql` — SQL scripts for cleaning, exploration, and analysis.
- `SQL - Retail Sales Analysis_utf.csv` — Retail dataset containing transactional data.

---

## 🧰 Tools & Technologies

- PostgreSQL
- SQL (Window functions, Aggregations, CTEs, CASE statements)

---

## 🧼 Data Cleaning Steps

- Checked for and removed rows with `NULL` in critical fields such as `transactions_id`, `sale_date`, `sale_time`, `customer_id`, etc.
- Ensured data integrity before proceeding to analysis.

Example:
```sql
DELETE FROM public.retail_sales
WHERE transactions_id IS NULL
  OR sale_date IS NULL
  OR sale_time IS NULL
  OR customer_id IS NULL
  OR gender IS NULL
  OR age IS NULL
  OR category IS NULL
  OR quantiy IS NULL
  OR price_per_unit IS NULL
  OR cogs IS NULL
  OR total_sale IS NULL;
```

---

## 📊 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

---

### 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05':

```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

---

### 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in Nov-2022:

```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantity >= 4;
```

---

### 3. Write a SQL query to calculate the total sales (`total_sale`) for each category:

```sql
SELECT 
  category,
  SUM(total_sale) AS net_sale,
  COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

---

### 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category:

```sql
SELECT 
  ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

---

### 5. Write a SQL query to find all transactions where the total sale is greater than 1000:

```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

---

### 6. Write a SQL query to find the total number of transactions made by each gender in each category:

```sql
SELECT 
  category,
  gender,
  COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
```

---

### 7. Write a SQL query to calculate the average sale for each month and find the best selling month in each year:

```sql
SELECT 
  year,
  month,
  avg_sale
FROM (
  SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale) AS avg_sale,
    RANK() OVER (
      PARTITION BY EXTRACT(YEAR FROM sale_date)
      ORDER BY AVG(total_sale) DESC
    ) AS rank
  FROM retail_sales
  GROUP BY 1, 2
) AS t1
WHERE rank = 1;
```

---

### 8. Write a SQL query to find the top 5 customers based on the highest total sales:

```sql
SELECT 
  customer_id,
  SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

---

### 9. Write a SQL query to find the number of unique customers who purchased items from each category:

```sql
SELECT 
  category,
  COUNT(DISTINCT customer_id) AS count_uni_cust
FROM retail_sales
GROUP BY category;
```

---

### 10. Write a SQL query to create each shift (Morning, Afternoon, Evening) and calculate the number of orders in each:

```sql
WITH hourly_sales AS (
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
  COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift_time;
```

---

## 🚀 How to Run

1. Import the `.csv` dataset into your PostgreSQL database.
2. Run the queries from `retail_sales.sql` to reproduce the analysis.
3. Modify or extend the queries to dig deeper into customer and sales trends.

---

## 📫 Contact

For feedback or collaboration, feel free to reach out via GitHub Issues or [LinkedIn](#).

---

---

## 🔍 Findings

- **Customer Demographics**: Sales are distributed among various age groups and genders, with notable activity in categories like Clothing and Beauty.
- **High-Value Transactions**: Several purchases exceeded $1000, highlighting opportunities in high-end product segments.
- **Sales Seasonality**: Monthly breakdown reveals shifts in average sales, helping pinpoint high-performing seasons or months.
- **Customer Behavior**: Analysis revealed top-spending customers and the most engaging product categories, providing useful customer segmentation insight.

---

## 📑 Reports Generated

- **Sales Overview**: Summarizes total sales per category, customer demographics, and order volume.
- **Trend Reports**: Highlights monthly trends and time-of-day purchasing patterns across defined sales shifts.
- **Customer Analysis**: Includes unique customer counts per category and lists the highest spending individuals.

---

## ✅ Conclusion

This project is a practical demonstration of using SQL for real-world retail data analysis. It walks through data preparation, cleaning, and insightful querying. The results can support business strategies around product placement, customer targeting, and seasonal promotions.

---

## 🧭 How to Use This Repository

1. **Clone the Repository**: Use Git to clone this repo to your local machine.
2. **Import the Dataset**: Load `SQL - Retail Sales Analysis_utf.csv` into a PostgreSQL database.
3. **Run the SQL Scripts**: Execute the queries in `retail_sales.sql` to perform cleaning and analysis.
4. **Experiment Further**: Customize queries or add new ones to explore specific sales questions or build dashboards.

---

## 👤 Author – Aditya Pathak 

This project is part of my analytics portfolio and showcases core SQL capabilities for aspiring and current data analysts. Feel free to reach out for questions, feedback, or collaboration opportunities.