{{
    config(
        MATERIALIZED = 'view'
    )
}}

WITH addresses_source AS (SELECT ADDRESS_ID
                           , COUNTRY
                           , STATE
                           , ADDRESS
                           , ZIPCODE
                       FROM {{ source('src_greenery', 'addresses') }}
                       )
SELECT *
FROM addresses_source