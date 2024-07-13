SELECT
    d.pf_code as CODE
    , pf_name as "NAME"
    , ROUND(
          (SUM(CASE WHEN CATEGORY_CODE = '120' THEN AMT ELSE 0 END) * 1.0 
            / SUM(CASE WHEN CATEGORY_CODE = '110' THEN AMT ELSE 0 END) * 1.0) * 100, 1
           ) AS "PERCENTAGE"
FROM
    drink_habits as d

INNER JOIN
        prefecture as p
    ON
        d.pf_code = p.pf_code
        
WHERE
    d.GENDER_CODE IN ('2', '3') 

GROUP BY
    d.pf_code

ORDER BY
    PERCENTAGE DESC
    , CODE DESC

;