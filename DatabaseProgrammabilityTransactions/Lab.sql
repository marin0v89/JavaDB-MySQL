USE `soft_uni`;

/* Problem 1
Write a function ufn_count_employees_by_town(town_name) that accepts town_name as parameter and returns the count of 
employees who live in that town. Submit your queries using the "MySQL Run Skeleton, run queries and check DB" strategy.
*/

DELIMITER @@

CREATE FUNCTION `ufn_count_employees_by_town`(`town_name` VARCHAR(50)) RETURNS int
    DETERMINISTIC
BEGIN

RETURN (SELECT COUNT(*) AS `count` FROM `employees` AS e
JOIN `addresses`
USING (`address_id`)
JOIN `towns` AS t
USING (`town_id`)
WHERE t.`name` = `town_name`);
END@@

DELIMITER ;

SELECT `ufn_count_employees_by_town` ('Sofia') AS count;

/* Problem 2
Write a stored procedure usp_raise_salaries(department_name) to raise the salary of all employees in given department as parameter by 5%. 
Submit your queries using the "MySQL Run Skeleton, run queries and check DB" strategy. 
*/

DELIMITER @@

CREATE PROCEDURE usp_raise_salaries (`department_name` VARCHAR(40)) 
BEGIN
UPDATE `employees` AS e
        JOIN
    `departments` AS d ON e.`department_id` = d.`department_id`
        AND d.`name` = `department_name` 
SET 
    e.`salary` = e.`salary` * 1.05;
END@@

DELIMITER ;

CALL `usp_raise_salaries` ('Finance');

/* Problem 3
Write a stored procedure usp_raise_salary_by_id(id) that raises a given employee's salary (by id as parameter) by 5%.
Consider that you cannot promote an employee that doesn't exist – if that happens, no changes to the database should be made.
Submit your queries using the "MySQL Run Skeleton, run queries and check DB" strategy. 
*/

DELIMITER @@

CREATE PROCEDURE `usp_raise_salary_by_id`(id INT)
BEGIN

IF ( (SELECT COUNT(*) FROM `employees` WHERE `employee_id` = `id`) = 1)
THEN

UPDATE `employees`
SET `salary` = `salary` * 1.05
WHERE `employee_id` = `id`;
END IF;
END@@

DELIMITER ;

CALL `usp_raise_salary_by_id` (3);

/* Problem 4
Create a table deleted_employees(employee_id PK, first_name,last_name,middle_name,job_title,deparment_id,salary) 
that will hold information about fired(deleted) employees from the employees table. Add a trigger to employees 
table that inserts the corresponding information in deleted_employees. Submit your queries using the "MySQL Run 
Skeleton, run queries and check DB" strategy.
*/

CREATE TABLE `deleted_employees`(
`employee_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(50),
`last_name` VARCHAR(50),
`middle_name` VARCHAR(50),
`job_title` VARCHAR(50),
`department_id` INT,
`salary` DECIMAL(19,4));

DELIMITER @@

CREATE TRIGGER `log_deleted_employees` AFTER DELETE ON `employees`
FOR EACH ROW
BEGIN
	INSERT INTO `deleted_employees` 
	(`first_name`, `last_name`, `middle_name`, `job_title`, `department_id`, `salary`)
	VALUES (OLD.`first_name`, OLD.`last_name`, OLD.`middle_name`,
	OLD.`job_title`, OLD.`department_id`, OLD.`salary`);
END@@

DELIMITER ;