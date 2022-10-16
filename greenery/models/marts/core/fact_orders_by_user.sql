{{
    config(
        MATERIALIZED = 'table'
    )
}}

WITH orders AS (SELECT *
               FROM {{ref ('int_orders_by_user')}} 
              )

SELECT *
FROM orders