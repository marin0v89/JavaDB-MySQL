CREATE DATABASE gamebar;

-- Problem 1
USE `gamebar`;

CREATE TABLE `employees` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(40) NOT NULL,
    `last_name` VARCHAR(40) NOT NULL
);

CREATE TABLE `categories`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(40) NOT NULL
);

CREATE TABLE `products` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(40) NOT NULL,
    `category_id` INT NOT NULL
);

-- Problem 2

INSERT INTO `employees`
VALUES
(1,'Ivan','Ivanov'),
(2,'Stefan','Stefanov'),
(3,'Zdravk','Zdravkov');

SELECT * FROM `employees`;

-- Problem 3
ALTER TABLE `employees`
ADD COLUMN `middle_name` VARCHAR(30);

-- Problem 4
ALTER TABLE `products`
ADD CONSTRAINT fk_products_categories
FOREIGN KEY(`category_id`)
REFERENCES `categories`(`id`);

-- Problem 5
ALTER TABLE `employees`
	MODIFY `middle_name` VARCHAR(100);