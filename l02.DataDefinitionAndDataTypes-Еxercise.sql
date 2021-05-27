CREATE DATABASE `minions`;

USE `minions`;

-- Problem 1

CREATE TABLE `minions`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(40) NOT NULL,
`age` INT
);

CREATE TABLE `towns`(
`town_id`INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(40) NOT NULL
);

-- Problem 2
ALTER TABLE `minions`
ADD COLUMN `town_id` INT,
ADD CONSTRAINT fk_minions_towns
FOREIGN KEY (`towns_id`)
REFERENCES `towns` (`id`);

-- Problem 3
INSERT INTO `towns`
VALUES
(1,'Sofia'),
(2,'Plovdiv'),
(3,'Varna');

INSERT INTO `minions`
VALUES
(1,'Kevin',22,1),
(2,'Bob',15,3),
(3,'Steward',NULL,2);

-- Proble, 4

TRUNCATE `minions`;

-- Problem 5
DROP TABLE `minions`;

-- Problem 6

CREATE TABLE `people`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(200) NOT NULL,
`picture` BLOB,
`height` DOUBLE(5,2),
`weight` DOUBLE (5,2),
`gender` CHAR(1) NOT NULL,
`birthdate` DATE NOT NULL,
`biography` TEXT
);

INSERT INTO `people`(`name`,`picture`,`height`,`weight`,`gender`,`birthdate`,`biography`)
VALUES
('Testing Test 1st', NULL, '1.70', '88.12', 'm', '1999-12-03', 'Some text here'),
('Testing Test 2nd', NULL, '1.50', '66.25', 'f', '1983-12-08', 'text text text'),
('Testing Test 3rd', NULL, '1.80', '102.12', 'm', '1978-02-14', 'texting text'),
('Testing Test 4th', NULL, '1.82', '76.26', 'm', '1989-07-16', 'Some text here'),
('Testing Test 5th', NULL, '1.67', '54.12', 'f', '1994-12-28', 'Some text here');

SELECT * FROM `people`;

-- Problem 7

CREATE TABLE `users`(
`id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
`username` VARCHAR(30),
`password` VARCHAR(26),
`profile_picture` BLOB,
`last_login_time` DATE,
`is_deleted` BOOLEAN
);

INSERT INTO `users`(`username`,`password`,`profile_picture`,`last_login_time`,`is_deleted`)
VALUES 
('test user one','123456',NULL,'2021-05-26',FALSE),
('test user two','654321',NULL,'2021-05-21',TRUE),
('test user three','asdqwer',NULL,'2021-05-23',FALSE),
('test user four','password',NULL,'2021-05-22',TRUE),
('test user five','dumbpassword',NULL,'2021-05-15',FALSE);

SELECT * FROM `users`;

-- Problem 8

ALTER TABLE `users`
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users
PRIMARY KEY (`id`,`username`);

-- Problem 9
ALTER TABLE `users`
CHANGE COLUMN `last_login_time` `last_login_time`TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Problem 10

ALTER TABLE `users`
DROP PRIMARY KEY,
ADD CONSTRAINT pk PRIMARY KEY (`id`),
ADD CONSTRAINT u UNIQUE (`username`);

-- Problem 11

CREATE DATABASE `movies`;
USE `movies`;

CREATE TABLE `directors` (
    `id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `director_name` VARCHAR(70) NOT NULL,
    `notes` TEXT
);

CREATE TABLE `genres`(
	`id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `genre_name` VARCHAR(70) NOT NULL,
    `notes` TEXT
);

CREATE TABLE `categories`(
	`id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `category_name` VARCHAR(70) NOT NULL,
    `notes` TEXT
);

CREATE TABLE `movies` (
    `id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `title` VARCHAR(70) NOT NULL,
    `director_id` INT NOT NULL,
    `copyright_year` YEAR NOT NULL,
    `length` TIME NOT NULL,
    `genre_id` INT NOT NULL,
    `category_id` INT NOT NULL,
    `rating` FLOAT NOT NULL,
    `notes` TEXT
);

ALTER TABLE `movies`
ADD CONSTRAINT fk_director_id
FOREIGN KEY (`director_id`)
REFERENCES `directors`(`id`);

ALTER TABLE `movies`
ADD CONSTRAINT fk_genre_id
FOREIGN KEY (`genre_id`)
REFERENCES `genres`(`id`);

ALTER TABLE `movies`
ADD CONSTRAINT fk_category_id
FOREIGN KEY (`category_id`)
REFERENCES `categories`(`id`);

INSERT INTO `directors`(`director_name`)
VALUES
('1'),
('2'),
('3'),
('4'),
('5');

INSERT INTO `genres`(`genre_name`)
VALUES
('11'),
('22'),
('33'),
('44'),
('55');

INSERT INTO `categories`(`category_name`)
VALUES
('111'),
('222'),
('333'),
('444'),
('555');

INSERT INTO `movies`(`title`,`director_id`,`copyright_year`,
					`length`,`genre_id`,`category_id`,`rating`,`notes`)
	VALUES
    ('Title1','1','2021','12:34:56','1','1','7','notes'),
    ('Title2','2','2020','12:34:56','2','2','7','notes'),
    ('Title3','3','2019','12:34:56','3','3','7','notes'),
    ('Title4','4','2018','12:34:56','4','4','7','notes'),
    ('Title5','5','2017','12:34:56','5','5','7','notes');


-- Problem 12

CREATE DATABASE `car_rental`;
USE `car_rental`;

CREATE TABLE `categories`(
`id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
`category` VARCHAR(50) NOT NULL,
`daily_rate` INT NOT NULL,
`weekly_rate` INT NOT NULL,
`monthly_rate` INT NOT NULL,
`weekend_rate` INT NOT NULL
);

