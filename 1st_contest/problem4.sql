WITH ranked_population as (
        SELECT
            PF_CODE
            , NATION_CODE
            , AMT
            , ROW_NUMBER() OVER(PARTITION BY PF_CODE ORDER BY AMT DESC) as rank
        FROM
            FOREIGNER
)

SELECT
    PF_CODE
    , MAX(CASE WHEN rank = 1 THEN NATION_CODE END) AS NATION_CODE_1
    , MAX(CASE WHEN rank = 1 THEN AMT END) AS AMT_1
    , MAX(CASE WHEN rank = 2 THEN NATION_CODE END) AS NATION_CODE_2
    , MAX(CASE WHEN rank = 2 THEN AMT END) AS AMT_2
    , MAX(CASE WHEN rank = 3 THEN NATION_CODE END) AS NATION_CODE_3
    , MAX(CASE WHEN rank = 3 THEN AMT END) AS AMT_3

FROM
    ranked_population
WHERE
    rank <= 3
GROUP BY
    PF_CODE
;