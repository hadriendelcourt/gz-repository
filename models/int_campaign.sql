{{ config( 
    materialized='table' 
    ,partition_by={ 
        "field":"number" 
        ,"data_type":"INT64" 
        ,"range": {
            "start": 0,
            "end": 1000,
            "interval": 1
        }
    }
        )}}

WITH union_ads AS (
SELECT * FROM {{ref("stg_adwords")}}
UNION ALL
SELECT * FROM {{ref("stg_bing")}}
UNION ALL
SELECT * FROM {{ref("stg_criteo")}}
UNION ALL
SELECT * FROM {{ref("stg_facebook")}}
)

SELECT 
campaign_name
, paid_source
, SUM(ads_cost) AS campaign_cost
, ROW_NUMBER() OVER(ORDER BY campaign_name) AS number
FROM union_ads
GROUP BY campaign_name, paid_source
