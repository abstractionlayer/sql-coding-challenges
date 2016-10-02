-- Task 1.
-- Таблица содержит ребра направленного графа. Написать запрос, возвращающий
-- все узлы, связанные с заданным.

WITH RECURSIVE graph(id, parent_id) AS (
    SELECT  1,  2 UNION ALL
    SELECT  1,  3 UNION ALL
    SELECT  4,  3 UNION ALL
    SELECT  5,  4 UNION ALL
    SELECT  6,  5 UNION ALL
    SELECT  7,  6 UNION ALL
    SELECT  8,  7 UNION ALL
    SELECT  7,  8 UNION ALL
    SELECT  8, 10 UNION ALL
    SELECT  9,  9 UNION ALL
    SELECT 12, 11

), all_possible_edges(id1, id2) AS (
    SELECT id, parent_id
    FROM graph
    UNION
    SELECT parent_id, id
    FROM graph

), starting_edges AS (
    SELECT id1, id2
    FROM all_possible_edges
    WHERE id1 = 1

), pass_through_edges AS (
    SELECT id1, id2
    FROM starting_edges
    UNION
    SELECT e2.id1, e2.id2
    FROM pass_through_edges AS e1
    INNER JOIN all_possible_edges AS e2 ON e1.id2 = e2.id1
)

SELECT id1
FROM pass_through_edges
GROUP BY id1
ORDER BY 1;
