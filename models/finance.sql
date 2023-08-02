{{config(schema='finance')}}

WITH campaigns AS (SELECT * FROM {{ref('int_campaign')}})
    , orders AS (SELECT * FROM {{ref("orders")}})

, date_orders AS(
    SELECT
    date_date
    , ROUND(SUM(turnover),2) AS turnover
    , ROUND(SUM(product_margin),2) AS product_margin
    , ROUND(SUM(shipping_fee),2) AS shipping_fee
    , ROUND(SUM(log_cost),2) AS log_cost
    , ROUND(SUM(ship_cost),2) AS ship_cost
    , ROUND(SUM(operational_margin),2) AS operational_margin
    FROM orders
    GROUP BY date_date
)

, date_campaign AS(
    SELECT
    date_date
    , SUM(ads_cost_total) AS ads_cost
    , SUM(click_total) AS click
    , SUM(impression_total) AS impression
    FROM campaigns
    GROUP BY date_date
)
, date_join AS(
    SELECT
    date_date
    --ORDERS--
    , turnover
    , product_margin
    , shipping_fee
    , log_cost
    , ship_cost
    , operational_margin
    --CAMPAIGN--
    , ads_cost
    , click
    , impression
    FROM date_orders
    LEFT JOIN date_campaign USING (date_date)
)
SELECT
*
, operational_margin - ads_cost AS ads_margin
FROM date_join