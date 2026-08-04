WITH CTE AS (
    Select
        HOUR(TRY_TO_TIMESTAMP(STARTED_AT)) as HOUR_STARTED_AT,
        DAYNAME(TRY_TO_TIMESTAMP(STARTED_AT)) as DAY_STARTED_AT,
        
        CASE
            WHEN DAYNAME(TRY_TO_TIMESTAMP(STARTED_AT)) in ('Sat', 'Sun') THEN 'WEEKEND'
            ELSE 'BUSINESSDAY'
        END as DATETYPE,

        MONTH(TRY_TO_TIMESTAMP(STARTED_AT)) as MONTH_STARTED_AT,

        CASE 
            WHEN MONTH(TRY_TO_TIMESTAMP(STARTED_AT)) in (12,1,2) THEN 'WINTER'
            WHEN MONTH(TRY_TO_TIMESTAMP(STARTED_AT)) in (3,4,5) THEN 'SPRING'
            WHEN MONTH(TRY_TO_TIMESTAMP(STARTED_AT)) in (6,7,8) THEN 'SUMMER'
            ELSE 'AUTUMN'
        END AS STATION_OF_YEAR

    from {{ source('demo', 'bike') }}
)

select
    *
from CTE