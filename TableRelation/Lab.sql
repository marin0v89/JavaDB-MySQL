USE `camp`;
/* Problem 1 
Write a query to create two tables – mountains and peaks and link their fields properly. Tables should have:
-	Mountains:
•	id 
•	name
-	Peaks: 
•	id
•	name
•	mountain_id
Check your solutions using the "Run Queries and Check DB" strategy.
*/

CREATE TABLE `mountains` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50)
);

CREATE TABLE `peaks` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50),
    `mountain_id` INT,
    CONSTRAINT `fk_peaks_mountains` FOREIGN KEY (`mountain_id`)
	REFERENCES `mountains` (`id`)
);

/* Problem 2
Write a query to retrieve information about SoftUni camp's transportation organization.
Get information about the drivers (name and id) and their vehicle type.
Submit your queries using the "MySQL prepare DB and Run Queries" strategy.
*/

SELECT 
    `driver_id`,
    `vehicle_type`,
    CONCAT(`first_name`, ' ', `last_name`) AS 'driver_name'
FROM
    `vehicles` AS v
        JOIN
    `campers` AS c ON v.driver_id = c.id;
    
    /* Problem 3
    Get information about the hiking routes – starting point and ending point, and their leaders – name and id.
    Submit your queries using the "MySQL prepare DB and Run Queries" strategy.
    */
    
    SELECT 
    `starting_point`,
    `end_point`,
    `leader_id`,
    CONCAT(`first_name`, ' ', `last_name`) AS 'driver_name'
FROM
    `routes` AS r
        JOIN
    `campers` AS c ON r.leader_id = c.id;

/* Problem 4
Drop tables from the task 1.
Write a query to create a one-to-many relationship between a table, holding information about 
mountains (id, name) and other - about peaks (id, name, mountain_id), so that when a mountain 
gets removed from the database, all his peaks are deleted too.
Submit your queries using the "MySQL run queries & check DB" strategy.

*/

CREATE TABLE `mountains` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50)
);

CREATE TABLE `peaks` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50),
    `mountain_id` INT,
    CONSTRAINT `fk_peaks_mountains` FOREIGN KEY (`mountain_id`)
	REFERENCES `mountains` (`id`)
  	ON DELETE CASCADE
);