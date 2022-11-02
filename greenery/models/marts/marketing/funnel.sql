
{{ config(materialized='table') }}

WITH sessions AS (
                  SELECT * 
                  FROM {{ref('int_sessions_funnel')}}
                 ),

     orders AS (
                SELECT * 
                FROM {{ref('int_orders_funnel')}}
               ),

     products AS (
                    SELECT *
                    FROM {{ref('stg_greenery_products')}}
                 ),

    funnel AS (
                SELECT name
                     , product_id
                     , SUM(top_of_funnel)       AS top_of_funnel
                     , SUM(middle_of_funnel)    AS middle_of_funnel
                     , SUM(CASE WHEN quantity IS NOT NULL THEN 1 END) AS bottom_of_funnel
                FROM sessions
                    LEFT JOIN orders
                        USING(session_id, product_id)
                    LEFT JOIN products
                        USING (product_id)
                WHERE product_id IS NOT NULL
                GROUP BY name, product_id
              )
SELECT *
FROM funnel

