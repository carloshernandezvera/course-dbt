{{
    config(
        MATERIALIZED = 'view'
    )
}}

WITH order_items_source AS (SELECT ORDER_ID
                                 , PRODUCT_ID
                                 , QUANTITY
                       FROM {{ source('src_greenery', 'order_items') }}
                       )
SELECT *
FROM order_items_source