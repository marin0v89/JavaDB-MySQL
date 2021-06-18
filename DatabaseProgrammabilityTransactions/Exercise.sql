USE `soft_uni`;

/* Problem 1
Create stored procedure usp_get_employees_salary_above_35000 that returns all employees' first and last names for whose salary is above 35000.
The result should be sorted by first_name then by last_name alphabetically, and id ascending.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

DELIMITER @@

CREATE PROCEDURE `usp_get_employees_salary_above_35000` ()
BEGIN
SELECT 
    `first_name`, `last_name`
FROM
    `employees`
WHERE
    `salary` > 35000
ORDER BY `first_name` , `last_name` , `employee_id` ASC;
END @@

DELIMITER ;
CALL `usp_get_employees_salary_above_35000`;

/* Problem 2
Create stored procedure usp_get_employees_salary_above that accept a decimal number (with precision, 4 digits after the decimal point) 
as parameter and return all employee's first and last names whose salary is above or equal to the given number. 
he result should be sorted by first_name then by last_name alphabetically and id ascending. 
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

DELIMITER @@

CREATE PROCEDURE `usp_get_employees_salary_above` (`salary_param` DECIMAL(10,4))
BEGIN
SELECT 
    `first_name`, `last_name`
FROM
    `employees`
WHERE
    `salary` >= `salary_param`
ORDER BY `first_name` , `last_name` , `employee_id` ;
END @@

DELIMITER ;

/* Problem 3
Write a stored procedure usp_get_towns_starting_with that accept string as parameter and returns all town names starting with that string. 
The result should be sorted by town_name alphabetically. Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

DELIMITER @@

CREATE PROCEDURE `usp_get_towns_starting_with` (`char_param` VARCHAR(20))
BEGIN
SELECT 
    `name`
FROM
    `towns`
WHERE
    SUBSTR(`name`,
        1,
        CHAR_LENGTH(`char_param`)) = `char_param`
ORDER BY `name`;
END @@

DELIMITER ;

/* Problem 4
Write a stored procedure usp_get_employees_from_town that accepts town_name as parameter and return the employees' first and last name 
that live in the given town. The result should be sorted by first_name then by last_name alphabetically and id ascending. 
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

DELIMITER @@

CREATE PROCEDURE `usp_get_employees_from_town` (`town_param` VARCHAR(50))
BEGIN
SELECT 
    e.`first_name`, e.`last_name`
FROM
    `employees` AS e
        JOIN
    `addresses` AS a USING (`address_id`)
        JOIN
    `towns` AS t USING (`town_id`)
WHERE
    t.`name` = `town_param`
ORDER BY `first_name` , `last_name` , `employee_id`;
END@@

DELIMITER ;

/* Problem 5
Write a function ufn_get_salary_level that receives salary of an employee and returns the level of the salary.
•	If salary is < 30000 return "Low"
•	If salary is between 30000 and 50000 (inclusive) return "Average"
•	If salary is > 50000 return "High"
*/

DELIMITER @@

CREATE FUNCTION `ufn_get_salary_level` (`salary_range` DECIMAL(10,2))
RETURNS VARCHAR (50)
DETERMINISTIC
BEGIN

RETURN 
(CASE
WHEN `salary_range` < 30000 THEN 'Low'
WHEN `salary_range` BETWEEN 30000 AND 50000 THEN 'Average'
ELSE 'High'
END);
 
END@@

DELIMITER ;

/* Problem 6
Write a stored procedure usp_get_employees_by_salary_level that receive as parameter level of salary (low, average or high)
and print the names of all employees that have given level of salary.
The result should be sorted by first_name then by last_name both in descending order.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

delimiter @@

CREATE PROCEDURE `usp_get_employees_by_salary_level` (level_salary varchar(10))
BEGIN
	select first_name, last_name 
    from employees
	where 
    (case 
    when level_salary = 'low' then 
    salary BETWEEN 0 and 29999 
    
    when level_salary = 'average' then   
    salary BETWEEN 30000 and 50000 
 
    when level_salary = 'high' then 
    salary > 50000
	END)
    order by first_name desc, last_name desc; 
END@@

DELIMITER ;

 /* Problem 7
 Define a function ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))  
 that returns 1 or 0 depending on that if the word is a comprised of the given set of letters. 
 */
 
 DELIMITER @@

