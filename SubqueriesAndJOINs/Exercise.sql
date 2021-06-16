USE `soft_uni`;

/* Problem 1
Write a query that selects:
•	employee_id
•	job_title
•	address_id
•	address_text
Return the first 5 rows sorted by address_id in ascending order.
*/

SELECT 
    e.`employee_id`,
    e.`job_title`,
    e.`address_id`,
    a.`address_text`
FROM
    `employees` AS e
        JOIN
    `addresses` AS a ON e.`address_id` = a.`address_id`
ORDER BY a.`address_id`
LIMIT 5;

/* Problem 2
Write a query that selects:
•	first_name
•	last_name
•	town
•	address_text
Sort the result by first_name in ascending order then by last_name. Select first 5 employees.
*/

SELECT 
    e.`first_name`,
    e.`last_name`,
    t.`name` AS `town`,
    a.`address_text`
FROM
    `employees` AS e
        JOIN
    `addresses` AS a ON a.`address_id` = e.`address_id`
        JOIN
    `towns` AS t ON a.`town_id` = t.`town_id`
ORDER BY e.`first_name` ASC , e.`last_name` ASC
LIMIT 5;

/* Problem 3
Write a query that selects:
•	employee_id
•	first_name
•	last_name
•	department_name
Sort the result by employee_id in descending order. Select only employees from the "Sales" department.
*/

SELECT 
    e.`employee_id`, e.`first_name`, e.`last_name`, d.`name`
FROM
    `employees` AS e
        JOIN
    `departments` AS d ON e.`department_id` = d.`department_id`
WHERE
    d.`name` = 'Sales'
ORDER BY `employee_id` DESC;

/* Problem 4
Write a query that selects:
•	employee_id
•	first_name
•	salary
•	department_name
Filter only employees with salary higher than 15000. Return the first 5 rows sorted by department_id in descending order.
*/

SELECT 
    e.`employee_id`, e.`first_name`, e.`salary`, d.`name`
FROM
    `employees` AS e
        JOIN
    `departments` AS d ON e.`department_id` = d.`department_id`
WHERE
    e.`salary` > 15000
ORDER BY d.`department_id` DESC
LIMIT 5;

/* Problem 5 
Write a query that selects:
•	employee_id
•	first_name
Filter only employees without a project. Return the first 3 rows sorted by employee_id in descending order.
*/

SELECT 
    e.`employee_id`, e.`first_name`
FROM
    `employees` AS e
        LEFT JOIN
    `employees_projects` AS ep ON e.`employee_id` = ep.`employee_id`
WHERE
    ep.`project_id` IS NULL
ORDER BY e.`employee_id` DESC
LIMIT 3;

/* Problem 6
Write a query that selects:
•	first_name
•	last_name
•	hire_date
•	dept_name
Filter only employees hired after 1/1/1999 and from either the "Sales" or the "Finance" departments. Sort the result by hire_date (ascending).
*/

SELECT 
    e.`first_name`,
    e.`last_name`,
    e.`hire_date`,
    d.`name` AS 'dept_name'
FROM
    `employees` AS e
        JOIN
    `departments` AS d ON d.`department_id` = e.`department_id`
WHERE
    e.`hire_date` > 1999 - 01 - 01
        AND d.`name` IN ('Sales' , 'Finance')
ORDER BY e.`hire_date` ASC;

/* Problem 7
Write a query that selects:
•	employee_id
•	first_name
•	project_name
Filter only employees with a project, which has started after 13.08.2002 and it is still ongoing (no end date). 
Return the first 5 rows sorted by first_name then by project_name both in ascending order.
*/

SELECT 
    e.`employee_id`, e.`first_name`, p.`name`
FROM
    `employees` AS e
        JOIN
    `employees_projects` AS ep ON ep.`employee_id` = e.`employee_id`
        JOIN
    `projects` AS p ON ep.`project_id` = p.`project_id`
WHERE
    DATE(p.`start_date`) > 2002 - 08 - 13
        AND p.`end_date` IS NULL
ORDER BY e.`first_name` , p.`name` ASC
LIMIT 5;

/* Problem 8
Write a query that selects:
•	employee_id
•	first_name
•	project_name
Filter all the projects of employees with id 24. If the project has started after 2005 inclusively the return value should be NULL. 
Sort the result by project_name alphabetically.
*/

SELECT 
    e.`employee_id`,
    e.`first_name`,
    IF(YEAR(p.start_date) >= 2005,
        NULL,
        p.name) AS `project_name`
FROM
    `employees` AS e
        JOIN
    `employees_projects` AS ep ON ep.`employee_id` = e.`employee_id`
        JOIN
    `projects` AS p ON ep.`project_id` = p.`project_id`
WHERE
    e.`employee_id` = 24
ORDER BY p.`name`;

/* Problem 9
Write a query that selects:
•	employee_id
•	first_name
•	manager_id
•	manager_name
Filter all employees with a manager who has id equal to 3 or 7.
Return all rows sorted by employee first_name in ascending order.
*/

SELECT 
    e.`employee_id`,
    e.`first_name`,
    e.`manager_id`,
    m.`first_name`
FROM
    `employees` AS e
        JOIN
    `employees` AS m ON e.`manager_id` = m.`employee_id`
WHERE
    e.`manager_id` IN (3 , 7)
ORDER BY e.`first_name` ASC;

