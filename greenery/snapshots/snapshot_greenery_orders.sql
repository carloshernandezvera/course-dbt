{% snapshot snapshot_greenery_orders %}

{{
  config(
    target_database = target.database,
    target_schema = target.schema,
    strategy='check',
    unique_key='order_id',
    check_cols=['status'],
   )
}}

SELECT *
FROM {{ source('src_greenery', 'orders') }}

{% endsnapshot %}