WITH CTE AS (
    Select
        HOUR(TRY_TO_TIMESTAMP(STARTED_AT)) as HOUR_STARTED_AT,
        DAYNAME(TRY_TO_TIMESTAMP(STARTED_AT)) as DAY_STARTED_AT,
        
         {{get_datetype('STARTED_AT')}} as DATETYPE,

        MONTH(TRY_TO_TIMESTAMP(STARTED_AT)) as MONTH_STARTED_AT,

        {{get_season('STARTED_AT')}} AS STATION_OF_YEAR


    from {{ ref('stg_bike') }}
)

select
    *
from CTE