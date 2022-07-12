{{
  config(
    materialized = "table",
    cluster_by = "keyword",
  )
}}

WITH only_latest_record_per_keyword AS (
    SELECT
        *
    FROM
        {{ ref('stg_semrush_domain_organic_dedup') }}
    QUALIFY
        RANK() OVER (PARTITION BY domain, database, keyword ORDER BY timestamp DESC) = 1
)
SELECT
    *
FROM
    only_latest_record_per_keyword
WHERE
    lost = false