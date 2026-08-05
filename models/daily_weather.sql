WITH daily_weather_raw AS (
    Select
        date(time) as daily_weather,
        weather,
        temp,
        pressure,
        humidity,
        clouds
        
    from {{ source('demo', 'weather') }}
    
)

, daily_weather_agg as (
    select 
        daily_weather,
        weather,
        ROUND(avg(temp), 2) as avg_temp,
        ROUND(avg(pressure), 2) as avg_pressure,
        ROUND(avg(humidity), 2) as avg_humidity,
        ROUND(avg(clouds), 2) as avg_cloud,
        
        row_number() over (partition by daily_weather order by count(weather) desc) as row_number
    from daily_weather_raw
    group by daily_weather, weather
    qualify row_number = 1
)

select * 
from daily_weather_agg
