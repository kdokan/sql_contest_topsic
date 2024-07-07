SELECT
    st.AGE_CODE as '年齢コード'
    , AGE_NAME as '年齢階層名'
    , sum(SP_TIME_5) as '5時間未満'
    , sum(SP_TIME_6) as '5時間以上6時間未満'
    , sum(SP_TIME_7) as '6時間以上7時間未満'
    , sum(SP_TIME_8) as '7時間以上8時間未満'
    , sum(SP_TIME_9) as '8時間以上9時間未満'
    , sum(SP_TIME_9OVER) as '9時間以上'
FROM
    SLEEP_TIME_DTL as st
INNER JOIN
        AGE_GRP as a
    ON
        st.AGE_CODE = a.AGE_CODE
WHERE
    PF_CODE = '01000'
    OR PF_CODE = '02000' 
    OR PF_CODE = '03000' 
    OR PF_CODE = '04000' 
    OR PF_CODE = '07000' 
GROUP BY
    st.AGE_CODE
ORDER BY
    st.AGE_CODE ASC