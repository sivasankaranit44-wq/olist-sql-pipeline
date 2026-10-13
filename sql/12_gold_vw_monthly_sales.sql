USE OlistDB;
GO

CREATE OR ALTER VIEW gold.vw_monthly_sales AS
WITH monthly_sales AS (
    SELECT d.year_num,
           d.month_num,
           d.month_name,
           SUM(f.price)               AS revenue,
           COUNT(DISTINCT f.order_id) AS orders
    FROM gold.fact_orders f
    JOIN gold.dim_date d
      ON f.date_key = d.date_key
    GROUP BY d.year_num, d.month_num, d.month_name
)
SELECT year_num,
       month_num,
       month_name,
       revenue,
       orders,
       LAG(revenue) OVER (ORDER BY year_num, month_num) AS prev_month_revenue,
       ROUND(
           (revenue - LAG(revenue) OVER (ORDER BY year_num, month_num)) * 100.0
           / NULLIF(LAG(revenue) OVER (ORDER BY year_num, month_num), 0)
       , 2) AS mom_growth_pct,
       SUM(revenue) OVER (ORDER BY year_num, month_num) AS running_revenue
FROM monthly_sales;
GO

SELECT * FROM gold.vw_monthly_sales ORDER BY year_num, month_num;
