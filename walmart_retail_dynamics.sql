--- Analyzing Walmart Retail Business and Customer Dynamics

create database Walmart;
use walmart;
select * from walmart;
describe walmart;

-- changing date datatype
alter table walmart modify Date date;

--- ----------------------------------------Feature Engineering---------------------------------------------
-- extracting year from a date column
select Year(Date) as year from walmart;
alter table walmart add column year int;
update walmart set year= year(date);

-- extracting month from a date column
select monthname(Date) as month from walmart;
alter table walmart add column month_name text not null;
update walmart set month_name = monthname(Date);

-- extracting dayname from a date column
select dayname(Date) as day_name from walmart;
alter table walmart add column day_name text;
update walmart set day_name = dayname(Date);

-- changing time data type
alter table walmart modify Time time;

-- extracting time of the day
select hour(Time) as hours from walmart;

-- New column time of day
alter table walmart add column time_of_day text;
update walmart set time_of_day = case
when `Time` between "00:00:00" and "11:59:59" then "Morning"
when `Time` between "12:00:00" and "15:59:59" then "Afternoon"
when `Time` between "16:00:00" and "19:59:59" then "Evening"
else "Night"
end;
select time_of_day, count(time_of_day) from walmart group by time_of_day; 

--- -------------------------------------Generic Question------------------------------------------------
-- How many unique cities does the data have?
select * from walmart;
select distinct City from walmart;

-- In which city is each branch?
select distinct city,branch from walmart;
--------------------------------------------------- Product ------------------------------------------------------------------
-- 1) How many unique product lines does the data have?   ## count nhi nikala
select distinct `Product line` from walmart;

-- 2) What is the most common payment method?
select count(payment),payment from walmart group by payment; 

-- What is the most selling product line?
select count(`Product line`) as `count`,`Product line` from walmart group by `Product line` order by `count` desc; # Quantity

-- What is the total revenue by month?
select sum(Total) as selling_price , month_name from walmart group by month_name order by selling_price;

-- What month had the largest COGS?
select sum(cogs) as lrg, month_name from walmart group by month_name order by lrg desc;

-- What product line had the largest revenue?
select `Product line`,sum(Total) as revenue from walmart group by `Product line` order by revenue desc;

-- What is the city with the largest revenue?
select City,sum(Total) as revenue from walmart group by City order by revenue desc;

-- What product line had the largest VAT?
select `Product line`,sum(`Tax 5%`) as VAT from walmart group by `Product line` order by VAT desc;

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
set @average = (select avg(Total) from walmart);
alter table walmart add column performance text;
update walmart set performance = case
when `Total` > @average then 'Good'
else 'Bad'
end;
select performance from walmart;

-- Which branch sold more products than average product sold
select sum(Quantity) as product_sold,Branch from walmart group by branch having sum(Quantity)>(select avg(Quantity) from walmart)order by product_sold desc ;

-- What is the most common product line by gender?
select * from walmart;
select count(`Gender`) as `count`, `Product line`,Gender from walmart group by Gender,`Product line` order by `count` desc;

-- What is the average rating of each product line?
select avg(Rating) as avg_rating,`Product line`from walmart group by `Product line` order by avg_rating desc;

--- --------------------------------Sales--------------------------------------------

-- Number of sales made in each time of the day per weekday    
select day_name,time_of_day,count(*) as sales from walmart where day_name In('Monday','Tuesday','Wednesday','Thursday','Friday')
group by time_of_day,day_name;

-- Which of the customer types brings the most revenue?
select sum(Total) as revenue,`Customer type` from walmart group by `Customer type` order by revenue desc;

-- Which city has the largest tax percent/ VAT (Value Added Tax)?
select city,sum(`Tax 5%`) as VAT from walmart group by city order by VAT desc;

-- Which customer type pays the most in VAT?
select `Customer type`, sum(`Tax 5%`) as VAT from walmart group by `Customer type` order by VAT desc;

--- ------------------------------------------------------- Customer ------------------------------------------------------------------

-- How many unique customer types does the data have?
select distinct `Customer Type` from walmart;

-- How many unique payment methods does the data have?
select distinct Payment from walmart;

-- What is the most common customer type?
select count(*),`Customer type` from walmart group by `Customer type`; 

-- Which customer type buys the most Quantity?
select sum(Quantity),`Customer type` from walmart group by `Customer type`; 

-- What is the gender of most of the customers?
select count(Gender) as count_gender,Gender from walmart group by Gender;

-- What is the gender distribution per branch?
SELECT Branch,
       Gender,
CONCAT(((COUNT(Gender) * 100.0 / SUM(COUNT(Gender)) OVER (PARTITION BY Branch))), '%') AS Percent_Dist
FROM walmart
GROUP BY Branch, Gender
ORDER BY Branch, Gender;

-- Which time of the day do customers give most ratings?
select time_of_day,count(rating) as count_rating from walmart group by time_of_day order by count_rating desc;

-- Which time of the day do customers give most ratings per branch?
select `Time_of_day`,count(rating),Branch from walmart group by `Time_of_day`,Branch;

-- Which day of the week has the best avg ratings?
select day_name,avg(Rating) as avg_rating from walmart group by day_name order by avg_rating desc limit 2;

-- Which day of the week has the best average ratings per branch?
select day_name,avg(Rating) as avg_rating,Branch from walmart group by day_name,Branch order by avg_rating desc;

--- -------------------------------------------END---------------------------------------------------------------------