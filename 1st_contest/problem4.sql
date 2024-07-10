WITH ranked_population as (
        SELECT
            PF_CODE
            , NATION_CODE
            , AMT
            , ROW_NUMBER() OVER(PARTITION BY PF_CODE ORDER BY AMT DESC) as rank
        FROM
            FOREIGNER
        WHERE
            NATION_CODE <> '113'
            
)

SELECT
    p.PF_CODE as "都道府県コード"
    , p.PF_NAME as "都道府県名"
    , MAX(CASE WHEN rank = 1 THEN n.NATION_NAME END) AS "1位 国名"
    , MAX(CASE WHEN rank = 1 THEN AMT END) AS "1位 人数"
    , MAX(CASE WHEN rank = 2 THEN n.NATION_NAME END) AS "2位 国名"
    , MAX(CASE WHEN rank = 2 THEN AMT END) AS "2位 人数"
    , MAX(CASE WHEN rank = 3 THEN n.NATION_NAME END) AS "3位 国名"
    , MAX(CASE WHEN rank = 3 THEN AMT END) AS "3位 人数"
    , SUM(AMT) as "合計人数"

FROM
    ranked_population as r
LEFT JOIN
        NATIONALITY as n
    ON
        r.NATION_CODE = n.NATION_CODE
LEFT JOIN
        PREFECTURE as p
    ON
        r.PF_CODE = p.PF_CODE
GROUP BY
    p.PF_CODE
ORDER BY
    合計人数 DESC
    , 都道府県コード ASC
;