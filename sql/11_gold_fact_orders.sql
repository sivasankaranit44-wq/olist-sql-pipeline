USE OlistDB;
GO

DROP TABLE IF EXISTS gold.fact_orders;
GO


SELECT i.order_id,
       i.order_item_id,
       o.customer_id,
       i.product_id,
       i.seller_id,
       YEAR(o.purchase_ts) * 10000
         + MONTH(o.purchase_ts) * 100
         + DAY(o.purchase_ts)                        AS date_key,
       o.purchase_ts,
       o.delivered_ts,
       o.estimated_delivery_ts,
       i.price,
       i.freight_value,
       i.price + i.freight_value                     AS total_value,
       DATEDIFF(DAY, o.purchase_ts, o.delivered_ts)  AS delivery_days
INTO gold.fact_orders
FROM silver.order_items i
JOIN silver.orders o
  ON i.order_id = o.order_id
WHERE o.order_status = 'delivered';
GO

SELECT COUNT(*) AS fact_rows FROM gold.fact_orders;
GO
