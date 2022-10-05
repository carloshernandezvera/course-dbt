{{
    config(
        MATERIALIZED = 'view'
    )
}}

WITH promos_source AS (SELECT PROMO_ID
                            , STATUS
                            , DISCOUNT
                       FROM {{ source('src_greenery', 'promos') }}
                       )
SELECT *
FROM promos_source