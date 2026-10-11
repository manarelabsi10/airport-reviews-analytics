with airports as (
    select distinct AIRPORT_NAME
    from {{ ref('stg_AIRPORT_REVIEW') }}
)

select
    row_number() over (order by AIRPORT_NAME) as AIRPORT_id,
    AIRPORT_NAME
from airports