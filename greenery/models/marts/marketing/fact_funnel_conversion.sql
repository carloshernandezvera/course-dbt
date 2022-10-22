{{ config(materialized='table') }}

WITH events AS (
                SELECT * 
                FROM {{ref('int_events_by_product')}}
                ),

     purchases AS (
                    SELECT * 
                    FROM {{ref('int_purchases_by_product')}}
                  ),

    funnel_conversion AS (
                          SELECT e.*
                               , p.quantity
                          FROM events e
                                LEFT JOIN purchases p 
                                USING(user_id, session_id, product_id)
                          )
SELECT *
FROM funnel_conversion