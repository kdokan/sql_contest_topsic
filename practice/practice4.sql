WITH summary_age_group_sleephours AS (
        SELECT
            age.AGE_NAME as age_name
            , age.age_code
            , dtl.TIME_CODE as time_code
            , sum(TARGET_POP) as pop
        FROM
            SLEEP_TIME_DTL as dtl
        INNER JOIN
                AGE_GRP as age
            ON
                dtl.AGE_CODE = age.AGE_CODE
        GROUP BY
            dtl.TIME_CODE, dtl.AGE_CODE
)

SELECT
    age_name as 年齢階層
    , SUM(CASE WHEN time_code = 120  THEN pop ELSE 0 END) AS "5時間未満"
    , SUM(CASE WHEN time_code = 130  THEN pop ELSE 0 END) AS "5時間以上6時間未満"
    , SUM(CASE WHEN time_code = 140  THEN pop ELSE 0 END) AS "6時間以上7時間未満"
    , SUM(CASE WHEN time_code = 150  THEN pop ELSE 0 END) AS "7時間以上8時間未満"
    , SUM(CASE WHEN time_code = 160  THEN pop ELSE 0 END) AS "8時間以上9時間未満"
    , SUM(CASE WHEN time_code = 170  THEN pop ELSE 0 END) AS "9時間以上"
    , SUM(CASE WHEN time_code = 180  THEN pop ELSE 0 END) AS 不詳
FROM
    summary_age_group_sleephours
GROUP BY
    age_name
ORDER BY
    age_code 
;