CREATE TABLE `cars`(
`id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
`plate_number` CHAR (6) NOT NULL,
`make` VARCHAR (20),
`model` VARCHAR (30),
`car_year` YEAR NOT NULL,
`category_id` INT NOT NULL,
`doors` INT,
`picture` BLOB,
`car_condition` VARCHAR (100) NOT NULL,
`available` BOOLEAN
);

CREATE TABLE `employees`(
`id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
`first_name` VARCHAR (50),
`last_name` VARCHAR (50),
`title` VARCHAR (50),
`notes` TEXT
);

CREATE TABLE `customers`(
`id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
`driver_licence_number` INT NOT NULL,
`full_name` VARCHAR (150) NOT NULL,
`address` VARCHAR (70),
`city` VARCHAR (50),
`zip_code` INT,
`notes` TEXT
);

CREATE TABLE `rental_orders`(
`id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
`employee_id` INT NOT NULL,
`customer_id` INT NOT NULL,
`car_id` INT NOT NULL,
`car_condition` VARCHAR (100) NOT NULL,
`tank_level` VARCHAR (50) NOT NULL,
`kilometrage_start` FLOAT (5,4) NOT NULL,
`kilometrage_end` FLOAT (5,4) NOT NULL,
`total_kilometrage` FLOAT (5,4) NOT NULL,
`start_date` DATE NOT NULL,
`end_date` DATE NOT NULL,
`total_days` INT NOT NULL,
`rate_applied` INT NOT NULL,
`tax_rate` FLOAT (5,2),
`order_status` VARCHAR(20) NOT NULL,
`notes` TEXT
);

ALTER TABLE `cars`
ADD CONSTRAINT fk_category_id
FOREIGN KEY (`category_id`)
REFERENCES `category`(`id`);

ALTER TABLE `rental_orders`
ADD CONSTRAINT fk_employee_id
FOREIGN KEY (`employee_id`)
REFERENCES `employees`(`id`);

ALTER TABLE `rental_orders`
ADD CONSTRAINT fk_customer_id
FOREIGN KEY (`customer_id`)
REFERENCES `customers`(`id`);

ALTER TABLE `rental_orders`
ADD CONSTRAINT fk_car_id
FOREIGN KEY (`car_id`)
REFERENCES `cars`(`id`);

INSERT INTO `categories`(`category`, `daily_rate`, `weekly_rate`, `monthly_rate`, `weekend_rate`)
VALUES
('Car', 100, 500, 2000, 200),
('Truck', 200, 1000, 2002, 200),
('Car1', 300, 500, 1234, 200),
('Car3', 400, 2341, 4321, 200),
('Car6', 100, 500, 2000, 200);

INSERT INTO `cars` (`plate_number`, `make`, `model`, `car_year`, `category_id`, `doors`, `picture`, `car_condition`, `available`)
values 
('TEST1', 'Skoda','Superb',2015,1,5,NULL,'very good',TRUE),
('TEST2', 'VW','polo',2003,2,5,NULL,'very good',FALSE),
('TEST3', 'AUDI','Superb',2020,3,5,NULL,'very good',TRUE),
('TEST4', 'Mercedes','Superb',2017,4,5,NULL,'very good',FALSE),
('TEST5', 'Jigulka','Superb',2018,5,5,NULL,'very good',TRUE);

INSERT INTO `employees`(`first_name`, `last_name`, `title`, `notes`)
VALUES
('Tosho','Toshov','Mr','asdasd'),
('Miss','Missis','Mrs','asd3'),
('Test','Testov','Mr','asdawdeqwesd'),
('Miss','Testova','Mrs','asd132qasd'),
('Test','Dumbov','Mr','asdasqe3rd');

INSERT INTO `customers`(`driver_licence_number`, `full_name`, `address`, `city`, `zip_code`, `notes`)
VALUES
(123124,'Édno Onufri','Some Adress One','Testovilee',3000,'asdasd'),
(123,'Dve Onufri','Some Adress two','Testovilee',123,'asdasd'),
(21342,'Tri Onufri','Some Adress three','Testovilee',35423,'asdasd'),
(12342,'Chetiri Onufri','Some Adress four','Testovilee',234,'asdasd'),
(64235,'pet Onufri','Some Adress five','Testovilee',3443,'asdasd');

INSERT INTO `rental_orders`(employee_id, customer_id, car_id, car_condition, tank_level, kilometrage_start, 
kilometrage_end, total_kilometrage, start_date, end_date, total_days, rate_applied, tax_rate, order_status, notes)
VALUES 
(1 ,1 ,1 ,'good' ,'full' ,42 ,324 ,32,'2021-12-31','2021-12-31',2,234,987,TRUE,'asdafsd'),
(2 ,2 ,2 ,'good' ,'half' ,42 ,34 ,34,'2021-12-31','2019-12-31',3,25,987,FALSE,'asdaadasfsd'),
(3 ,3 ,3 ,'good' ,'empty' ,24 ,33 ,34,'2021-12-31','2017-12-31',4,43,987,FALSE,'asdasdasdfsd'),
(4 ,4 ,4 ,'good' ,'full' ,232,324,328,'2021-12-31','2016-12-31',5,23,987,TRUE,'asdas'),
(5 ,5 ,5 ,'good' ,'full' ,42 ,334 ,32,'2021-12-31','2013-12-31',6,34,987,TRUE,'asdasdasdafsd');
