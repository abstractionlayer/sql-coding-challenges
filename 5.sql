-- Task 5
-- Таблица содержит узлы для нескольких деревьев. Написать запрос, который
-- вернет узлы с признаком signed, а также их родителей на первых трех
-- уровнях. Connect by может быть использовано только однократно.

WITH RECURSIVE tree(id, parent_id, sign) AS (
    SELECT  3,    1, 0 UNION ALL
    SELECT  4,    2, 0 UNION ALL
    SELECT  5,    2, 0 UNION ALL
    SELECT  6,    3, 0 UNION ALL
    SELECT  7,    3, 0 UNION ALL
    SELECT  8,    3, 0 UNION ALL
    SELECT  9,    4, 0 UNION ALL
    SELECT 10,    4, 1 UNION ALL
    SELECT 11,    7, 1 UNION ALL
    SELECT 12,    7, 0 UNION ALL
    SELECT 13,    9, 0 UNION ALL
    SELECT 14,    9, 1 UNION ALL
    SELECT 15,    9, 1 UNION ALL
    SELECT  2, NULL, 0 UNION ALL
    SELECT  1, NULL, 0

), start AS (
    SELECT t1.id        AS node
         , t1.id        AS p1
         , t1.parent_id AS p2
         , t2.parent_id AS p3
         , 0            AS lvlup
    FROM tree AS t1
    INNER JOIN tree AS t2 ON t1.parent_id = t2.id
    WHERE t1.sign = 1

), bypass_up AS (
    SELECT node, p1, p2, p3, lvlup
    FROM start
    UNION ALL
    SELECT node, p2, p3, t.parent_id, b.lvlup + 1
    FROM bypass_up AS b
    INNER JOIN tree AS t ON b.p3 = t.id

), without_null AS (
    SELECT node, p3, p2, p1, lvlup
    FROM bypass_up
    WHERE p3 IS NOT NULL

), only_top_lvl AS (
    SELECT node, p3, p2, p1, lvlup
         , ROW_NUMBER() OVER (
               PARTITION BY node
               ORDER BY lvlup DESC
           ) AS rn
    FROM without_null
)

SELECT node, p3 AS idlvl1, p2 AS idlvl2, p1 AS idlvl3
FROM only_top_lvl
WHERE rn = 1;