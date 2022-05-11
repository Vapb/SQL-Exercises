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


-- Top Competitors
-- Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. Order your output in descending order by the total number of challenges in which the hacker earned a full score. If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.
SELECT Hackers.hacker_id, Hackers.name
FROM Submissions
INNER JOIN Hackers ON Hackers.hacker_id = Submissions.hacker_id
INNER JOIN Challenges ON Challenges.challenge_id = Submissions.challenge_id
INNER JOIN Difficulty ON Difficulty.difficulty_level = Challenges.difficulty_level
WHERE Submissions.score = Difficulty.score
GROUP BY Hackers.hacker_id, Hackers.name
HAVING count(*) > 1
ORDER BY count(*) DESC, Hackers.hacker_id;


-- Ollivander's Inventory
-- Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. If more than one wand has same power, sort the result in order of descending age.
select w.id, p.age, w.coins_needed, w.power
from Wands as w 
join Wands_Property as p on (w.code = p.code) 
where p.is_evil = 0 
and w.coins_needed = (select min(coins_needed)
                      from Wands as w1 
                      join Wands_Property as p1 on (w1.code = p1.code)
                      where w1.power = w.power and p1.age = p.age) 
order by w.power desc, p.age desc;


select w.id, p.age, w.coins_needed,w.power
from wands w
join wands_property p on p.code = w.code
where (p.age,w.power,w.coins_needed) in (select p1.age,w1.power,min(w1.coins_needed)
                                         from wands_property p1
                                         join wands w1 on w1.code = p1.code
                                         where p1.is_evil = 0
                                         group by p1.age, w1.power)
order by w.power desc, p.age desc


-- Contest Leaderboard
-- Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. Exclude all hackers with a total score of from your result.
SELECT temp.id,
       temp.name,
       sum(temp.maxscore) as soma
FROM 
    (SELECT Hackers.hacker_id as id,
            Hackers.name as name,
            Submissions.challenge_id, 
            max(Submissions.score) as maxscore 
    FROM Hackers
    INNER JOIN Submissions ON Submissions.hacker_id = Hackers.hacker_id
    GROUP BY Hackers.hacker_id, Hackers.name, Submissions.challenge_id
    HAVING maxscore > 0) as temp
GROUP BY temp.id, temp.name
ORDER BY soma DESC, temp.id;


-- SQL Project Planning
-- Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. If there is more than one project that have the same number of completion days, then order by the start date of the project.
SELECT A.Start_Date, MIN(B.End_Date)
FROM 
    (SELECT Start_Date FROM Projects WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)) as A,
    (SELECT End_Date FROM Projects WHERE End_Date NOT IN (SELECT Start_Date FROM Projects)) as B
WHERE A.Start_Date < B.End_Date
GROUP BY A.Start_Date
ORDER BY datediff(A.Start_Date, MIN(B.End_Date)) DESC, A.Start_Date;


-- Placements
-- Write a query to output the names of those students whose best friends got offered a higher salary than them. Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer.
SELECT S1.Name
FROM Students S1
INNER JOIN Packages P1 ON P1.ID = S1.ID
INNER JOIN Friends F  ON F.ID = S1.ID
INNER JOIN Students S2  ON S2.ID = F.Friend_ID
INNER JOIN Packages P2 ON P2.ID = S2.ID
WHERE P2.Salary > P1.Salary
ORDER BY P2.Salary;


-- Symmetric Pairs  
-- Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1. 
SELECT f1.X, f1.Y FROM Functions f1
INNER JOIN Functions f2 ON f1.X=f2.Y AND f1.Y=f2.X
GROUP BY f1.X, f1.Y
HAVING COUNT(f1.X)>1 or f1.X<f1.Y
ORDER BY f1.X;


-- Interviews
-- Samantha interviews many candidates from different colleges using coding challenges and contests. Write a query to print the contest_id, hacker_id, name, and the sums of total_submissions, total_accepted_submissions, total_views, and total_unique_views for each contest sorted by contest_id. Exclude the contest from the result if all four sums are .

contest_id
hacker_id
name 
sum total Submissions
total_accepted_submissions
total_views
total_unique_views for each contest 
sorted by contest_id

-exclude contest if all 0



SELECT
FROM Contents C
