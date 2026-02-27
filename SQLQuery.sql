
select * from pizza_sales


select sum(total_price) as Total_Revenue from pizza_sales

select sum(total_price)/count(distinct order_id) as Average_Order_Value from pizza_sales

select sum(quantity) as Total_Pizza_Sold from pizza_sales

select count(distinct order_id) as Total_Order from pizza_sales

select cast(cast(sum(quantity) as decimal(10,2)) 
     / cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as Average_Pizza_Per_Order from pizza_sales

/* ============================ Số đơn hàng bán ra các NGÀY trong tuần  ===================*/

select DATENAME(DW, order_date) as Order_day , count(distinct order_id) as Total_orders from pizza_sales
group by DATENAME(DW, order_date)

/* ============================ Số đơn hàng bán ra các GIỜ trong ngày  ===================*/
select DATEPART(HOUR,order_time)   as Order_hour, count(distinct order_id) as Total_order from pizza_sales
group by DATEPART(HOUR,order_time) 
order by DATEPART(HOUR,order_time) 

/*============================= Tỉ lệ doanh thu bán theo DANH MỤC ========================*/
select pizza_category ,
		cast(sum(total_price)as decimal(10,2)) as Sold,
       cast(sum(total_price) *100.0 / 
	   (SELECT SUM(total_price) FROM pizza_sales)as decimal(10,2)) AS Percentage_sold 
from pizza_sales
group by pizza_category
ORDER BY Percentage_sold DESC;

/*========================= Số pizza bán ra theo danh mục=================*/
select pizza_category, sum(quantity) as Total_Pizza_Sold
from pizza_sales
group by pizza_category

/*========================= Top5 và Bot5 pizza bán ra nhiều nhất=================*/
select Top 5 pizza_name, sum(quantity) as Total_Pizza_Sold
from pizza_sales
group by pizza_name
order by Total_Pizza_Sold Desc

select top 5 pizza_name, sum(quantity) as Total_Pizza_Sold
from pizza_sales
where month(order_date)=1
group by pizza_name
order by Total_Pizza_Sold DESC
