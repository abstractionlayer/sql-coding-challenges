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


), rolled_up(id_m, s, is_grouping) AS (
    SELECT id_m, SUM(value), GROUPING(id_m)
    FROM master AS m
    GROUP BY ROLLUP(id_m)

), master_detail AS (
    SELECT r.id_m, r.s, d.grp
    FROM rolled_up AS r
    LEFT OUTER JOIN detail AS d ON r.id_m = d.id_m
    WHERE d.id_m IS NOT NULL OR r.is_grouping = 1
)

SELECT grp, SUM(s) AS s
FROM master_detail
GROUP BY grp
ORDER BY 1;
