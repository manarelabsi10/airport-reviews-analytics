with trip_verifications as (
    select distinct TRIP_VERIFIED
    from {{ ref('stg_AIRPORT_REVIEW') }}
)

select
    row_number() over (order by TRIP_VERIFIED) as VERIFICATION_id,
    TRIP_VERIFIED
from trip_verifications