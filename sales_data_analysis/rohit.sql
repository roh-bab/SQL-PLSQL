--How the data looks like
Select * from SALES_DATA_1;
Select count(1) from SALES_DATA_1;

-- mean of customer age
Select round(avg(customer_age),2) from SALES_DATA_1;

-- mean of order quantity
Select round(avg(order_quantity),2) from SALES_DATA_1;

--sales per year
Select year_,count(1) from Sales_data_1 group by year_;

--sales per year (all year)
Select month_,count(1) from Sales_data_1 group by month_;

--sales per country
Select country,count(1) from Sales_data_1 group by country;

--all product list
Select distinct product from sales_data_1;

--country and profit
Select country,sum(profit) from sales_data_1 group by country;

--How many orders were made in Canada or France show the sum of total orders
Select 'Orders from Canada or France',count(country) from sales_data_1 where country in ('Canada','France');

--How many Bike racks were purchased fom Canada
Select  'Canada - Bike Racks' , count(sub_category) from sales_data_1 where country = 'Canada' and sub_category = 'Bike Racks';

--How many sales in each region of France
Select country,state,count(state) from sales_data_1 where country = 'France' group by country,state;

--What is the mean Order_Quantity of orders with more than 10K in revenue?
select round(avg(order_quantity),2) from sales_data_1 where revenue > 10000 ;

--How many orders were made in May of 2016?
Select count(order_quantity) from sales_data_1 where month_ = 'May' and year_ = '2016';

--How many orders were made between May and July of 2016?
Select count(*) from sales_data_1 where month_ in ('May','June','July') and year_ = '2016';

--Which gender has most amount of sale?
Select customer_gender,number_of_sales,case when rownum =1 then 'Highest sale' end from (Select customer_gender,count(customer_gender) number_of_sales 
from sales_data_1 group by customer_gender order by number_of_sales desc) order by number_of_sales desc;

--How many sales with more than 500 in revenue is made by men
Select 'Men Sales' , count(customer_gender) from sales_data_1 where customer_gender = 'M' and revenue > 500;

--Get the top 5 sales with highest revenue
Select * from sales_data_1 order by revenue desc fetch first 5 rows only;
