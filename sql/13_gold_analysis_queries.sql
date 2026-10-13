use olistdb
go

select category,
revenue,
rank() over (order by revenue desc) as revenue_rank
from (
    select p.category, sum(f.price) as revenue
    from gold.fact_orders f
    join gold.dim_products p on f.product_id = p.product_id
    GROUP BY p.category
) x

order by revenue_rank;
GO

with cust as(
    select c.customer_unique_id,
    c.state,
    sum(f.price) as revenue
    from gold.fact_orders f
    join gold.dim_customers c on f.customer_id = c.customer_id
    group by c.customer_unique_id, c.state
)
select state, customer_unique_id, revenue, rn

from (
    select *, row_number() over(partition by state order by revenue DESC) as rn
    from cust
) t
where rn <=3
order by state, rn
GO

select c.state,
avg(f.delivery_days * 1.0)  as avg_delivery_days,
avg(datediff(day,f.purchase_ts, f.estimated_delivery_ts)*1.0) as avg_promised_days
from gold.fact_orders f
join gold.dim_customers c on f.customer_id = c.customer_id
group by c.state
order by avg_delivery_days desc;
go
