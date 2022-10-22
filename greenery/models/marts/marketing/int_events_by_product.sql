{{ config(materialized='table') }}

WITH events AS (
                SELECT * 
                FROM {{ref('stg_greenery_events')}}
                ),

     events_by_product AS (SELECT DATE (created_at) AS session_date
                                , user_id
                                , session_id
                                , product_id
                                , MAX (CASE WHEN event_type = 'page_view' THEN 1 END) AS product_viewed
                                , MAX (CASE WHEN event_type = 'add_to_cart' THEN 1 END) AS product_selected
                FROM events
                WHERE event_type IN ('page_view', 'add_to_cart')
                {{ dbt_utils.group_by(n=4) }} )
SELECT *
FROM events_by_product





