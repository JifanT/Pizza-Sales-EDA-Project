set sql_safe_updates=0;
CREATE DATABASE PIZZA;
USE PIZZA;
select * from pizzasales;
select count(order_id) from pizzasales;
select sum(total_price) as total_revenue from pizzasales;
select sum(total_price)/count(distinct order_id) as avg_order_value from pizzasales;
select sum(quantity)/count(distinct order_id) as avg_pizza_per_order from pizzasales;
select sum(quantity) as total_pizzas_sold from pizzasales;
select count(distinct order_id) as total_orders from pizzasales;
select 
	cast(
		cast(sum(quantity) as decimal(10,2))/
		cast(count(distinct order_id) as decimal(10,2)) 
        as decimal(10,2)
	) as avg_pizzas_per_order 
from pizzasales;
update pizzasales set order_date=str_to_date(order_date,'%d-%m-%Y');
alter table pizzasales modify order_date date;
select
	dayname(order_date) as order_day,
	count(distinct order_id) as total_orders
from pizzasales group by dayname(order_date);
update pizzasales set order_time=str_to_date(order_time,'%H.%i.%s');
alter table pizzasales modify order_time time;
select
	hour(order_time) as hour_of_the_day,
    count(distinct order_id) as no_of_orders
from pizzasales group by hour(order_time);
select 
	pizza_category,
    round(sum(total_price),2) as total_revenue,
    round(sum(total_price)/(select sum(total_price) from pizzasales)*100,2) as percentage_of_category
from pizzasales group by pizza_category;
select
	pizza_size,
    round(sum(total_price),2) as total_revenue,
    round(sum(total_price)/(select sum(total_price) from pizzasales)*100,2) as percentage_of_size
from pizzasales group by pizza_size order by(total_revenue)desc;
select
	pizza_name,
    sum(quantity) as total_quantity,
    round(sum(quantity)/(select sum(quantity) from pizzasales) * 100,2) as percentage_of_pizzatype
from pizzasales group by pizza_name order by percentage_of_pizzatype desc;
select
	pizza_category,
    sum(quantity) as total_quantity_sold
from pizzasales group by pizza_category;
select
	pizza_name,
    sum(total_price) as total_revenue
from pizzasales group by pizza_name order by sum(total_price) desc limit 5;
select
	pizza_name,
    sum(quantity) as total_quantity_sold
from pizzasales group by pizza_name order by sum(quantity) desc limit 5;
select
	pizza_name,
    round(sum(total_price),2) as total_revenue
from pizzasales group by pizza_name order by sum(total_price) asc limit 5;
select
	pizza_name,
    sum(quantity) as total_quantity_sold
from pizzasales group by pizza_name order by sum(quantity) asc limit 5;