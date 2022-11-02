{{ config(materialized='table') }}

WITH stg_greenery_events AS (
                             SELECT * 
                             FROM {{ref('stg_greenery_events')}}
                            ),

     sessions_funnel  AS (
                          SELECT sge.session_id
                               , sge.product_id
                               , MAX(CASE
                                        WHEN event_type = 'page_view'
                                            THEN 1
                                     END) AS top_of_funnel
                               , MAX(CASE
                                        WHEN event_type = 'add_to_cart'
                                            THEN 1
                                     END) AS middle_of_funnel
                          FROM stg_greenery_events sge
                          GROUP BY session_id, product_id
                          ORDER BY session_id, product_id
                         )
                          
SELECT *
FROM sessions_funnel