CREATE DATABASE `stc`;
USE `STC`;

-- Problem 1

CREATE TABLE `addresses` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR (100) NOT NULL
);

CREATE TABLE `categories` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR (10) NOT NULL
);

CREATE TABLE `clients` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`full_name` VARCHAR (50) NOT NULL,
`phone_number` VARCHAR (20) NOT NULL
);

CREATE TABLE `drivers` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(30) NOT NULL,
`last_name` VARCHAR(30) NOT NULL,
`age` INT NOT NULL,
`rating` FLOAT DEFAULT 5.5
);

CREATE TABLE `cars` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`make` VARCHAR(20) NOT NULL,
`model` VARCHAR(20),
`year` INT NOT NULL DEFAULT 0,
`mileage` INT DEFAULT 0,
`condition` CHAR(1) NOT NULL,
`category_id` INT NOT NULL,

CONSTRAINT fk_cars_categories
FOREIGN KEY (`category_id`)
REFERENCES `categories`(`id`)
);

CREATE TABLE `courses` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`from_address_id` INT NOT NULL,
`start` DATETIME NOT NULL,
`car_id` INT NOT NULL,
`client_id` INT NOT NULL,
`bill` DECIMAL (10, 2) DEFAULT 10,

CONSTRAINT fk_courses_addresses
FOREIGN KEY (`from_address_id`)
REFERENCES `addresses`(`id`),

CONSTRAINT fk_courses_cars
FOREIGN KEY (`car_id`)
REFERENCES `cars`(`id`),

CONSTRAINT fk_courses_clients
FOREIGN KEY (`client_id`)
REFERENCES `clients`(`id`)
);

CREATE TABLE `cars_drivers` (
`car_id` INT NOT NULL,
`driver_id` INT NOT NULL,
CONSTRAINT pk_cars_drivers
PRIMARY KEY (`car_id`, `driver_id`),

CONSTRAINT fk_cars_drivers_cars
FOREIGN KEY (`car_id`)
REFERENCES `cars`(`id`),

CONSTRAINT fk_cars_drivers_drivers
FOREIGN KEY (`driver_id`)
REFERENCES `drivers`(`id`)
);

-- Problem 2

INSERT INTO `clients` (`full_name`, `phone_number`)
SELECT CONCAT(`first_name`, ' ', `last_name`), CONCAT('(088) 9999',d.`id`*2) FROM `drivers` AS d
WHERE d.`id` BETWEEN 10 AND 20;

-- Problem 3

UPDATE `cars` 
SET 
    `condition` = 'C'
WHERE
    `mileage` >= 800000
        OR `mileage` IS NULL AND `year` <= 2010
        AND `make` NOT IN ('Mercedes-Benz');

-- Problem 4

DELETE FROM `clients` 
WHERE
    `id` NOT IN (SELECT 
        `client_id`
    FROM
        `courses`)
    AND CHAR_LENGTH(`full_name`) > 3;
    
    -- Problem 5
    
SELECT 
    `make`, `model`, `condition`
FROM
    `cars`
ORDER BY `id`;

-- Problem 6

SELECT d.`first_name`,d.`last_name`, c.`make`, c.`model`, c.`mileage` FROM `drivers` AS d
JOIN `cars_drivers` AS cd ON d.`id` = cd.`driver_id`
JOIN `cars` AS c ON cd.`car_id` = c.`id`
WHERE c.`mileage` IS NOT NULL
ORDER BY c.`mileage` DESC ,d.`first_name`;

-- Problem 7

SELECT 
    c.`id` AS 'car_id',
    c.`make`,
    c.`mileage`,
    COUNT(cc.`id`) AS 'count_of_courses',
    ROUND(AVG(cc.`bill`), 2) AS 'avg_bill'
FROM
    `cars` AS c
        LEFT JOIN
    `courses` AS cc ON c.`id` = cc.`car_id`
GROUP BY c.`id`
HAVING `count_of_courses` != 2
ORDER BY `count_of_courses` DESC , c.`id`;

-- Problem 8

SELECT 
    c.`full_name`,
    COUNT(cc.id) AS `count_of_cars`,
    SUM(cs.`bill`) AS `total_sum`
FROM
    `clients` AS c
        JOIN
    `courses` AS cs ON c.`id` = cs.`client_id`
        JOIN
    `cars` AS cc ON cs.`car_id` = cc.`id`
GROUP BY c.`id`
HAVING c.`full_name` LIKE '_a%'
    AND `count_of_cars` > 1
ORDER BY c.`full_name`;

-- Problem 9

SELECT 
    a.`name`,
    IF(HOUR(cs.`start`) >= 6
            AND HOUR(cs.`start`) <= 20,
        'Day',
        'Night') AS `day_time`,
    SUM(`bill`) AS `bill`,
    cl.`full_name`,
    cc.`make`,
    cc.`model`,
    ct.`name` AS category_name
FROM
    `addresses` AS a
        JOIN
    `courses` AS cs ON cs.`from_address_id` = a.`id`
        JOIN
    `clients` AS cl ON cl.`id` = cs.`client_id`
        JOIN
    `cars` AS cc ON cs.`car_id` = cc.`id`
        JOIN
    `categories` AS ct ON ct.`id` = cc.`category_id`
GROUP BY cs.`id`
ORDER BY cs.`id`;

-- Problem 10

DELIMITER @@

CREATE FUNCTION `udf_courses_by_client` (`phone` VARCHAR (20)) 
RETURNS INT
DETERMINISTIC 
BEGIN
RETURN (SELECT count(c.`client_id`) FROM clients  AS cl
JOIN `courses` AS c
ON cl.`id` = c.`client_id`
WHERE cl.`phone_number` = `phone`);
END@@

DELIMITER ;

-- Problem 11

DELIMITER @@

CREATE PROCEDURE `udp_courses_by_address` (`address` VARCHAR(100))
BEGIN
SELECT a.`name`, cl.`full_name`, (
    CASE 
        WHEN co.`bill`<20 THEN 'Low'
        WHEN co.`bill`<30 THEN 'Medium'
		ELSE 'High'
    END)  AS 'level_of_bill', cc.`make`, cc.`condition`, ca.`name` AS 'cat_name' FROM `addresses` AS a
JOIN `courses` AS co ON co.`from_address_id` = a.`id`
JOIN `cars` AS cc ON co.`car_id` = cc.`id`
JOIN `clients` AS cl ON co.`client_id`= cl.`id`
JOIN `categories` AS ca ON cc.`category_id` = ca.`id`
WHERE a.`name` = `address`
ORDER BY cc.`make`, cl.`full_name`;

END@@

DELIMITER ;