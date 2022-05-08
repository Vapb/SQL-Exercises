-- Weather Observation Station 5
-- Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically. 
SELECT city, length(city)
FROM station
ORDER BY length(city),city ASC
LIMIT 1;

SELECT city, length(city)
FROM station
ORDER BY length(city) DESC
LIMIT 1;


-- Weather Observation Station 20
-- A median is defined as a number separating the higher half of a data set from the lower half. Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to decimal places. 
-- https://www.youtube.com/watch?v=OXQw9jPvnhw
SET @rowindex := -1; /* 1) creates an index*/ 
/* 3) the outer query will select the average of the 2(for odd no. of values)/1(for even) values we found in the middle of the sorted array */
SELECT round(avg(lat_n),4)
FROM
/* 2) the index will increment for each new value of lat_n it finds, and sort them by lat_n
*/
    (SELECT @rowindex := @rowindex + 1 AS rowindex, lat_n 
    FROM station
    ORDER BY lat_n) AS l 
WHERE l.rowindex IN (floor(@rowindex/2), ceil(@rowindex/2));


-- Binary Tree Nodes
-- You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.
SELECT N,
    case
        when P IS NULL then 'Root'
        when (N IN (select P from BST where P IS NOT NULL)) then 'Inner'
        else 'Leaf'
    end
FROM BST
ORDER BY N;


-- Challenges
-- Julia asked her students to create some coding challenges. Write a query to print the hacker_id, name, and the total number of challenges created by each student. Sort your results by the total number of challenges in descending order. If more than one student created the same number of challenges, then sort the result by hacker_id. If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.
SELECT c.hacker_id as id, h.name as name, count(c.hacker_id) as counter
FROM Hackers h
JOIN Challenges c on c.hacker_id = h.hacker_id
GROUP BY c.hacker_id, h.name
-- Discover Max count
HAVING counter = ( 
    SELECT MAX(temp.cnt)
    FROM(SELECT count(hacker_id) as cnt
        FROM Challenges 
        GROUP BY hacker_id)
    as temp)

-- Discover count with only 1
    OR counter IN ( 
    SELECT tmp.cnt
    FROM (SELECT hacker_id, count(hacker_id) as cnt
                FROM Challenges 
                GROUP BY hacker_id) as tmp
    GROUP BY tmp.cnt
    HAVING count(*) = 1)
ORDER BY counter DESC, id;


-- New Companies
-- Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.
SELECT C.company_code, 
       C.founder,
       COUNT(DISTINCT(L.lead_manager_code)),
       COUNT(DISTINCT(S.senior_manager_code)),
       COUNT(DISTINCT(M.manager_code)),
       COUNT(DISTINCT(E.employee_code))
FROM Company as C
INNER JOIN Lead_Manager as L ON C.company_code =  L.company_code
INNER JOIN Senior_Manager as S ON C.company_code =  S.company_code
INNER JOIN Manager as M ON C.company_code =  M.company_code
INNER JOIN Employee as E ON C.company_code =  E.company_code
GROUP BY C.company_code, C.founder
ORDER BY C.company_code;


-- The Report
-- Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.
SELECT 
    CASE
        WHEN G.Grade < 8 THEN 'NULL'
        ELSE S.Name
    END,
       G.Grade,
       S.Marks
FROM STUDENTS AS S
INNER JOIN GRADES AS G ON S.Marks BETWEEN G.Min_Mark AND G.Max_Mark
ORDER BY G.Grade DESC, S.Name ASC;
