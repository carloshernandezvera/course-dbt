{{
    config(
        MATERIALIZED = 'view'
    )
}}

WITH users_source AS (SELECT USER_ID
                           , CREATED_AT
                           , UPDATED_AT
                           , FIRST_NAME
                           , LAST_NAME
                           , EMAIL
                           , PHONE_NUMBER
                           , ADDRESS_ID
                       FROM {{ source('src_greenery', 'users') }}
                       )
SELECT *
FROM users_source