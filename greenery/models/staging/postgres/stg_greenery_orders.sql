{{
    config(
        MATERIALIZED = 'view'
    )
}}

WITH orders_source AS (SELECT ORDER_ID
                            , CREATED_AT
                            , ESTIMATED_DELIVERY_AT
                            , DELIVERED_AT
                            , STATUS
                            , USER_ID
                            , TRACKING_ID
                            , ADDRESS_ID
                            , PROMO_ID
                            , SHIPPING_SERVICE
                            , ORDER_COST
                            , SHIPPING_COST
                            , ORDER_TOTAL
                       FROM {{ source('src_greenery', 'orders') }}
                       )
SELECT *
FROM orders_source