-- Task 2.
-- Таблица содержит информацию о пoльзовательских сессиях. Написать запрос,
-- который вернет максимальное число одновременных подключений для каждого
-- пользователя и минимальное время, когда это произошло.

WITH log(username, logon_time, logoff_time) AS (
    SELECT 'U1', timestamp '2013-08-08  1:00:00'
               , timestamp '2013-08-08 10:00:00' UNION ALL
    SELECT 'U1', '2013-08-08  6:00:00', '2013-08-08 14:00:00' UNION ALL
    SELECT 'U1', '2013-08-08  4:00:00', '2013-08-08 12:00:00' UNION ALL
    SELECT 'U1', '2013-08-08  8:00:00', '2013-08-08 17:00:00' UNION ALL
    SELECT 'U1', '2013-08-08 16:00:00', '2013-08-08 18:00:00' UNION ALL
    SELECT 'U1', '2013-08-08  9:00:00', '2013-08-08 16:00:00' UNION ALL
    SELECT 'U2', '2013-08-08  1:00:00', '2013-08-08  3:00:00' UNION ALL
    SELECT 'U2', '2013-08-08  2:00:00', '2013-08-08 12:00:00' UNION ALL
    SELECT 'U2', '2013-08-08 11:00:00', '2013-08-08 13:00:00' UNION ALL
    SELECT 'U2', '2013-08-08 10:00:00', '2013-08-08 14:00:00'

), intersect_counts AS (
    SELECT l.username
         , COUNT(*) AS qty
         , l.logon_time
    FROM log AS l
    INNER JOIN log AS l2 ON l.username = l2.username
        AND l.logon_time BETWEEN l2.logon_time AND l2.logoff_time
    GROUP BY l.username, l.logon_time

), ordered AS (
    SELECT username, qty, logon_time
         , ROW_NUMBER() OVER (
               PARTITION BY username
               ORDER BY qty DESC
           ) AS rn
    FROM intersect_counts
)

SELECT username, qty, logon_time
FROM ordered
WHERE rn = 1;
