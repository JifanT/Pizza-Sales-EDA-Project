set sql_safe_updates=0; /* disables the safe update mode */
CREATE DATABASE PIZZA; /* creating database */
USE PIZZA; /* selecting PIZZA databse */
select * from pizzasales; /* showing all datas from pizzasales data */
select count(order_id) from pizzasales; /* to check number of rows */
select sum(total_price) as total_revenue from pizzasales; /* total pizza sale revnue */
select sum(total_price)/count(distinct order_id) as avg_order_value from pizzasales; /* avg order price */
select sum(quantity)/count(distinct order_id) as avg_pizza_per_order from pizzasales; /* avg number of Pizza per order */
select sum(quantity) as total_pizzas_sold from pizzasales; /* total number of Pizza sold */
select count(distinct order_id) as total_orders from pizzasales; /* total number of orders */
select 
	cast(
		sum(quantity)/
		count(distinct order_id)
        as decimal(10,2)
	) as avg_pizzas_per_order 
from pizzasales; /* avg Pizza sold per order */
update pizzasales set order_date=str_to_date(order_date,'%d-%m-%Y'); /* updates the order_date into a standardized date format that MySQL can recognize and process */
alter table pizzasales modify order_date date; /* modify the column datatype from text to date */
select
	dayname(order_date) as order_day,
	count(distinct order_id) as total_orders
from pizzasales group by dayname(order_date); /* number of orders on specific week days */
update pizzasales set order_time=str_to_date(order_time,'%H.%i.%s'); /* updates the order_time into a standardized date format that MySQL can recognize and process */
alter table pizzasales modify order_time time; /* modify the column datatype from text to time */
select
	hour(order_time) as hour_of_the_day,
    count(distinct order_id) as no_of_orders
from pizzasales group by hour(order_time); /* Hourly trend for orders */
select 
	pizza_category,
    round(sum(total_price),2) as total_revenue,
    round(sum(total_price)/(select sum(total_price) from pizzasales)*100,2) as percentage_of_category
from pizzasales group by pizza_category; /* percentage of Sales by Pizza Category */
select
	pizza_size,
    round(sum(total_price),2) as total_revenue,
    round(sum(total_price)/(select sum(total_price) from pizzasales)*100,2) as percentage_of_size
from pizzasales group by pizza_size order by(total_revenue)desc; /* percentage of Sales by Pizza size */
select
	pizza_name,
    sum(quantity) as total_quantity,
    round(sum(quantity)/(select sum(quantity) from pizzasales) * 100,2) as percentage_of_pizzatype
from pizzasales group by pizza_name order by percentage_of_pizzatype desc; /* percentage of Sales by Pizza type */
select
	pizza_category,
    sum(quantity) as total_quantity_sold
from pizzasales group by pizza_category; /* total quantity of Pizza sold by each category */
select
	pizza_name,
    sum(total_price) as total_revenue
from pizzasales group by pizza_name order by sum(total_price) desc limit 5; /* Top 5 best revenue Pizzas */
select
	pizza_name,
    sum(quantity) as total_quantity_sold
from pizzasales group by pizza_name order by sum(quantity) desc limit 5; /* Top 5 best selling Pizzas */
select
	pizza_name,
    round(sum(total_price),2) as total_revenue
from pizzasales group by pizza_name order by sum(total_price) asc limit 5; /* least 5 revenue Pizzas */
select
	pizza_name,
    sum(quantity) as total_quantity_sold
from pizzasales group by pizza_name order by sum(quantity) asc limit 5; /* least 5 selling Pizzas */