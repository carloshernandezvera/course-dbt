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

     purchases_by_product AS (SELECT sge.user_id
                                   , sge.session_id
                                   , sgo.order_id
                                   , sgoi.product_id
                                   , sgoi.quantity
                              FROM events  sge
                                    INNER JOIN orders sgo
                                        USING (order_id)
                                    INNER JOIN order_items sgoi
                                        USING (order_id)
                              WHERE sge.event_type = 'checkout')
SELECT *
FROM purchases_by_product