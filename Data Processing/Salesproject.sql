--Prview the data
select * from `workspace`.`sales`.`sales_case_study_2` limit 100;
--Get MIN and MAX date
SELECT
  MIN(DATE) AS min_date,
  MAX(DATE) AS max_date
  --Aggregate Sales metric
SELECT
SUM(Sales) AS total_sales,
SUM(`Cost Of Sales`) AS total_cost_of_sales,
SUM(`Quantity Sold`)
AS total_quantity_sold
FROM workspace.sales.sales_case_study_2
-- Average unit price (total sales divided by total quantity sold)
SELECT
  SUM(Sales) / SUM(`Quantity Sold`) AS avg_unit_price
FROM workspace.sales.sales_case_study_2
-- Percentage gross profit ((Sales - Cost Of Sales) / Sales * 100)
SELECT
  (SUM(Sales) - SUM(`Cost Of Sales`)) / SUM(Sales) * 100 AS percent_gross_profit
FROM workspace.sales.sales_case_study_2
--Average daily sale price
SELECT
  AVG(daily_sale_price) AS avg_sale_price
FROM (
  SELECT
    Date,
    SUM(Sales) AS daily_sale_price
  FROM workspace.sales.sales_case_study_2
  GROUP BY Date
);
-- Query 4: Extract date parts and classify day of weekand daily sale price
SELECT
  Date,
  Sales,
  `Cost Of Sales`,
  `Quantity Sold`,
  SUM(Sales) AS daily_sale_price,
  YEAR(Date) AS Sale_YEAR,
  DATE_FORMAT(Date, 'MMMM') AS Sale_MONTH,
  DAY(Date) AS Sale_DAY_OF_MONTH,
  DATE_FORMAT(Date, 'EEEE') AS Sale_DAY_NAME,
  CASE
    WHEN DATE_FORMAT(Date, 'EEEE') NOT IN ('Saturday', 'Sunday') THEN 'WEEKDAY'
    ELSE 'WEEKEND'
  END AS DAY_OF_WEEK_CLASSIFICATION
FROM workspace.sales.sales_case_study_2
GROUP BY ALL;
