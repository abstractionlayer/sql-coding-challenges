-- Task 3.
-- Написать запрос, генерирующий первые n чисел Фибоначчи. Использование любых
-- формул не допускается. Число для генерации должно быть указано в
-- связываемой переменной.

WITH RECURSIVE fib(lvl, current, next) AS (
    SELECT 1, 0, 1
    UNION ALL
    SELECT lvl + 1, next, current + next
    FROM fib AS f
    WHERE lvl < 10
)

SELECT lvl, current
FROM fib;
