USE OlistDB;
GO

DROP TABLE IF EXISTS gold.dim_products;
GO

SELECT product_id,
       category_en AS category,
       weight_g,
       length_cm,
       height_cm,
       width_cm
INTO gold.dim_products
FROM silver.products;
GO

SELECT COUNT(*) AS dim_products FROM gold.dim_products;