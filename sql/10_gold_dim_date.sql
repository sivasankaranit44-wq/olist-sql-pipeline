use olistdb;
go

drop table if exists gold.dim_date;
go

with dates as (
    select cast('2016-01-01' as date) as d
    union all
    select dateadd(day,1,d) from dates where d < '2018-12-31'
)
select year(d) * 10000 + month(d) * 100 + day(d) as date_key,
       d as full_date,
       year(d) as year_num,
       month(d) as month_num,
       datename(month,d) as month_name,
       datepart(quarter,d) as quarter_num,
       datename(weekday,d) as day_name
into gold.dim_date
from dates
option (maxrecursion 0)
go

select count(*) as dim_date from gold.dim_date;