use olistdb
go

create or alter PROCEDURE gold.usp_sales_by_date_range
@StartDate DATE,
@EndDate DATE
as
BEGIN set NOCOUNT ON

select d.full_date,
count(distinct f.order_id) as orders,
sum(f.price) as revenue
from gold.fact_orders f
join gold.dim_date d
on f.date_key = d.date_key
where d.full_date between @StartDate and @EndDate
GROUP BY d.full_date
ORDER BY d.full_date;
END;
GO
EXEC gold.usp_sales_by_date_range @StartDate = '2017-11-01', @EndDate = '2017-11-30'
go
