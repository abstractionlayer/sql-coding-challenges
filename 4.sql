-- Task 4.
-- Для данных таблиц master и detail tables написать запрос, который вернет
-- сумму value с группировкой по grp, а также общую сумму в первой строке.
-- Допускается только одно сканирование таблицы master.

WITH master(id_m, value) AS (
    SELECT 1, 111 UNION ALL
    SELECT 2, 222 UNION ALL
    SELECT 3, 333 UNION ALL
    SELECT 4, 444 UNION ALL
    SELECT 5, 555 UNION ALL
    SELECT 6, 666

), detail(id_m, grp) AS (
    SELECT 1, 1 UNION ALL
    SELECT 1, 2 UNION ALL
    SELECT 1, 4 UNION ALL
    SELECT 2, 3 UNION ALL
    SELECT 2, 4 UNION ALL
    SELECT 3, 1 UNION ALL
    SELECT 3, 3 UNION ALL
    SELECT 3, 5
)

SELECT grp, sum(value) AS s
FROM master AS m
INNER JOIN detail AS d ON m.id_m = d.id_m
GROUP BY ROLLUP (grp)
ORDER BY grp;
