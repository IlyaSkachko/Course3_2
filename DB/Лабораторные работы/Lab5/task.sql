
-- ¬ычисление итогов запусков помес€чно, за квартал, за полгода, за год

SELECT
  DATEPART(MONTH, TR.DATE_START) AS [Month],
  DATEPART(QUARTER, TR.DATE_START) AS [Quarter],
  CASE
    WHEN DATEPART(MONTH, TR.DATE_START) <= 6 THEN 1
    ELSE 2
  END AS [HalfYear],
  DATEPART(YEAR, TR.DATE_START) AS [Year],
  COUNT(*) OVER (PARTITION BY DATEPART(MONTH, TR.DATE_START), DATEPART(YEAR, TR.DATE_START)) AS [MonthCount],
  COUNT(*) OVER (PARTITION BY DATEPART(QUARTER, TR.DATE_START), DATEPART(YEAR, TR.DATE_START)) AS [QuarterCount],
  COUNT(*) OVER (PARTITION BY CASE WHEN DATEPART(MONTH, TR.DATE_START) <= 6 THEN 1 ELSE 2 END, DATEPART(YEAR, TR.DATE_START)) AS [HalfYearCount],
  COUNT(*) OVER (PARTITION BY DATEPART(YEAR, TR.DATE_START)) AS [YearCount]
FROM TEST_RUNS TR;

select * from TEST_RUNS;

--¬ычисление итогов работы пользователей за определенный период:
--Х	объем выполненных тестов;
--Х	сравнение их с общим объемом выполнени€ тестов (в %);
--Х	сравнение с наилучшим объемом выполнени€ тестов (в %).

SELECT 
    USER_ID,
    COUNT(*) AS TESTS_COMPLETED,
    SUM(COUNT(*)) OVER () AS TOTAL_TESTS,
    CAST(COUNT(*) AS FLOAT) / SUM(COUNT(*)) OVER () * 100 AS PERCENT_OF_TOTAL,
    CAST(COUNT(*) AS FLOAT) / MAX(COUNT(*)) OVER () * 100 AS PERCENT_OF_BEST
FROM 
    TEST_RUNS
WHERE 
    DATE_START >= '2025-01-01' AND DATE_END <= '2029-12-31'
GROUP BY 
    USER_ID


--¬ернуть дл€ каждого user количество выполненых тестов за последние 6 мес€цев помес€чно.


SELECT 
    USER_ID,
    DATEPART(YEAR, DATE_START) AS YEAR,
    DATEPART(MONTH, DATE_START) AS MONTH,
    COUNT(*) OVER (PARTITION BY USER_ID, DATEPART(YEAR, DATE_START), DATEPART(MONTH, DATE_START)) AS TESTS_COMPLETED
FROM 
    TEST_RUNS
WHERE 
	DATE_START <= CAST('2025-06-30' AS DATE)
ORDER BY 
    USER_ID,
    YEAR,
    MONTH


-- акой user выполн€л тестов наибольшее число раз по определенному test_case_id? ¬ернуть дл€ всех test_case_id.

SELECT 
    TEST_CASE_ID,
    USER_ID,
    TESTS_COMPLETED
FROM 
    (SELECT 
        TEST_CASE_ID,
        USER_ID,
        COUNT(*) AS TESTS_COMPLETED,
        ROW_NUMBER() OVER (PARTITION BY TEST_CASE_ID ORDER BY COUNT(*) DESC) AS RN
    FROM 
        TEST_RUNS
    GROUP BY 
        TEST_CASE_ID,
        USER_ID) AS SUBQUERY
WHERE 
    RN = 1



-- ROWNUMBER() дл€ разбиени€ на страницы

SELECT 
    ID, TEST_SUITE_ID, TEST_CASE_ID, DATE_START, DATE_END, RESULT, DEFECT_ID, USER_ID,
    ROW_NUMBER() OVER (ORDER BY ID) AS RowNum,
    (ROW_NUMBER() OVER (ORDER BY ID) - 1) / 5 + 1 AS PageNum
FROM TEST_RUNS;

