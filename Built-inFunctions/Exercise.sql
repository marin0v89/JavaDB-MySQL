USE `soft_uni`;

/* Problem 1
Write a SQL query to find first and last names of all employees whose first name starts with "Sa" (case insensitively).
Order the information by id. Submit your query statements as Prepare DB & run queries.
*/

SELECT `first_name`, `last_name` FROM `employees`
WHERE SUBSTR(`first_name`,1 ,2) = 'sa';

/* Problem 2
Write a SQL query to find first and last names of all employees whose last name contains "ei" (case insensitively).
Order the information by id. Submit your query statements as Prepare DB & run queries.
*/

SELECT `first_name`, `last_name` FROM `employees`
WHERE `last_name` LIKE '%ei%';

/* Problem 3
Write a SQL query to find the first names of all employees in the departments with ID 3 or 10 and whose hire year is 
between 1995 and 2005 inclusively. Order the information by id. Submit your query statements as Prepare DB & run queries.
*/

SELECT `first_name` FROM `employees`
WHERE `department_id` IN (3, 10) AND YEAR(`hire_date`) BETWEEN 1995 AND 2005
ORDER BY `employee_id`;

/* Problem 4
Write a SQL query to find the first and last names of all employees whose job titles does not contain "engineer". 
Order the information by id. Submit your query statements as Prepare DB & run queries.
*/

SELECT `first_name`, `last_name` FROM `employees`
WHERE `job_title` NOT LIKE '%engineer%';

/* Problem 5
Write a SQL query to find town names that are 5 or 6 symbols long and order them alphabetically by town name. 
Submit your query statements as Prepare DB & run queries.
*/

SELECT `name` FROM `towns`
WHERE LENGTH(`name`) = 5 OR LENGTH(`name`) = 6
ORDER BY `name`;

/* Problem 6
Write a SQL query to find all towns that start with letters M, K, B or E (case insensitively).
Order them alphabetically by town name. Submit your query statements as Prepare DB & run queries.
*/

SELECT `town_id`, `name` FROM `towns`
WHERE `name` LIKE 'm%' OR `name` LIKE 'k%' OR `name` LIKE 'b%' OR `name` LIKE 'e%'
ORDER BY `name`;

/* Problem 7
Write a SQL query to find all towns that do not start with letters R, B or D (case insensitively).
Order them alphabetically by name. Submit your query statements as Prepare DB & run queries.
*/

SELECT `town_id`, `name` FROM `towns`
WHERE SUBSTR(`name`, 1, 1) NOT IN ('R', 'B', 'D')
ORDER BY `name`;

/* Problem 8
Write a SQL query to create view v_employees_hired_after_2000 with the first and the last name of all employees hired after 2000 year.
Select all from the created view. Submit your queries as Run skeleton, run queries & check DB.
*/

CREATE VIEW v_employees_hired_after_2000 AS
SELECT `first_name`, `last_name` FROM `employees`
WHERE YEAR (`hire_date`) > 2000;

SELECT * FROM `v_employees_hired_after_2000`;

/* Problem 9
Write a SQL query to find the names of all employees whose last name is exactly 5 characters long.
*/
SELECT `first_name`, `last_name` FROM `employees`
WHERE LENGTH(`last_name`) = 5;

-- New Database
USE `geography`;

/* Problem 10
Find all countries that hold the letter 'A' in their name at least 3 times (case insensitively), sorted by ISO code. 
Display the country name and the ISO code. Submit your query statements as Prepare DB & run queries.
*/

SELECT 
    `country_name`, `iso_code`
FROM
    `countries`
WHERE
    `country_name` LIKE '%a%a%a%'
ORDER BY `iso_code`;

/* Problem 11
Combine all peak names with all river names, so that the last letter of each
peak name is the same as the first letter of its corresponding river name. 
Display the peak name, the river name, and the obtained mix(converted to lower case). 
Sort the results by the obtained mix alphabetically. Submit your query statements as Prepare DB & run queries.
*/
 
SELECT 
    `peak_name`,
    `river_name`,
    CONCAT(LOWER(SUBSTRING(`peak_name`,
                        1,
                        LENGTH(`peak_name`) - 1)),
            LOWER(`river_name`)) AS `mix`
FROM
    `peaks`,
    `rivers`
WHERE
    RIGHT(`peak_name`, 1) = LEFT(`river_name`, 1)
ORDER BY `mix`;

-- New Database
USE `diablo`;

/* Problem 12
Find the top 50 games ordered by start date, then by name. Display only the games from the years 2011 and 2012. 
Display the start date in the format "YYYY-MM-DD". Submit your query statements as Prepare DB & run queries.
*/

SELECT 
    `name`, DATE_FORMAT(`start`, '%Y-%m-%d') AS `start`
FROM
    `games`
WHERE
    YEAR(`start`) BETWEEN 2011 AND 2012
ORDER BY `start`
LIMIT 50;

/* Problem 13
Find information about the email providers of all users. Display the user_name and the email provider.
Sort the results by email provider alphabetically, then by username. Submit your query statements as Prepare DB & run queries.
*/

SELECT `user_name`,SUBSTR(`email`,LOCATE('@', `email`) + 1) AS `Email Provider` FROM `users`
ORDER BY `Email Provider` ,`user_name`;

/* Problem 14
Find the user_name and the ip_address for each user, sorted by user_name alphabetically. 
Display only the rows, where the ip_address matches the pattern: "___.1%.%.___". 
Submit your query statements as Prepare DB & run queries.
*/

SELECT `user_name`, `ip_address` FROM `users`
WHERE `ip_address` LIKE '___.1%.%.___'
ORDER BY `user_name`;

/* Problem 15
Find all games with their corresponding part of the day and duration. Parts of the day should be Morning (start time is >= 0 and < 12), 
Afternoon (start time is >= 12 and < 18), Evening (start time is >= 18 and < 24). Duration should be Extra Short (smaller or equal to 3), 
Short (between 3 and 6 including), Long (between 6 and 10 including) and Extra Long in any other cases or without duration. 
Submit your query statements as Prepare DB & run queries.
*/

SELECT `name`,
CASE
WHEN HOUR(`start`) BETWEEN 0 AND 11 THEN 'Morning'
WHEN HOUR(`start`) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END AS `Part of the Day` ,
CASE
	WHEN (`duration`) <= 3 THEN 'Extra Short'
	WHEN (`duration`) BETWEEN 4 AND 6 THEN 'Short'
	WHEN (`duration`) BETWEEN 7 AND 10 THEN 'Long'
    ELSE 'Extra Long'
    END AS `Duration`
FROM `games`;

-- New Database
USE `orders`;

/* Problem 16
You are given a table orders (id, product_name, order_date) filled with data. 
Consider that the payment for an order must be accomplished within 3 days after the order date. 
Also the delivery date is up to 1 month. Write a query to show each product's name, order date, pay and deliver due dates. 
Submit your query statements as Prepare DB & run queries.
*/
SELECT `product_name`,
		`order_date`,
      DATE_ADD(`order_date`, INTERVAL 3 DAY) AS `pay_due`,
      DATE_ADD(`order_date`, INTERVAL 1 MONTH) AS `deliver_due`
FROM `orders`;