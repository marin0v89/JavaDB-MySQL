USE `restaurant`;

/* Problem 1
Write a query to count the number of employees in each department by id. 
Order the information by deparment_id, then by employees count. 
Submit your queries with the MySQL prepare DB & run queries strategy.
*/

SELECT 
    `department_id`, COUNT(`id`) AS 'Number of employees'
FROM
    `employees`
GROUP BY (`department_id`);

/* Problem 2
Write a query to calculate the average salary in each department. Order the information by department_id. 
Round the salary result to two digits after the decimal point. 
Submit your queries with the MySQL prepare DB & run queries strategy.
*/

SELECT 
    `department_id`, ROUND(AVG(`salary`), 2) AS 'Average Salary'
FROM
    `employees`
GROUP BY `department_id`;

/* Problem 3
Write a query to retrieve information about the departments grouped by department_id with minumum salary higher than 800. 
Round the salary result to two digits after the decimal point. Submit your queries with the MySQL prepare DB & run queries strategy.
*/

SELECT 
    `department_id`, ROUND(MIN(`salary`), 2) AS 'Min Salary'
FROM
    `employees`
WHERE
    `salary` > 800
GROUP BY `department_id`
LIMIT 1;

/* Problem 4
Write a query to retrieve the count of all appetizers (category id = 2) with price higher than 8. 
Submit your queries with the MySQL prepare DB & run queries strategy. 
*/

SELECT 
    COUNT(`name`) AS 'Appetizers Count'
FROM
    `products`
WHERE
    `category_id` = 2 AND `price` > 8;
    
    /* Proble 5
    Write a query to retrieve information about the prices of each category. The output should consist of:
•	Category_id
•	Average Price 
•	Cheapest Product
•	Most Expensive Product
	Round the results to 2 digits after the decimal point. 
    */
    
    SELECT 
    `category_id`,
    ROUND(AVG(`price`), 2) AS 'Average Price',
    ROUND(MIN(`price`), 2) AS 'Cheapest Product',
    ROUND(MAX(`price`), 2) AS 'Most Expensive Product'
FROM
    `products`
GROUP BY `category_id`;