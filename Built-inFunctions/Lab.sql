USE `book_library`;

/* Problem 1
Write a SQL query to find books which titles start with "The".
Order the result by id. Submit your query statements as Prepare DB & run queries. 
*/

SELECT `title` FROM `books`
WHERE SUBSTRING(`title`, 1, 3) = 'The';

/* Problem 2
Write a SQL query to find books which titles start with "The" and replace the substring with 3 asterisks. 
Retrieve data about the updated titles. Order the result by id. Submit your query statements as Prepare DB & run queries. 
*/

SELECT
REPLACE (`title`, 'The', '***') AS `title` FROM `books` 
WHERE SUBSTR(`title`, 1, 3) = 'The';

/* Problem 3
Write a SQL query to sum prices of all books. Format the output to 2 digits after decimal point. 
Submit your query statements as Prepare DB & run queries. 
*/

SELECT ROUND(SUM(`cost`), 2) FROM `books`;

/* Problem 4
Write a SQL query to calculate the days that the authors have lived. NULL values mean that the author is still alive. 
Submit your query statements as Prepare DB & run queries. 
*/

SELECT 
CONCAT_WS(' ', `first_name`, `last_name`) AS 'Full Name',
TIMESTAMPDIFF(DAY, `born`, `died`) AS 'Days Lived'FROM `authors`;

/* Problem 5
Write a SQL query to retrieve titles of all the Harry Potter books. Order the information by id. 
Submit your query statements as Prepare DB & run queries. 
*/

SELECT `title` FROM `books`
WHERE SUBSTR(`title`, 1, 12) = 'Harry Potter';