CREATE FUNCTION `ufn_is_word_comprised`(`set_of_letters` varchar(50), `word` varchar(50))
RETURNS BIT
DETERMINISTIC
BEGIN

RETURN `word` REGEXP (concat('^[', `set_of_letters`, ']+$'));
END @@
 
 DELIMITER ;
 
/* Problem 8
You are given a database schema with tables:
•	account_holders(id (PK), first_name, last_name, ssn) 
and 
•	accounts(id (PK), account_holder_id (FK), balance).
Write a stored procedure usp_get_holders_full_name that selects the full names of all people.
The result should be sorted by full_name alphabetically and id ascending.
*/

DELIMITER @@

CREATE PROCEDURE `usp_get_holders_full_name` ()
BEGIN
SELECT CONCAT_WS(' ',`first_name`, `last_name`) AS `full_name` FROM `account_holders`
ORDER BY `full_name` ,`id`;
END@@

DELIMITER ;

/* Problem 9*
Your task is to create a stored procedure usp_get_holders_with_balance_higher_than that accepts a number as a parameter and 
returns all people who have more money in total of all their accounts than the supplied number. 
The result should be sorted by account_holders.id ascending. 
*/

DELIMITER @@

CREATE PROCEDURE `usp_get_holders_with_balance_higher_than` (`num` DECIMAL(10,2))
BEGIN
SELECT ah.`first_name`, ah.`last_name`  FROM `account_holders` AS ah
JOIN `accounts` AS a
ON a.`account_holder_id` = ah.`id`
 WHERE (SELECT SUM(`balance`) FROM `accounts` AS aa
 WHERE aa.`account_holder_id` = a.`account_holder_id`
 GROUP BY `account_holder_id`
 ) > `num`
 GROUP BY ah.`id`
ORDER BY ah.`id`;
END@@

DELIMITER ;


/* Problem 10
Your task is to create a function ufn_calculate_future_value that accepts as parameters – sum (with precision, 4 digits after the decimal point), 
yearly interest rate (double) and number of years(int). It should calculate and return the future value of the initial sum. 
The result from the function must be decimal, with percision 4.
*/

DELIMITER @@

CREATE FUNCTION `ufn_calculate_future_value`(SUM DECIMAL(10,4), `yearly_interest_rate` DECIMAL(10,4), `number_of_years` INT)
RETURNS DECIMAL(10,4)
DETERMINISTIC
BEGIN
    DECLARE `result` DECIMAL(10,4);
    SET `result` := SUM * (POW((`yearly_interest_rate`  + 1),  `number_of_years`));
	RETURN `result`;
END @@

DELIMITER ;

/* Problem 11
Your task is to create a stored procedure usp_calculate_future_value_for_account that accepts as parameters – id of account and interest rate.
The procedure uses the function from the previous problem to give an interest to a person's account for 5 years, 
along with information about his/her account id, first name, last name and current balance as it is shown in the example below.
It should take the account_id and the interest_rate as parameters. Interest rate should have precision up to 0.0001,
same as the calculated balance after 5 years. Be extremely careful to achieve the desired precision!
Submit your query statement as Run skeleton, run queries & check DB in Judge.
*/

DELIMITER @@

