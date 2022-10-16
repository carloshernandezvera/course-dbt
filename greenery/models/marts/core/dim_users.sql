{{
    config(
        MATERIALIZED = 'table'
    )
}}

WITH users AS (SELECT *
               FROM {{ref ('stg_greenery_users')}} 
              )
   , addresses AS (SELECT *
                   FROM  {{ref ('stg_greenery_addresses')}}
                  )

SELECT users.*
     , addresses.country
     , addresses.address
     , addresses.state
     , addresses.zipcode
FROM users
    INNER JOIN addresses
        ON users.address_id = addresses.address_id