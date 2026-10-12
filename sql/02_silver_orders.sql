use olistdb;
go

drop table if exists silver.orders;
go

select order_id, customer_id, order_status, TRY_CAST(order_purchase_timestamp as datetime2) as purchase_ts,
TRY_CAST(order_approved_at as datetime2) as approved_ts,
TRY_CAST(order_delivered_carrier_date as datetime2) as carrier_ts,
TRY_CAST(order_delivered_customer_date as datetime2) as delivered_ts,
TRY_CAST(order_estimated_delivery_date as datetime2) as estimated_delivery_ts
into silver.orders

from(select * , row_number() over(partition by order_id order by order_purchase_timestamp) as rn
from bronze.orders ) t where rn =1 
go

select count(*) as silver_orders_count from silver.orders;
