# 🛒 Zepto E-commerce Inventory Analysis (Data Business Analysis0
This project simulates a real-world business analyst case study inspired by Zepto, one of India’s fastest-growing quick-commerce startups. The goal was to uncover actionable insights from product inventory data using SQL and visualize them using Power BI.

#  Project Overview

-  **Dataset:** 3,700+ product-level entries from a mock Zepto inventory
-  **Objective:** Analyze pricing, discount trends, stock status, and category-level performance
-  **Tools Used:** MySQL, Power BI, Excel, Canva

## 🎯 Project Goal

To simulate how a data/business analyst at a fast-paced e-commerce company like Zepto would:
- Analyze real-world inventory data using SQL
- Generate insights on pricing, discounts, and stock levels
- Segment products to support delivery, packaging, and promotions
- Communicate findings through visual reports for business decisions


## 🧾 Dataset Schema

| Column Name             | Description                                    |
|-------------------------|------------------------------------------------|
| sku_id                  | Unique product ID                             |
| name                    | Product name                                   |
| category                | Product category (Dairy, Fruits, Snacks, etc.) |
| mrp                     | Maximum Retail Price (₹)                       |
| discountPercent         | % Discount applied                             |
| discountedSellingPrice  | Final price after discount                     |
| availableQuantity       | Units available in stock                       |
| weightInGms             | Product weight (grams)                         |
| outOfStock              | Boolean flag for stock status                  |




## 📊 Data Exploration — Zepto Dataset

Before diving into business insights, essential SQL queries were executed to explore the structure, cleanliness, and schema of the Zepto inventory dataset.

---

### 1. 🔢 Total Rows in the Dataset

```sql
SELECT COUNT(*) FROM zepto;
```

💡 **Insight**: The dataset contains 3,732 product-level records (SKUs).

---

### 2. 🧾 View Sample Records

```sql
SELECT * FROM zepto LIMIT 10;
```

💡 **Insight**: Used to observe patterns and detect data anomalies in the first few rows.

---

### 3. 🧬 Check Column Data Types

```sql
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'zepto';
```

💡 **Insight**: Confirms correct data types (numeric, boolean, etc.) for each column.

---

### 4. 🚨 Check for NULL or Missing Values

```sql
SELECT *
FROM zepto
WHERE name IS NULL OR category IS NULL OR mrp IS NULL
   OR discountPercent IS NULL OR availableQuantity IS NULL
   OR discountedSellingPrice IS NULL OR weightInGms IS NULL
   OR outOfStock IS NULL OR quantity IS NULL;
```

💡 **Insight**: Ensures completeness — no missing data detected in key columns.

---

### 5. ❗ Detect Invalid Prices (MRP or Selling Price = 0)

```sql
SELECT * FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;
```

💡 **Insight**: Flags products with zero price that may need cleaning or exclusion.

---

### 6. 🏷️ Distinct Product Categories

```sql
SELECT DISTINCT category FROM zepto ORDER BY category;
```

💡 **Insight**: Lists all unique product categories — useful for segmentation.

---

### 7. 📦 Find Duplicate Product Names

```sql
SELECT name, COUNT(*) AS count
FROM zepto
GROUP BY name
HAVING COUNT(*) > 1;
```


💡 Insight: Highlights same products offered in different sizes or packs.



## 🔍 Key SQL Queries and Business Insights

These queries were designed to extract strategic insights around pricing, revenue, discounts, and inventory planning.

---

### 1. 🔟 Top 10 Discounted Products

```sql
SELECT name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;
```

💡 **Insight**: Identifies products with the highest discounts — ideal for marketing and upselling.

---

### 2. 💰 Revenue by Category

```sql
SELECT category,
       SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue DESC;
```

💡 **Insight**: Reveals which product categories are generating the most revenue.

---

### 3. 🧊 High-MRP Products with Low Discounts

```sql
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC
LIMIT 10;
```

💡 **Insight**: Surfaces premium items that are under-promoted — great candidates for spotlight offers.

---

### 4. ⚖️ Product Segmentation by Weight

```sql
SELECT DISTINCT name, weightInGms,
  CASE
    WHEN weightInGms < 1000 THEN 'Low'
    WHEN weightInGms < 5000 THEN 'Medium'
    ELSE 'Bulk'
  END AS weight_category
FROM zepto;
```

💡 **Insight**: Helps classify products by packaging size — useful for logistics and warehousing.

---

### 5. 📉 Price Per Gram Analysis

```sql
SELECT name, weightInGms, discountedSellingPrice,
       ROUND(discountedSellingPrice / weightInGms, 2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram;
```

💡 **Insight**: Evaluates best value-for-money products based on pricing per gram.

---



## 📈 Business Impact

This project demonstrates how SQL-driven analysis and Power BI visualizations can support:
- **Revenue optimization** by identifying underperforming or high-MRP products with low discounts
- **Inventory management** by flagging out-of-stock yet high-demand products
- **Operational strategy** through weight-based segmentation to guide logistics and fulfillment
- **Category-level marketing** via discount and price-per-gram analysis to target promotions






