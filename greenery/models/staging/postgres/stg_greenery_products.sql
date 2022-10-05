{{
    config(
        MATERIALIZED = 'view'
    )
}}

WITH products_source AS (SELECT PRODUCT_ID
                              , NAME
                              , PRICE
                              , INVENTORY
                       FROM {{ source('src_greenery', 'products') }}
                       )
SELECT *
FROM products_source