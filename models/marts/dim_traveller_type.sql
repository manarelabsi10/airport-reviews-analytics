with traveller_types as (
    select distinct coalesce(TYPE_OF_TRAVELLER, 'Unknown') as TYPE_OF_TRAVELLER
    from {{ ref('stg_AIRPORT_REVIEW') }}
)

select
    row_number() over (order by TYPE_OF_TRAVELLER) as TRAVELLER_TYPE_id,
    TYPE_OF_TRAVELLER
from traveller_types