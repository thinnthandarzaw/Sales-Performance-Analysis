--Identifies total sales, total profit, and overall profit margin--
SELECT 
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin
FROM orders;

--Sales by Category--
SELECT 
    category, 
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders
GROUP BY category
ORDER BY total_sales DESC;

-- Bottom sub categories --
SELECT sub_category,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin
FROM orders
GROUP BY sub_category
HAVING (SUM(profit) / SUM(sales)) * 100 < 0;

-- Bottom 5 Profit margin by States--
SELECT state,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin
FROM orders
GROUP BY state
HAVING (SUM(profit) / SUM(sales)) * 100 < 0
ORDER BY profit_margin DESC
LIMIT 5;

-- Top 5 Profit margin by States--
SELECT state,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin
FROM orders
GROUP BY state
HAVING (SUM(profit) / SUM(sales)) * 100 > 0
ORDER BY profit_margin DESC
LIMIT 5;

--Average discount rate--
SELECT sub_category,
		AVG(discount) * 100 AS avg_discount_rate
FROM orders
GROUP BY sub_category
ORDER BY avg_discount_rate DESC;

--Quantity by Ship mode--
SELECT ship_mode, SUM(quantity) AS total_quantity
FROM orders
GROUP BY ship_mode
ORDER BY total_quantity DESC;

-- Repeated Customers --
SELECT COUNT(*) AS repeated_customers
FROM (
	SELECT customer_name
	FROM orders
	GROUP BY customer_name
	HAVING COUNT(DISTINCT order_id) > 1
);
