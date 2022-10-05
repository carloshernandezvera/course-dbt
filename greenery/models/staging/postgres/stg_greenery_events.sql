{{
    config(
        MATERIALIZED = 'view'
    )
}}

WITH events_source AS (SELECT EVENT_ID
                            , CREATED_AT
                            , PRODUCT_ID
                            , USER_ID
                            , SESSION_ID
                            , EVENT_TYPE
                            , ORDER_ID
                            , PAGE_URL
                       FROM {{ source('src_greenery', 'events') }}
                       )
SELECT *
FROM events_source