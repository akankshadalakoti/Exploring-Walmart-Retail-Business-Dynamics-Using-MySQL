# EXPLORING WALMART RETAIL BUSINESS AND CUSTOMER DYNAMICS USING MySQL.
## Project Overview

This project involves analyzing Walmart sales data using MySQL. The dataset provides comprehensive details about sales transactions, including product specifics, customer demographics, and transaction timings. The goal is to uncover actionable insights regarding product performance, sales trends, and customer behavior.

## Dataset Source

The dataset for this analysis is sourced from Kaggle:
- [Walmart Recruiting - Store Sales Forecasting](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting)

## Database Schema

The `walmart` database includes the following columns:
- `Invoice ID`
- `Branch`
- `City`
- `Customer type`
- `Gender`
- `Product line`
- `Unit price`
- `Quantity`
- `Tax 5%`
- `Total`
- `Date`
- `Time`
- `Payment`
- `cogs`
- `gross margin percentage`
- `gross income`
- `Rating`
- `year`
- `month_name`
- `day_name`
- `time_of_day`
- `performance`

## Analytical Insights

### Feature Engineering

- **Date and Time Analysis**: The dataset was enhanced by extracting and incorporating information such as the year, month, and day of the week from the transaction dates. Time of day was categorized into Morning, Afternoon, Evening, and Night to analyze sales patterns throughout the day.

### General Insights

- **Unique Cities**: Identified all unique cities where Walmart branches are located.
- **Branch-City Mapping**: Analyzed the association between cities and the branches operating within them.

### Product Analysis

- **Product Lines**: Determined the distinct product lines available and assessed which lines are most frequently sold.
- **Payment Methods**: Evaluated the most common payment methods used by customers.
- **Sales Performance**: Analyzed which product lines generated the highest revenue and which city had the highest revenue.
- **COGS and VAT**: Investigated the product line with the largest Cost of Goods Sold (COGS) and the product line with the highest VAT.

### Revenue and Performance

- **Revenue by Month**: Calculated the total revenue generated each month.
- **Product Line Performance**: Identified product lines with above-average sales performance.
- **City Revenue**: Found which city contributed the most to the overall revenue.

### Customer Insights

- **Customer Types**: Analyzed which customer type generates the most revenue and which pays the most VAT.
- **Gender Distribution**: Examined the distribution of gender across branches and identified the gender that frequents Walmart the most.
- **Customer Ratings**: Investigated the average customer ratings by time of day and day of the week to identify trends in customer satisfaction.

## Conclusion

The analysis provides valuable insights into sales performance, customer behavior, and product preferences. By understanding these aspects, Walmart can optimize its operations, enhance customer satisfaction, and increase overall profitability.
