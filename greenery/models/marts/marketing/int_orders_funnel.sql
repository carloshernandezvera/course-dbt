{{ config(materialized='table') }}

WITH events AS (
                SELECT * 
                FROM {{ref('stg_greenery_events')}}
                ),

     orders AS (
                SELECT * 
                FROM {{ref('stg_greenery_orders')}}
                ),

     order_items AS (
                SELECT * 
                FROM {{ref('stg_greenery_order_items')}}
                ),

     orders_funnel AS (
                        SELECT session_id
                            , sgi.product_id
                            , quantity
                       FROM events sge
                            INNER JOIN orders sgo
                                USING(order_id)
                            INNER JOIN order_items sgi
                                USING(order_id)
                       WHERE event_type = 'checkout'
                      )
SELECT *
FROM orders_funnel