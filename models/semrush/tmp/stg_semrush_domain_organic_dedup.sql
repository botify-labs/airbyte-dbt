WITH raw_table AS (
    SELECT
        *
        REPLACE (
            SPLIT(intents) AS intents,
            SPLIT(serp_features_by_keyword) AS serp_features_by_keyword,
            SPLIT(serp_features_by_position) AS serp_features_by_position
        )
    FROM
        {{ source("semrush", "domain_organic") }}
)
SELECT
    *
FROM
    raw_table
QUALIFY
    ROW_NUMBER() OVER (PARTITION BY domain, database, keyword, CAST(position AS integer), timestamp) = 1

