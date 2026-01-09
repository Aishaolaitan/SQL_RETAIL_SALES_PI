--RETAIL SALES ANALYSIS

SELECT TOP (1000) [transactions_id]
      ,[sale_date]
      ,[sale_time]
      ,[customer_id]
      ,[gender]
      ,[age]
      ,[category]
      ,[quantity]
      ,[price_per_unit]
      ,[cogs]
      ,[total_sale]
  FROM [sql_p1].[dbo].[retail]

  SELECT * FROM [sql_p1].[dbo].[retail];

  --Determine the total number of records in the dataset
   SELECT COUNT(*) FROM [sql_p1].[dbo].[retail];

  --Find out how many unique customers are in the dataset
  SELECT COUNT(DISTINCT(customer_id )) FROM [sql_p1].[dbo].[retail];

  --Identify all unique product categories in the dataset
   SELECT DISTINCT(category ) FROM [sql_p1].[dbo].[retail];

   -- Check for any null values in the dataset and delete records with missing data
   DELETE FROM [sql_p1].[dbo].[retail]
   WHERE
       transactions_id IS NULL OR
	   sale_date IS NULL OR
       sale_time IS NULL OR
       customer_id IS NULL OR
       gender IS NULL OR
       age IS NULL OR
       category IS NULL OR
       quantity IS NULL OR
       price_per_unit IS NULL OR
       cogs IS NULL OR
       total_sale IS NULL;

 --Write a SQL query to retrieve all columns for sales made on '2022-11-05
 SELECT * FROM [sql_p1].[dbo].[retail] 
    WHERE 
	sale_date = '2022-11-05';

--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT * FROM [sql_p1].[dbo].[retail] 
    WHERE 
	category='Clothing'
	AND
	quantity >= 4
	AND MONTH(sale_date) = 11
  AND YEAR(sale_date) = 2022;

  --Write a SQL query to calculate the total sales (total_sale) for each category.
  SELECT SUM(total_sale) as net_sales,
  category FROM [sql_p1].[dbo].[retail] 
  GROUP BY category;

  --Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
    SELECT AVG(age) as ave_age,
  category FROM [sql_p1].[dbo].[retail] 
  WHERE category='Beauty'
  GROUP BY category;

  --Write a SQL query to find all transactions where the total_sale is greater than 1000.
  SELECT * FROM [sql_p1].[dbo].[retail] 
  WHERE total_sale > 1000;

  --Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
  SELECT COUNT (transactions_id) as 'no_of_transaction', 
    gender,
	category FROM [sql_p1].[dbo].[retail] 
  GROUP BY category, gender;

  --Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
   SELECT
    YEAR(sale_date) AS sales_year,
    MONTH(sale_date) AS sales_month,
    AVG(total_sale) AS avg_monthly_sale
FROM [sql_p1].[dbo].[retail] 
GROUP BY
    YEAR(sale_date),
    MONTH(sale_date)
ORDER BY
    sales_year,
    sales_month;

	--Write a SQL query to find the top 5 customers based on the highest total sales
	SELECT TOP 5
	SUM(total_sale) as total_sales,
	customer_id 
	FROM [sql_p1].[dbo].[retail] 
	GROUP BY customer_id 
	ORDER BY customer_id ASC
	;
	
  --Write a SQL query to find the number of unique customers who purchased items from each category.
  SELECT	
	COUNT(DISTINCT(customer_id)) AS UNIQUE_,
	category
	FROM [sql_p1].[dbo].[retail] 
	GROUP BY category ;

	--Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
	

SELECT
    CASE
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS total_orders
FROM [sql_p1].[dbo].[retail]
GROUP BY
    CASE
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END;
	'