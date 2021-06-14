USE `soft_uni`;

/* Problem 1
Write a query to retrieve information about the managers – id, full_name, deparment_id and department_name.
Select the first 5 departments ordered by employee_id.
Submit your queries using the "MySQL prepare DB and Run Queries" strategy. 
*/

SELECT 
    e.`employee_id`,
    CONCAT(e.`first_name`, ' ', `last_name`) AS `full_name`,
    d.`department_id`,
    d.`name`
FROM
    `employees` AS e
        JOIN
    `departments` AS d ON e.`employee_id` = d.`manager_id`
ORDER BY e.`employee_id`
LIMIT 5;

/* Problem 2
Write a query to get information about the addresses in the database, which are in San Francisco, Sofia or Carnation. 
Retrieve town_id, town_name, address_text. Order the result by town_id, then by address_id. 
Submit your queries using the "MySQL prepare DB and Run Queries" strategy. 
*/

SELECT 
    a.`town_id`, t.`name`, a.`address_text`
FROM
    `addresses` AS a
        JOIN
    `towns` AS t ON t.`town_id` = a.`town_id`
WHERE
    t.`name` IN ('San Francisco' , 'Sofia', 'Carnation')
ORDER BY t.`town_id` , a.`address_id`;

/* Problem 3
Write a query to get information about employee_id, first_name, last_name, department_id and salary for all employees who don't have a manager. 
Submit your queries using the "MySQL prepare DB and Run Queries" strategy.
*/

SELECT 
    `employee_id`,
    `first_name`,
    `last_name`,
    `department_id`,
    `salary`
FROM
    `employees`
WHERE
    `manager_id` IS NULL;
    
    /* Problem 4
    Write a query to count the number of employees who receive salary higher than the average. 
    Submit your queries using the "MySQL prepare DB and Run Queries" strategy.
    */
    
    SELECT 
    COUNT(*) AS `count`
FROM
    `employees`
WHERE
    `salary` > (SELECT 
            AVG(`salary`)
        FROM
            `employees`);