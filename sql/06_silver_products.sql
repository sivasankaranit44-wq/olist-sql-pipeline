use olistdb;
go

drop table if exists silver.order_payments;
go

select p.product_id, p.product_category_name as category, 
COALESCE(t.product_category_name_english, p.product_category_name, 'Unknown') as category_en,
TRY_CAST(p.product_weight_g as INT) as weight_g,
TRY_CAST(p.product_length_cm as INT) as length_cm,
TRY_CAST(p.product_height_cm as INT) as height_cm,
TRY_CAST(p.product_width_cm as INT)  as width_cm
into silver.products

from (
    select *, 
    row_number() over(partition by product_id order by product_id) as rn
 from bronze.products) p
 left join bronze.product_category_name_translation t on p.product_category_name = t.product_category_name
 where p.rn = 1;
 go

 select count(*) as silver_products from silver.products;
 