use olistdb;
go

drop table if exists silver.customers;
go

select customer_id, customer_unique_id, customer_zip_code_prefix as zip_prefix, upper(TRIM(customer_city)) as city, upper(TRIM(customer_state)) as state
INTO silver.customers

from(select *, row_number() over(partition by customer_id order by customer_id)as rn 
from bronze.customers) t
where rn=1
GO
select count(*) as silver_customer from silver.customers;
