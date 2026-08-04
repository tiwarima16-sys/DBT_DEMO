With BIKE as(

Select
distinct
START_STATIO_ID,
START_STATION_NAME,
START_LAT,
START_LNG


from

{{ source('demo', 'bike') }}



)

select *
from 
BIKE