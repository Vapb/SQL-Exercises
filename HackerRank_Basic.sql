-- Select All
-- Query all columns (attributes) for every row in the CITY table.
SELECT *
FROM CITY;


-- Select Query I
/*Query all columns for all American cities in the CITY table with populations larger than 100000. 
The CountryCode for America is USA.*/
SELECT *
FROM CITY
WHERE COUNTRYCODE  = 'USA' 
  AND POPULATION > 100000;


-- Select Query II
/* Query the NAME field for all American cities in the CITY table with populations larger than 120000.
The CountryCode for America is USA. */
SELECT NAME
FROM CITY
WHERE COUNTRYCODE = 'USA'
  AND POPULATION > 120000;


-- Select by ID
-- Query all columns for a city in CITY with the ID 1661.
SELECT *
FROM CITY
WHERE ID = 1661;


-- Japanese Cities Attributes
-- Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN. 
SELECT *
FROM CITY
WHERE COUNTRYCODE = 'JPN';


-- Japanese Cities names
-- Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN. 
SELECT NAME
FROM CITY
WHERE COUNTRYCODE = 'JPN';


-- Weather Observation Station 1
-- Query a list of CITY and STATE from the STATION table. 
SELECT CITY,
       STATE
FROM STATION;


-- Weather Observation Station 3
-- Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer. 
SELECT DISTINCT CITY
FROM STATION
WHERE ID % 2 = 0;


-- Weather Observation Station 4
-- Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table. 
SELECT count(CITY) - count(DISTINCT CITY)
FROM STATION;


--Weather Observation Station 6
-- Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY,1) 
  IN ('a','i','e','o','u');


-- Weather Observation Station 7
-- Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE CITY LIKE '%a' 
  OR CITY LIKE '%e' 
  OR CITY LIKE '%i'
  OR CITY LIKE '%o'
  OR CITY LIKE '%u';

SELECT DISTINCT CITY --MySQL
FROM STATION
WHERE RIGHT(CITY,1) 
  IN ('a','i','e','o','u');

SELECT DISTINCT CITY --Regex
FROM STATION
WHERE CITY REGEXP '[aeiou]$';


-- Weather Observation Station 8
-- Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '^[a,e,i,o,u].*[a,e,i,o,u]$';


-- Weather Observation Station 9
-- Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '^(?![a,e,i,o,u])';


-- Weather Observation Station 10
-- Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE right(city, 1) 
  NOT IN ('a', 'e', 'i', 'o', 'u');

SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '[^aiueo]$';


-- Weather Observation Station 11
-- Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '^[^aeiou]|[^aeiou]$';

SELECT DISTINCT CITY 
FROM STATION
WHERE right(CITY,1) NOT IN ('a','e','i','o','u') 
  OR left(CITY,1) NOT IN ('a','e','i','o','u');


-- Weather Observation Station 12
-- Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY 
FROM STATION
WHERE CITY REGEXP '^[^aeiou].*[^aeiou]$';


-- Higher Than 75 Marks
-- Query the Name of any student in STUDENTS who scored higher than Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
SELECT Name
FROM STUDENTS
WHERE Marks > 75
ORDER BY right(Name,3), ID ASC;


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


-- Weather Observation Station 11
-- Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates
SELECT DISTINCT CITY 
FROM STATION
WHERE CITY REGEXP '^[^aeiou]|[^aeiou]$';


--
--
SELECT name
FROM Employee
ORDER BY name ASC;


-- Employee Salaries
-- Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than per month who have been employees for less than months. Sort your result by ascending employee_id.
SELECT name
FROM Employee
WHERE salary > 2000
AND months < 10
ORDER BY employee_id ASC;


-- Type of Triangle
-- Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:
SELECT 
    CASE
        WHEN (A >= (B + C)) OR (B >= (A + C)) OR (C >= (A + B)) THEN 'Not A Triangle'
        WHEN (A = B AND B = C) THEN 'Equilateral'
        WHEN (A = B AND B != C) OR (B = C AND A != C) OR (A = C AND B != C) THEN 'Isosceles'
        ELSE 'Scalene'
    END
FROM TRIANGLES;


-- Revising Aggregations - The Count Function
-- Query a count of the number of cities in CITY having a Population larger than . 
SELECT count(*)
FROM CITY
WHERE POPULATION > 100000;


-- Average Population
-- Query the average population for all cities in CITY, rounded down to the nearest integer.
SELECT ROUND(AVG(POPULATION))
FROM CITY;


-- Population Census 
-- Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.
SELECT sum(CITY.POPULATION)
FROM CITY
INNER JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE
WHERE COUNTRY.CONTINENT = 'Asia';


-- Revising Aggregations - The Sum Function
-- Query the total population of all cities in CITY where District is California. 
SELECT sum(POPULATION)
FROM CITY
WHERE DISTRICT = 'California' ;


-- Japan Population
-- Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.
SELECT sum(POPULATION)
FROM CITY
WHERE COUNTRYCODE = 'JPN';


-- Population Density Difference
-- Query the difference between the maximum and minimum populations in CITY.
SELECT max(POPULATION) - min(POPULATION)
FROM CITY;


-- The Blunder
-- Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's key was broken until after completing the calculation. She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.
SELECT CEILING(avg(SALARY) - avg(replace(SALARY,0,'')))
FROM EMPLOYEES;


-- Top Earners
-- We define an employee's total earnings to be their monthly worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as space-separated integers.
SELECT (salary * months), count(*)
FROM EMPLOYEE
WHERE (salary * months) = (SELECT MAX(salary * months) FROM EMPLOYEE)
GROUP BY (salary * months);

SELECT (salary * months), count(*)
FROM EMPLOYEE 
GROUP BY 1 
ORDER BY earnings desc
LIMIT 1;


-- Weather Observation Station 2
--The sum of all values in LAT_N rounded to a scale of decimal places.
-- The sum of all values in LONG_W rounded to a scale of decimal places.
SELECT round(sum(LAT_N),2), round(sum(LONG_W),2) 
FROM STATION;


-- Weather Observation Station 13
-- Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than and less than . Truncate your answer to decimal places
SELECT round(sum(LAT_N),4)
FROM STATION
WHERE LAT_N > 38.7880 AND LAT_N < 137.2345;


-- Weather Observation Station 14
-- Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than . Truncate your answer to decimal places.
SELECT round(max(LAT_N), 4) 
FROM STATION
WHERE LAT_N < 137.2345;


-- Weather Observation Station 15
-- Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than . Round your answer to decimal places.
SELECT round(LONG_W, 4)
FROM STATION
WHERE LAT_N < 137.2345
ORDER BY LAT_N DESC
LIMIT 1;

SELECT round(LONG_W, 4)
FROM STATION 
WHERE LAT_N = (SELECT MAX(LAT_N) FROM STATION WHERE LAT_N < LAT_N < 137.2345);


-- Weather Observation Station 16
-- Query the smallest Northern Latitude (LAT_N) from STATION that is greater than . Round your answer to decimal places.
SELECT round(MIN(LAT_N), 4) 
FROM STATION
WHERE LAT_N > 38.7780;


-- Weather Observation Station 17
-- Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than . Round your answer to decimal places.
SELECT round(LONG_W, 4)
FROM STATION 
WHERE LAT_N = (SELECT min(LAT_N) FROM STATION WHERE LAT_N > 38.7780);


-- African Cities (Basic Join)
-- Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'. 
SELECT CITY.NAME
FROM CITY
    INNER JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE
WHERE COUNTRY.CONTINENT = 'Africa';
