SELECT 
date_date
, paid_source
, campaign_key
, campaign_name
, ads_cost
, impression
, click
FROM {{ref("stg_adwords")}}

UNION ALL

SELECT 
date_date
, paid_source
, campaign_key
, campaign_name
, ads_cost
, impression
, click
FROM {{ref("stg_bing")}}

UNION ALL

SELECT 
date_date
, paid_source
, campaign_key
, campaign_name
, ads_cost
, impression
, click
FROM {{ref("stg_criteo")}}

UNION ALL

SELECT 
date_date
, paid_source
, campaign_key
, campaign_name
, ads_cost
, impression
, click
FROM {{ref("stg_facebook")}}

