--PIZZA SALES SQL QUERIES

select * from pizza_sales
--A.KPI'S

--1.Total Revenue
select sum(total_price) as total_revenue from pizza_sales;

--2.Average Order Value
select round(sum(total_price) / count (distinct(order_id)),2) as Avg_Order_Value
from pizza_sales

--3.Total Pizzas Sold
select sum (quantity) as total_pizza_sold from pizza_sales

--4.Total Orders
select count(distinct (order_id)) as total_orders from pizza_sales

--5.Average Pizzas Per Order
 select cast (cast (sum (quantity) as decimal (10,2)) / 
 cast (count (distinct order_id) as decimal (10,2)) as decimal (10,2)) as avg_pizzas_per_order
 from pizza_sales

 --B. Daily Trend for Total Orders

 select DATENAME(DW,order_date) as order_day, count (distinct order_id) as total_orders
 from pizza_sales
 group by DATENAME(DW,order_date)

 --C. Hourly Trends for Orders
 
 select DATEPART (HOUR,order_time) as order_hours, Count (distinct (order_id)) as total_orders
 from pizza_sales
group by DATEPART (HOUR,order_time)
order by DATEPART (HOUR,order_time)

--D Monthly Trend for Total Orders
 select DATENAME(month,order_date) as month_name, count(distinct order_id) as total_orders
 from pizza_sales
 group by DATENAME (month,order_date)
 order by total_orders desc

 --E % of Sales by Pizza Category
 select pizza_category,round(sum(total_price),2) as total_sales,round(sum (total_price)*100 /
 (select sum(total_price ) from pizza_sales where MONTH (order_date) = 1),2) as pct
 from pizza_sales 
 where MONTH (order_date) = 1
 group by pizza_category

 --F % of Sales by Pizza Size
 select pizza_size,round(sum(total_price),2) as total_sales,cast(sum (total_price)*100 /
 (select sum(total_price ) from pizza_sales  where DATEPART (quarter,order_date) =1) as decimal(10,2)) as pct
 from pizza_sales 
 where DATEPART (quarter,order_date) =1
 group by pizza_size
 order by pct desc

 --G. Total Pizzas Sold by pizza Category
 select pizza_category,sum(quantity) as total_quantity_sold
from pizza_sales
group by pizza_category
order by total_quantity_sold desc

--H. Top 5 Best sellers by Total Pizzas Sold
 select top 5 pizza_name , sum (total_price) as total_revenue from pizza_sales
 group by pizza_name
 order by total_revenue desc

 --I Bottom 5 Worst Sellers by Total Pizzas Sold
  select top 5 pizza_name , cast(sum (total_price) as decimal (10,2))as total_revenue from pizza_sales
 group by pizza_name
 order by total_revenue asc

 --J Top 5 Best sellers by Total Quantity Sold
   select top 5 pizza_name , cast(sum (quantity) as decimal (10,2))as total_quantity from pizza_sales
 group by pizza_name
 order by total_quantity desc

  --K Top 5 Worst sellers by Total Quantity Sold
     select top 5 pizza_name , cast(sum (quantity) as decimal (10,2))as total_quantity from pizza_sales
 group by pizza_name
 order by total_quantity asc

  --L Top 5 Best sellers by Total Orders Sold
    select top 5 pizza_name , count (distinct(order_id)) as total_orders from pizza_sales
 group by pizza_name
 order by total_orders desc

 --M Top 5 Worst sellers by Total Orders Sold
  select top 5 pizza_name , count (distinct(order_id)) as total_orders from pizza_sales
 group by pizza_name
 order by total_orders asc


 



