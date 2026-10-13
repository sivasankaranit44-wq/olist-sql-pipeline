use olistdb;
go

drop table if exists gold.dim_customers
go

select customer_id, customer_unique_id, city, state into gold.dim_customers from silver.customers;
go

select count(*) as dim_customers_count from gold.dim_customers;