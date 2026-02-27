# 🍕 Pizza Sales Analysis

A data analysis project exploring pizza sales performance using **SQL Server** and **Excel**, including KPI tracking, trend analysis, and an interactive dashboard.


## 📊 Dashboard Preview

![Pizza Sales Dashboard](dashboard.png)

<img width="1161" height="627" alt="image" src="https://github.com/user-attachments/assets/1738e95c-7f75-4592-99af-d7bd1ca02b07" />


## 🎯 Objective

Analyze 12 months of pizza sales data to uncover:
- Overall business performance (revenue, orders, quantity sold)
- Busiest days and peak hours
- Best and worst performing pizzas
- Sales distribution by category and size


## 🛠️ Tools Used

| Tool | Purpose |
|------|---------|
| SQL Server | Data import, querying, KPI calculation |
| Excel | Data cleaning, Pivot Tables, Dashboard |


## 📌 Dataset Overview

- **Source:** Pizza sales transaction data (CSV)
- **Size:** 48,000+ records
- **Period:** Full year (2015)
- **Fields:** Order ID, Pizza Name, Category, Size, Quantity, Price, Date, Time


## 📐 SQL — KPIs Calculated

```sql
-- Total Revenue
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales

-- Average Order Value
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value FROM pizza_sales

-- Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales

-- Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) 
     / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) 
     AS Avg_Pizza_Per_Order FROM pizza_sales
```

---

## 📐 SQL — Trend & Category Queries

```sql
-- Daily Trend
SELECT DATENAME(DW, order_date) AS Order_Day, 
       COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

-- Hourly Trend
SELECT DATEPART(HOUR, order_time) AS Order_Hour, 
       COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

-- Revenue % by Category
SELECT pizza_category,
       CAST(SUM(total_price) AS DECIMAL(10,2)) AS Revenue,
       CAST(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS Pct
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Pct DESC

-- Top 5 Best Sellers
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC

-- Bottom 5 Worst Sellers
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
```

---

## 🧹 Excel — Data Cleaning & Processing

- Imported data directly from SQL Server into Excel
- **Data Cleaning:** Converted pizza size codes → full names
  - `S` → Regular, `M` → Medium, `L` → Large, `XL` → X-Large, `XXL` → XX-Large
- **Data Processing:** Added `order_day` column using formula to extract day of week from `order_date`
- Built Pivot Tables for all KPIs and charts
- Created interactive Timeline Slicer by `order_date`

---

## 📈 Key Findings

### 💰 Business Performance
| Metric | Value |
|--------|-------|
| Total Revenue | $817,860 |
| Total Orders | 21,350 |
| Total Pizzas Sold | 49,574 |
| Avg Order Value | $38.31 |
| Avg Pizzas Per Order | 2.32 |

### 📅 Busiest Days & Times
- **Peak days:** Friday (3,538 orders) and Saturday (3,158 orders)
- **Peak hours:** 12:00–13:00 and 17:00–18:00
- **Slowest day:** Sunday (2,624 orders)

### 🍕 Category & Size
- **Classic** category leads with 26.91% of total revenue
- **Large** size dominates at 45.89% of revenue
- All 4 categories are fairly balanced (23–27% each)

### 🏆 Best & Worst Sellers
- **Best seller:** The Classic Deluxe Pizza (2,453 units)
- **Worst seller:** The Brie Carre Pizza (490 units) — significantly below others

---

## 💡 Insights & Recommendations

1. **Staff up on Fridays and Saturdays** — these two days account for the highest order volume, consider increasing staff and ingredient prep
2. **Double down on Classic category** — highest revenue contributor, potential for upselling combos
3. **Review Brie Carre Pizza** — selling less than half of the next worst seller, consider replacing or promoting
4. **Capitalize on lunch & dinner rush** — 12–1pm and 5–8pm are peak windows, ensure fast service during these hours
5. **Upsell Large size** — already the top size by revenue, could bundle with drinks or sides

---

## 📝 Notes

> This is a guided practice project built to strengthen SQL querying and Excel dashboard skills. Data source and tutorial reference: [YouTube - Data Tutorials]

---