CREATE PROCEDURE `usp_calculate_future_value_for_account`(`account_id` INT, `interest` DECIMAL(10,4))
BEGIN
   SELECT a.`id`, ah.`first_name`, ah.`last_name`, a.`balance`,
     (SELECT `ufn_calculate_future_value`(a.`balance`,`interest`,5)) AS `balance_in_5_years` 
 FROM `accounts` AS a
 JOIN `account_holders` AS ah ON a.`account_holder_id` = ah.`id`
 where a.`id` = `account_id`;
 END @@
 
 /* Problem 12
Add stored procedure usp_deposit_money(account_id, money_amount) that operate in transactions. 
Make sure to guarantee valid positive money_amount with precision up to fourth sign after decimal point. 
The procedure should produce exact results working with the specified precision.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
 */
 
 DELIMITER @@
 
CREATE PROCEDURE `usp_deposit_money`(`account_id` INT, `money_amount` DECIMAL(10,4))
BEGIN 
   UPDATE  `accounts` as a
   
   SET a.`balance` = if(`money_amount` >0, ROUND(a.`balance` + `money_amount`, 4), a.`balance`)
   WHERE a.`id` = `account_id`;
   END@@
   
  DELIMITER ;
  
  /* Problem 13
Add stored procedures usp_withdraw_money(account_id, money_amount) that operate in transactions. 
Make sure to guarantee withdraw is done only when balance is enough and money_amount is valid positive number. 
Work with precision up to fourth sign after decimal point. The procedure should produce exact results working with the specified precision.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
  */
  
  DELIMITER @@
  
CREATE PROCEDURE `usp_withdraw_money`(`account_id` INT, `money_amount` DECIMAL(20,4))
BEGIN 
   UPDATE  `accounts` AS a
   SET a.`balance` = IF((`money_amount` >0 AND a.`balance` >= `money_amount`), ROUND(a.`balance` - `money_amount`,4), a.`balance`)
   WHERE a.`id` = `account_id`;
   END@@
   
   DELIMITER ;
   
   /* Problem 14
   Write stored procedure usp_transfer_money(from_account_id, to_account_id, amount) that transfers money from one account to another. 
   Consider cases when one of the account_ids is not valid, the amount of money is negative number, outgoing balance is enough or 
   transferring from/to one and the same account. 
   Make sure that the whole procedure passes without errors and if error occurs make no change in the database. 
   Make sure to guarantee exact results working with precision up to fourth sign after decimal point.
   */
   
DELIMITER @@

CREATE PROCEDURE `usp_transfer_money`(`from` INT, `to` INT, `amount` DECIMAL(20,4))
BEGIN
	
	IF ((SELECT COUNT(`id`) FROM `accounts` WHERE id = `from`) = 1
    AND (SELECT COUNT(`id`) FROM `accounts` WHERE id = `to`) = 1
    AND (SELECT `balance` from `accounts` WHERE id = `from`) >= amount
    AND `amount` >=0)
    THEN
	START TRANSACTION;
	UPDATE `accounts` AS a 
SET 
    a.`balance` = ROUND(a.balance - amount, 4)
WHERE
    a.`id` = `from`;
UPDATE `accounts` AS a 
SET 
    a.`balance` = ROUND(a.`balance` + `amount`, 4)
WHERE
    a.`id` = `to`;
    ELSE ROLLBACK;
		END IF; 
END @@
   DELIMITER ;
   
   /* Problem 15 *
   Create another table – logs(log_id, account_id, old_sum, new_sum). 
   Add a trigger to the accounts table that enters a new entry into the logs table every time the sum on an account changes.
   Submit your query statement as Run skeleton, run queries & check DB in Judge.
   */
   
  CREATE TABLE `logs` (
    `log_id` INT PRIMARY KEY AUTO_INCREMENT,
    `account_id` INT,
    `old_sum` DECIMAL(20 , 4 ),
    `new_sum` DECIMAL(20 , 4 )
);
CREATE TRIGGER `account_logs`
AFTER UPDATE
ON `accounts` 
FOR EACH ROW

	INSERT INTO `logs` (`account_id`, `old_sum`, `new_sum`)
	VALUES(NEW.`id`, OLD.`balance`, NEW.`balance`);