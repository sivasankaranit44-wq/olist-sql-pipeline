USE OlistDB;
GO

DROP TABLE IF EXISTS silver.order_reviews;
GO

SELECT review_id,
       order_id,
       TRY_CAST(review_score AS INT)                  AS review_score,
       TRY_CAST(review_creation_date AS DATETIME2)    AS review_created_ts,
       TRY_CAST(review_answer_timestamp AS DATETIME2) AS review_answered_ts
INTO silver.order_reviews
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY review_id, order_id
               ORDER BY review_answer_timestamp DESC
           ) AS rn
    FROM bronze.order_reviews
) AS src
WHERE rn = 1;
GO

SELECT COUNT(*) AS silver_order_reviews_count FROM silver.order_reviews;