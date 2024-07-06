SELECT
    PO.PF_CODE AS 都道府県コード
    , PF.PF_NAME AS 都道府県名
    , PO.TOTAL_AMT AS 総人口2015年
    , PO2020.TOTAL_AMT AS 総人口2020年
    , ROUND( 
        -- 計算項目がINTEGER型なのでCAST関数でREAL型に変換して計算しています
        CAST(PO2020.TOTAL_AMT AS REAL) / CAST(PO.TOTAL_AMT AS REAL) * 100
    )  AS 人口増加率 
FROM
    -- メインのクエリで、人口推移テーブルから2015年のデータを取得しています
    POPU_TRANSITION AS PO 
    INNER JOIN PREFECTURE AS PF 
        ON PF.PF_CODE = PO.PF_CODE 
    -- 内部結合で同一テーブルの人口推移テーブルから、2020年のデータを取得しています
    INNER JOIN POPU_TRANSITION AS PO2020 
        ON PO2020.PF_CODE = PO.PF_CODE 
        AND PO2020.SURVEY_YEAR = 2020 
WHERE
    PO.SURVEY_YEAR = 2015 
    AND  PO2020.TOTAL_AMT >= PO.TOTAL_AMT
ORDER BY
    人口増加率 DESC
    , 都道府県コード ASC;