/* Problem 10
Write a query that selects:
•	employee_id
•	employee_name
•	manager_name		
•	department_name
Show the first 5 employees (only for employees who have a manager) with their managers and the departments they are in 
(show the departments of the employees). Order by employee_id.
*/

SELECT 
    e.`employee_id`,
    CONCAT(e.`first_name`, ' ', e.`last_name`) AS `employee_name`,
    CONCAT(m.`first_name`, ' ', m.`last_name`) AS `manager_name`,
    d.`name`
FROM
    `employees` AS e
        JOIN
    `employees` AS m ON e.`manager_id` = m.`employee_id`
        JOIN
    `departments` AS d ON e.`department_id` = d.`department_id`
ORDER BY e.`employee_id`
LIMIT 5;

/* Problem 11
Write a query that returns the value of the lowest average salary of all departments.
*/

SELECT 
    AVG(`salary`) AS `min_average_salary`
FROM
    `employees`
GROUP BY `department_id`
ORDER BY `min_average_salary`
LIMIT 1;

-- New Database
USE `geography`;

/* Problem 12
Write a query that selects:
•	country_code	
•	mountain_range
•	peak_name
•	elevation
Filter all peaks in Bulgaria with elevation over 2835. Return all rows sorted by elevation in descending order.
*/

SELECT 
    mc.`country_code`,
    m.`mountain_range`,
    p.`peak_name`,
    p.`elevation`
FROM
    `mountains_countries` AS mc
        JOIN
    `mountains` AS m ON mc.`mountain_id` = m.`id`
        JOIN
    `peaks` AS p ON p.`mountain_id` = m.`id`
WHERE
    p.`elevation` > 2835
        AND mc.`country_code` = 'BG'
ORDER BY p.`elevation` DESC;

/* Problem 13
Write a query that selects:
•	country_code
•	mountain_range
Filter the count of the mountain ranges in the United States, Russia and Bulgaria. 
Sort result by mountain_range count in decreasing order.
*/

SELECT 
    mc.`country_code`,
    COUNT(m.`mountain_range`) AS `mountain_range`
FROM
    `mountains_countries` AS mc
        JOIN
    `mountains` AS m ON mc.`mountain_id` = m.`id`
WHERE
    mc.`country_code` IN ('US' , 'RU', 'BG')
GROUP BY mc.`country_code`
ORDER BY COUNT(m.`mountain_range`) DESC;

/* Problem 14
Write a query that selects:
•	country_name
•	river_name
Find the first 5 countries with or without rivers in Africa. Sort them by country_name in ascending order.
*/

SELECT 
    c.`country_name`, r.`river_name`
FROM
    `countries` AS c
        LEFT JOIN
    `countries_rivers` AS cr ON cr.`country_code` = c.`country_code`
        LEFT JOIN
    `rivers` AS r ON r.`id` = cr.`river_id`
        JOIN
    `continents` AS cn ON cn.`continent_code` = c.`continent_code`
WHERE
    cn.`continent_name` = 'Africa'
ORDER BY c.`country_name`
LIMIT 5;

/* Problem 15*
Write a query that selects:
•	continent_code
•	currency_code
•	currency_usage
Find all continents and their most used currency. Filter any currency that is used in only one country. 
Sort the result by continent_code and currency_code.
*/

SELECT 
    c.`continent_code`,
    c.`currency_code`,
    COUNT(*) AS `currency_usage`
FROM
    `countries` AS c
GROUP BY c.`continent_code` , c.`currency_code`
HAVING `currency_usage` > 1
    AND `currency_usage` = (SELECT 
        COUNT(*) AS cn
    FROM
        `countries` AS cc
    WHERE
        cc.`continent_code` = c.`continent_code`
    GROUP BY cc.`currency_code`
    ORDER BY cn DESC
    LIMIT 1)
ORDER BY c.`continent_code`;

/* Problem 16
Find the count of all countries which don't have a mountain.
*/

SELECT 
    COUNT(*) AS 'country_count'
FROM
    (SELECT 
        mc.`country_code` AS 'mc_country_code'
    FROM
        `mountains_countries` AS mc
    GROUP BY mc.`country_code`) AS d
        RIGHT JOIN
    `countries` AS c ON c.`country_code` = d.`mc_country_code`
WHERE
    d.`mc_country_code` IS NULL;
    
    /* Problem 17
    For each country, find the elevation of the highest peak and the length of the longest river, 
    sorted by the highest peak_elevation (from highest to lowest), then by the longest river_length 
    (from longest to smallest), then by country_name (alphabetically). 
    Display NULL when no data is available in some of the columns. Limit only the first 5 rows.
    */
    
   SELECT 
    c.`country_name`,
    MAX(p.`elevation`) AS 'highest_peak_elevation',
    MAX(r.`length`) AS 'longest_river_length'
FROM
    `countries` AS c
        LEFT JOIN
    `mountains_countries` AS mc ON c.`country_code` = mc.`country_code`
        LEFT JOIN
    `peaks` AS p ON mc.`mountain_id` = p.`mountain_id`
        LEFT JOIN
    `countries_rivers` AS cr ON c.`country_code` = cr.`country_code`
        LEFT JOIN
    `rivers` AS r ON cr.`river_id` = r.`id`
GROUP BY c.`country_name`
ORDER BY `highest_peak_elevation` DESC , `longest_river_length` DESC , c.`country_name`
LIMIT 5;