{{
    config(
        MATERIALIZED = 'table'
    )
}}

WITH orders AS (SELECT *
                FROM {{ref ('stg_greenery_orders')}}
                )
   , final AS (SELECT USER_ID
                    , COUNT(distinct ORDER_ID) AS num_orders
                    , SUM(ORDER_COST)          AS total_orders_amount
                    , ROUND(AVG(ORDER_COST),2) AS avg_order_cost
                    , SUM (SHIPPING_COST)      AS total_shipping_amount
               FROM orders
               GROUP BY USER_ID)

SELECT * FROM final