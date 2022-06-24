-- Show tables
select * from Giang_Portfolio..Orders
select * from Giang_Portfolio..Returned

-- Standardize date format
alter table Giang_Portfolio..Orders
add Order_date date,
	Ship_date date;

update Giang_Portfolio..Orders
set Order_date = convert(Date, [Order Date]),
    Ship_date = convert(Date, [Ship Date])

alter table Giang_Portfolio..Orders
drop column [Order Date], [Ship Date]

-- Sales, profit, shipping cost in total and gross margin each year
select datepart(yyyy, [Order_date]) as Year, sum(Sales) as Total_sales, 
sum(Profit) as Total_profit, 
sum([Shipping Cost]) as Total_shipcost,
(sum(Profit)/sum(Sales))*100 as Gross_margin
from Giang_Portfolio..Orders
group by datepart(yyyy, [Order_date])
order by 1

-- Total sales, profit and quantity for each Category each year
select datepart(yyyy, [Order_date]) as Year, Category, 
sum(Sales) as Total_sales,
sum(Profit) as Total_profit,
sum(Quantity) as Total_quantity
from Giang_Portfolio..Orders
group by datepart(yyyy, [Order_date]), Category
order by 1, 2

-- The most common market each year
select datepart(yyyy, [Order_date]) as Year, Market, count(Market) as Numbers
from Giang_Portfolio..Orders
group by datepart(yyyy, [Order_date]), Market
order by 1, 3 desc

-- The number of customers of each country in 4 years
select Country, count(distinct[Customer ID]) as Numbers_customers
from Giang_Portfolio..Orders
group by Country
order by 2 desc

-- Countries with higher sales and profit compared to average value
select Country, Region, Category, Sales, Profit
from Giang_Portfolio..Orders
where Sales > (select avg(Sales) from Giang_Portfolio..Orders)
and Profit > (select avg(Profit) from Giang_Portfolio..Orders)

-- Top 3 products were sold mostly each year
select OS.*
from (select datepart(yyyy, S.[Order_Date]) as Year, O.[Sub-Category],
sum(Quantity) as Quantity,
rank() over (partition by datepart(yyyy, S.[Order_Date])
order by sum(Quantity) desc) as Seq
from Giang_Portfolio..Orders O
left join Summary S
on O.[Order ID] = S.Order_ID
group by O.[Sub-Category], datepart(yyyy, S.[Order_Date])) OS
where Seq <= 3

-- Join Returned table
select A.[Order ID], A.[Customer ID], A.[Customer Name], A.Country, A.Market, 
A.Category, A.Sales, A.Discount, A.Profit, A.[Shipping Cost],
case when Returned is not null then Returned else 'No' end as Returned -- Replace null value by 'No'
from Giang_Portfolio..Orders A
left join Giang_Portfolio..Returned B
on A.[Order ID] = B.[Order ID]
and A.Region = B.Region

-- Create table
Drop table if exists Summary
Create Table Summary
(
Order_ID char (255),
Order_Date date,
Customer_ID char (255),
CustomerName char (255),
Country char (255),
Market char (255),
Category char (255),
Sales decimal (10, 5),
Discount decimal (10, 1),
Profit decimal (10, 5),
Shipcost decimal (10, 5),
Returned char (255)
)

insert into Summary
select A.[Order ID], A.[Order_date], A.[Customer ID], A.[Customer Name], A.Country, A.Market, 
A.Category, A.Sales, A.Discount, A.Profit, A.[Shipping Cost],
case when Returned is not null then Returned else 'No' end as Returned -- Replace null value by 'No'
from Giang_Portfolio..Orders A
left join Giang_Portfolio..Returned B
on A.[Order ID] = B.[Order ID]
and A.Region = B.Region
select * from Summary

-- Top 3 products had the highest gross margin each year
select OS.*
from (select datepart(yyyy, S.[Order_Date]) as Year, O.[Sub-Category],
(sum(O.Profit)/sum(O.Sales))*100 as Gross_margin,
rank() over (partition by datepart(yyyy, S.[Order_Date])
order by (sum(O.Profit)/sum(O.Sales))*100 desc) as Seq
from Giang_Portfolio..Orders O
left join Summary S
on O.[Order ID] = S.Order_ID
group by O.[Sub-Category], datepart(yyyy, S.[Order_Date])) OS
where Seq <= 3

-- The number of return
select Returned, count(Returned)as Return_numbers
from Summary
group by Returned 

-- The number of return in each category
select Category, Returned, count(Returned) as Return_numbers
from Summary
group by Category, Returned
order by 1

-- The percentage of Return of each category 
select datepart(yyyy, Order_Date) as Year, Category, 
(sum(case when Returned = 'Yes' then 1.00 else 0.00 end)/count(*))*100 as Yes,
(sum(case when Returned = 'No' then 1.00 else 0.00 end)/count(*))*100 as No
from Summary
group by datepart(yyyy, Order_Date), Category
order by 1, 2

-- Create view 
drop view if exists Total
create view Total as
select datepart(yyyy, [Order_date]) as Year, Region,
sum(Sales) as Total_sales, 
sum(Profit) as Total_profit, 
sum([Shipping Cost]) as Total_shipcost,
(sum(Profit)/sum(Sales))*100 as Gross_margin
from Giang_Portfolio..Orders
group by datepart(yyyy, [Order_date]), Region
select * from Total