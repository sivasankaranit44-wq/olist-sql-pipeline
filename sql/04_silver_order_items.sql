use olistdb;
go

drop table if exists silver.order_items;
go

select order_id, order_item_id, product_id, seller_id, TRY_CAST(shipping_limit_date as datetime2) as shipping_limit_ts,
TRY_CAST(price as decimal(10,2)) as price, TRY_CAST(freight_value as decimal(10,2)) as freight_value
into silver.order_items

from (select *, row_number() over(partition by order_id, order_item_id order by order_id) as rn
from bronze.order_items) t
where rn=1
go

select count(*) as silver_order_items from silver.order_items;
