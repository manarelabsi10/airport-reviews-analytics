with reviews as (
    select * from {{ ref('stg_AIRPORT_REVIEW') }}
)

select
    -- a number for every review
    row_number() over (order by reviews.REVIEW_DATE) as REVIEW_id,

    -- the keys that point to the dimension tables
    airports.AIRPORT_id,
    traveller_types.TRAVELLER_TYPE_id,
    airport_experiences.EXPERIENCE_id,
    trip_verifications.VERIFICATION_id,

    -- dates and text
    reviews.REVIEW_DATE,
    reviews.DATE_VISIT,
    reviews.REVIEW_TITLE,
    reviews.REVIEW_CONTENT,

    -- ratings
    reviews.QUEUING_TIMES,
    reviews.TERMINAL_CLEANLINESS,
    reviews.TERMINAL_SEATING,
    reviews.TERMINAL_SIGNS,
    reviews.FOOD_BEVERAGES,
    reviews.AIRPORT_SHOPPING,
    reviews.WIFI_CONNECTIVITY,
    reviews.AIRPORT_STAFF,

    -- did the person recommend the airport?
    reviews.RECOMMENDED

from reviews

-- find the airport number
left join {{ ref('dim_airports') }} as airports
    on reviews.AIRPORT_NAME = airports.AIRPORT_NAME

-- find the traveller type number ("Unknown" when it is empty)
left join {{ ref('dim_traveller_type') }} as traveller_types
    on coalesce(reviews.TYPE_OF_TRAVELLER, 'Unknown') = traveller_types.TYPE_OF_TRAVELLER

-- find the experience number ("Unknown" when it is empty)
left join {{ ref('dim_airport_experience') }} as airport_experiences
    on coalesce(reviews.EXPERIENCE_AT_AIRPORT, 'Unknown') = airport_experiences.EXPERIENCE_AT_AIRPORT

-- find the verification number
left join {{ ref('dim_trip_verification') }} as trip_verifications
    on reviews.TRIP_VERIFIED = trip_verifications.TRIP_VERIFIED