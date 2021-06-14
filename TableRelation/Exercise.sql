USE `geography`;

/* Problem 1
Create two tables as follows. Use appropriate data types.
Insert the data from the example above.
•	Alter table people and make person_id a primary key. 
•	Create a foreign key between people and passports by using the passport_id column. 
•	Think about which passport field should be UNIQUE.
•	Format salary to second digit after decimal point.
*/

CREATE TABLE `people` (
    `person_id` INT AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(50),
    `salary` DECIMAL(7 , 2 ),
    `passport_id` INT
);

CREATE TABLE `passports` (
    `passport_id` INT AUTO_INCREMENT PRIMARY KEY,
    `passport_number` VARCHAR(50) UNIQUE
);

ALTER TABLE `people`
ADD CONSTRAINT fk_people_passports
FOREIGN KEY (`passport_id`)
REFERENCES `passports`(`passport_id`);

INSERT INTO `passports`
VALUES
(101, 'N34FG21B'),
(102, 'K65LO4R7'),
(103, 'ZE657QP2');

INSERT INTO `people`
VALUES
(1, 'Roberto', 43300, 102),
(2, 'Tom', 56100, 103),
(3, 'Yana', 60200, 101);

/* Problem 2
Create two tables as follows. Use appropriate data types.
Insert the data from the example above. 
•	Add primary and foreign keys.
Submit your queries by using "MySQL run queries & check DB" strategy.

*/

CREATE TABLE `manufacturers` (
    `manufacturer_id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(30),
    `established_on` DATE
);

CREATE TABLE `models` (
    `model_id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30),
    `manufacturer_id` INT
)  AUTO_INCREMENT=101;

INSERT INTO `manufacturers`(`name`, `established_on`)
VALUES
('BMW', '1916-03-01'),
('Tesla', '2003-01-01'),
('Lada', '1966-05-01');

INSERT INTO `models` (`name`, `manufacturer_id`)
VALUES
('X1', 1),
('i6', 1),
('Model S', 2),
('Model X', 2),
('Model 3', 2),
('Nova', 3);

/* Problem 3
Create three tables as follows. Use appropriate data types.
Insert the data from the example above.
•	Add primary and foreign keys.
•	Have in mind that the table student_exams should have a 
composite primary key.
Submit your queries by using "MySQL run queries & check DB" strategy.
*/

CREATE TABLE `students` (
    `student_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(30)
);

CREATE TABLE `exams` (
    `exam_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(30)
)  AUTO_INCREMENT=101;

CREATE TABLE `students_exams` (
    `student_id` INT,
    `exam_id` INT
);

ALTER TABLE `students_exams`
ADD CONSTRAINT fk_students_exams
FOREIGN KEY (`student_id`)
REFERENCES `students`(`student_id`);

ALTER TABLE `students_exams`
ADD CONSTRAINT fk_exams
FOREIGN KEY (`exam_id`)
REFERENCES `exams`(`exam_id`);

INSERT INTO `students` (`name`)
VALUES
('Mila'), ('Toni'), ('Ron');

INSERT INTO `exams` (`name`)
VALUES
('Spring MVC'), ('Neo4j'), ('Oracle 11g');

INSERT INTO `students_exams`
VALUES 
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103);

/* Problem 4
Create a single table as follows. Use appropriate data types.
Insert the data from the example above. 
•	Add primary and foreign keys. 
•	The foreign key should be between manager_id and teacher_id.
Submit your queries by using "	MySQL run queries & check DB" strategy.
*/

CREATE TABLE `teachers` (
    `teacher_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(30),
    `manager_id` INT
)  AUTO_INCREMENT=101;

ALTER TABLE `teachers`
ADD CONSTRAINT fk_teachers
FOREIGN KEY (`manager_id`)
REFERENCES `teachers`(`teacher_id`);

/* Problem 5
Create new DB through ER diagram
*/

CREATE DATABASE `shop`;
USE `shop`;

CREATE TABLE `cities` (
    `city_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50)
);

CREATE TABLE `customers` (
    `customer_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50),
    `birthday` DATE,
    `city_id` INT
);

CREATE TABLE `orders` (
    `order_id` INT AUTO_INCREMENT PRIMARY KEY,
    `customer_id` INT
);

CREATE TABLE `order_items` (
    `order_id` INT,
    `item_id` INT
);

CREATE TABLE `items` (
    `item_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50),
    `item_type_id` INT
);

CREATE TABLE `item_types` (
    `item_type_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50)
);

ALTER TABLE `customers`
ADD CONSTRAINT `fk_customers_cities`
FOREIGN KEY (`city_id`)
REFERENCES `cities`(`city_id`);

ALTER TABLE `orders`
ADD CONSTRAINT `fk_orders_customers`
FOREIGN KEY (`customer_id`)
REFERENCES `customers`(customer_id);

ALTER TABLE `order_items`
ADD CONSTRAINT `fk_order_items_orders`
FOREIGN KEY (`order_id`)
REFERENCES `orders`(`order_id`),

ADD CONSTRAINT `fk_order_items`
FOREIGN KEY (`item_id`)
REFERENCES `items`(`item_id`);

ALTER TABLE `items`
ADD CONSTRAINT `fk_items_item_types`
FOREIGN KEY (`item_type_id`)
REFERENCES `item_types`(`item_type_id`);

# Problem 6
CREATE DATABASE `university`;
USE `university`;

CREATE TABLE `subjects` (
    `subject_id` INT AUTO_INCREMENT PRIMARY KEY,
    `subject_name` VARCHAR(50)
);

CREATE TABLE `agenda` (
    `student_id` INT,
    `subject_id` INT
);

CREATE TABLE `students` (
    `student_id` INT AUTO_INCREMENT PRIMARY KEY,
    `student_number` VARCHAR(12),
    `student_name` VARCHAR(50),
    `major_id` INT
);

CREATE TABLE `majors` (
    `major_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50)
);

CREATE TABLE `payments` (
    `payment_id` INT AUTO_INCREMENT PRIMARY KEY,
    `payment_date` DATE,
    `payment_amount` DECIMAL(8, 2),
    `student_id` INT
);

ALTER TABLE `agenda`
ADD CONSTRAINT `pk_agenda`
PRIMARY KEY (`student_id`, `subject_id`);

ALTER TABLE `agenda`
ADD CONSTRAINT `fk_agenda_students_subjects`
FOREIGN KEY (`student_id`)
REFERENCES `subjects`(`subject_id`),

ADD CONSTRAINT `fk_agenda_subject_students`
FOREIGN KEY (`subject_id`)
REFERENCES `students`(`student_id`);

ALTER TABLE `students`
ADD CONSTRAINT `fk_students_majors`
FOREIGN KEY (`major_id`)
REFERENCES `majors`(`major_id`);

ALTER TABLE `payments`
ADD CONSTRAINT `fk_payments_students`
FOREIGN KEY (`student_id`)
REFERENCES `students`(`student_id`);

/* Problem 9
Display all peaks for "Rila" mountain_range. Include:
•	mountain_range
•	peak_name
•	peak_elevation
Peaks should be sorted by peak_elevation descending.
*/

USE `geography`;

SELECT 
    m.`mountain_range`, p.`peak_name`, p.`elevation`
FROM
    `mountains` AS m
        JOIN
    `peaks` AS p ON m.`id` = p.`mountain_id`
WHERE
    m.`mountain_range` = 'Rila'
ORDER BY p.`elevation` DESC;

