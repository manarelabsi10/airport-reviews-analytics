
with data_cleaned as (
    SELECT
        -- clean title column from Quotation marks and rename it to REVIEW_TITLE
        trim(regexp_replace(TITLE, '["“”-]', ' ')) as REVIEW_TITLE,
        
        -- convert the REVIEW_DATE column to date format and rename it to REVIEW_DATE
        to_date(left(split_part(DATE, ' ', 1), length(split_part(DATE, ' ', 1)) - 2)
                || ' ' || split_part(DATE, ' ', 2)
                || ' ' || split_part(DATE, ' ', 3), 'DD MMMM YYYY' ) as REVIEW_DATE,


        -- normalize whitespace, remove leading symbols and verification prefixes
        trim(
            regexp_replace(
                ltrim(regexp_replace(CONTENT, '\\s+', ' '), '❎❌✅ '),
                '^(Trip Verified|Not Verified)\\s*\\|\\s*',
                '', 1, 1, 'i'
            )
        ) as REVIEW_CONTENT,

        TRIP_VERIFIED,

        -- convert the N/A values to NULL and rename it to OVERALL_EXPERIENCE_AT_AIRPORT
        iff(EXPERIENCE_AT_AIRPORT = 'N/A', null, EXPERIENCE_AT_AIRPORT) as EXPERIENCE_AT_AIRPORT,

        -- convert the N/A values to NULL and rename it to DATE_VISIT
        iff(DATE_VISIT = 'N/A', null, DATE_VISIT) as DATE_VISIT,
        
        -- convert the N/A values to NULL and rename it to TYPE_OF_TRAVELLER
        iff(TYPE_OF_TRAVELLER = 'N/A', null, TYPE_OF_TRAVELLER) as TYPE_OF_TRAVELLER,

        -- convert the type from string to integer , na values to NULL and rename it to QUEUING_TIMES
        iff(QUEUING_TIMES = 'NA', null, cast(QUEUING_TIMES as integer)) as QUEUING_TIMES,

        --convert the type from string to integer , na values to NULL and rename it to TERMINAL_CLEANLINESS
        iff(TERMINAL_CLEANLINESS = 'NA', null, cast(TERMINAL_CLEANLINESS as integer)) as TERMINAL_CLEANLINESS,

        --convert the type from string to integer , na values to NULL and rename it to TERMINAL_SEATING
        iff(TERMINAL_SEATING = 'NA', null, cast(TERMINAL_SEATING as integer)) as TERMINAL_SEATING,
    
        --convert the type from string to integer , na values to NULL and rename it to TERMINAL_SIGNS
        iff(TERMINAL_SIGNS = 'NA', null, cast(TERMINAL_SIGNS as integer)) as TERMINAL_SIGNS,

        --convert the type from string to integer , na values to NULL and rename it to FOOD_BEVERAGES
        iff(FOOD_BEVERAGES = 'NA', null, cast(FOOD_BEVERAGES as integer)) as FOOD_BEVERAGES,

        --convert the type from string to integer , na values to NULL and rename it to AIRPORT_SHOPPING
        iff(AIRPORT_SHOPPING = 'NA', null, cast(AIRPORT_SHOPPING as integer)) as AIRPORT_SHOPPING,

        --convert the type from string to integer , na values to NULL and rename it to WIFI_CONNECTIVITY
        iff(WIFI_CONNECTIVITY = 'NA', null, cast(WIFI_CONNECTIVITY as integer)) as WIFI_CONNECTIVITY,

        --convert the type from string to integer , na values to NULL and rename it to AIRPORT_STAFF
        iff(AIRPORT_STAFF = 'NA', null, cast(AIRPORT_STAFF as integer)) as AIRPORT_STAFF,

        RECOMMENDED,
        trim(regexp_replace(AIRPORT_NAME, '\\s+', ' ')) as AIRPORT_NAME
    FROM {{ source('raw_data', 'AIRPORT_REVIEW') }} 
)

-- remove duplicate raw
select distinct * from data_cleaned
