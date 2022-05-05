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