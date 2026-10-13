use olistdb
GO

ALTER TABLE gold.fact_orders ALTER COLUMN customer_id VARCHAR(32)
go

create NONCLUSTERED INDEX ix_fact_orders_date_key
ON gold.fact_orders (date_key)
INCLUDE (order_id, price)
GO

create NONCLUSTERED INDEX ix_fact_orders_customer_id
ON gold.fact_orders (customer_id)
GO