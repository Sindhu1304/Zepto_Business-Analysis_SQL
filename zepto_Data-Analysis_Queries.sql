-- Create a Database
CREATE DATABASE zepto_db;
USE zepto_db;

-- Create a Table
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Category VARCHAR(100),
    name VARCHAR(255),
    mrp INT,
    discountPercent INT,
    availableQuantity INT,
    discountedSellingPrice INT,
    weightInGms INT,
    outOfStock VARCHAR(10), -- or TINYINT if you'll convert to 0/1
    quantity INT
);

-- changing table name
RENAME TABLE zepto_ds TO  zepto;

-- to know about columns
DESCRIBE zepto;


-- 1.total revenue
SELECT SUM(discountedSellingPrice * availableQuantity) / 100 AS Total_Revenue_INR
FROM zepto;


-- 2. Average dicount overall
SELECT ROUND(AVG(discountPercent), 2) AS Avg_Discount_Percent
FROM zepto;

-- 3. out of stock products count
SELECT COUNT(*) AS OutOfStock_Count
FROM zepto
WHERE outOfStock = 'True';

-- 4. top 5 products with most availabilty
SELECT name, availableQuantity
FROM zepto
ORDER BY availableQuantity DESC
LIMIT 5;


-- 5. total products per each category
SELECT Category, SUM(availableQuantity) AS Total_Inventory
FROM zepto
GROUP BY Category
ORDER BY Total_Inventory DESC;

-- 6. total revenue per each category
SELECT Category, SUM(discountedSellingPrice * availableQuantity)/100 AS Revenue_INR
FROM zepto
GROUP BY Category
ORDER BY Revenue_INR DESC;

-- 7.average discount , rate per each category
SELECT Category, 
       ROUND(AVG(discountPercent), 2) AS Avg_Discount,
       ROUND(AVG(discountedSellingPrice / mrp) * 100, 2) AS Avg_DiscountedRate
FROM zepto
GROUP BY Category;

-- 8 .top 10 products with high discount
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
ORDER By discountPercent DESC
LIMIT 10;


-- 9. top 10 expensive products low discount
SELECT DISTINCT NAME ,mrp , discountPercent
FROM zepto
where mrp > 500 and discountPercent <10
ORDER by mrp desc, discountPercent desc
limit 10;

-- 10.top 5 categories by average discount
SELECT Category, ROUND(AVG(discountPercent), 2) AS Avg_Discount
FROM zepto
GROUP BY Category
order by Avg_Discount DESC
limit 5;

-- 11. price per grams
select distinct name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) as price_per_gm
from zepto
where weightInGms >= 100
order by price_per_gm;

-- 12.product segmentation based on weights
select distinct name , weightInGms,
CASE when weightInGms < 1000 Then 'Low'
     when weightInGms < 5000 Then 'Medium'
     Else 'Bulk'
	 END as weight_category
from zepto;


