-- Draw The Triangle 1
-- Write a query to print the pattern P(20).
SET @number = 21;
SELECT REPEAT('* ', @number := @number - 1)
FROM information_schema.tables
LIMIT 20;


-- Draw The Triangle 2
-- Write a query to print the pattern P(20).
SET @number = 0;
SELECT REPEAT('* ', @number := @number + 1)
FROM information_schema.tables
LIMIT 20;

