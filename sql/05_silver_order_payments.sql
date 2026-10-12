use olistdb;
go

drop table if exists silver.order_payments;
go

select order_id, payment_sequential, payment_type, payment_installments, TRY_CAST(payment_value as decimal(10,2))as payment_value into silver.order_payments

from (select *, row_number() over(partition by order_id, payment_sequential order by order_id) as rn 

from bronze.order_payments) t
where rn=1;
go
select count(*) as silver_order_payments_count from silver.order_payments;
