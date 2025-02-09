SELECT
    DISTRICT_CODE AS CODE
    , DISTRICT_NAME AS "NAME"
    , TOTAL_AMT AS TOTAL
FROM
    POPULATION
WHERE
        TOTAL_AMT >= 100000
    AND DISTRICT_NAME LIKE '%東%'
ORDER BY
    TOTAL DESC
    , DISTRICT_CODE ASC
;