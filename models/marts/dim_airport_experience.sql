with airport_experiences as (
    select distinct coalesce(EXPERIENCE_AT_AIRPORT, 'Unknown') as EXPERIENCE_AT_AIRPORT
    from {{ ref('stg_AIRPORT_REVIEW') }}
)

select
    row_number() over (order by EXPERIENCE_AT_AIRPORT) as EXPERIENCE_id,
    EXPERIENCE_AT_AIRPORT
from airport_experiences