# Introduction to SQL and Advanced Functions Assignment

/* Question 1 : Explain the fundamental differences between DDL, DML, and DQL commands in SQL. Provide one example for each type of command.

Answer :

DDL, DML, and DQL in SQL differ mainly by what they operate on and their purpose.

1. DDL (Data Definition Language)

-> DDL commands are used to define and modify the structure of database objects such as tables and schemas. 
-> These commands affect how data is stored but not the actual data itself.
-> Common commands: CREATE, ALTER, DROP, TRUNCATE

Example:

CREATE TABLE students (
    id INT,
    name VARCHAR(50),
    marks INT
);

-----------------------------------------------------------------------------------------

2. DML (Data Manipulation Language)

-> DML commands are used to insert, update, or delete data stored inside database tables. 
-> These commands work on the records rather than the structure.
-> Common commands: INSERT, UPDATE, DELETE

Example:

INSERT INTO students 
VALUES (1, 'Rahul', 85);

------------------------------------------------------------------------------------

3. DQL (Data Query Language)

-> DQL commands are used to retrieve data from the database. They do not change the database contents and are mainly used for data analysis and reporting
-> Main command: SELECT

Example:

SELECT name, marks FROM students;

---------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------

Question 2 : What is the purpose of SQL constraints? Name and describe three common types of constraints, providing a simple scenario where each would be useful.

Answer :

- SQL constraints are rules applied to table columns to ensure data integrity, accuracy, and reliability in a database.
- They prevent invalid data from being inserted and help maintain consistency across tables.

1. PRIMARY KEY Constraint

-> The PRIMARY KEY constraint uniquely identifies each record in a table. 
-> It does not allow duplicate or NULL values.

Scenario:
In a students table, each student must have a unique ID to avoid duplicate records.

Example:

student_id INT PRIMARY KEY

------------------------------------------------------------------------------------------------------

2. NOT NULL Constraint

-> The NOT NULL constraint ensures that a column must have a value and cannot be left empty.

Scenario:
A student’s name must always be provided during registration.

Example:

name VARCHAR(50) NOT NULL

----------------------------------------------------------------------------------------------------------

3. UNIQUE Constraint

-> The UNIQUE constraint ensures that all values in a column are distinct, not duplicated.

Scenario:
Each student should have a unique email address.

Example:

email VARCHAR(100) UNIQUE

-----------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------

Question 3 : Explain the difference between LIMIT and OFFSET clauses in SQL. How would you use them together to retrieve the third page of results, assuming each page
has 10 records?

Answer :

LIMIT and OFFSET clauses in SQL are used to control the number of rows returned by a query, mainly for pagination.

1. LIMIT

-> The LIMIT clause specifies how many records should be returned in the result set.

Example:

SELECT * FROM students
LIMIT 10;

This returns only the first 10 records.

-------------------------------------------------------------------------------------------------------------------------------

2. OFFSET

-> The OFFSET clause specifies how many records to skip before starting to return rows.

Example:

SELECT * FROM students
OFFSET 10;

This skips the first 10 records and returns the remaining rows.

-----------------------------------------------------------------------------------------------------------------------------------

Using LIMIT and OFFSET Together (Pagination)

To retrieve the third page of results with 10 records per page:

- Page 1 → OFFSET 0
- Page 2 → OFFSET 10
- Page 3 → OFFSET 20

Query:

SELECT * FROM students
LIMIT 10 OFFSET 20;

This query skips the first 20 records and returns the next 10 records, which represent the third page.

-----------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------

Question 4 : What is a Common Table Expression (CTE) in SQL, and what are its main
benefits? Provide a simple SQL example demonstrating its usage.

Answer :

- A Common Table Expression (CTE) is a temporary named result set defined using the WITH clause in SQL. 
- It exists only for the duration of a single query and helps break complex queries into simpler, readable parts.

Main Benefits of CTEs:

- Improves readability and clarity of complex SQL queries
- Makes queries easier to maintain and debug
- Allows reuse of the same result set multiple times in a query
- Supports recursive queries (useful for hierarchical data like employee–manager relationships)

Simple Example of a CTE:

WITH high_scorers AS (
    SELECT student_id, name, marks
    FROM students
    WHERE marks > 75
)
SELECT name, marks
FROM high_scorers;

In this example, the CTE high_scorers first selects students scoring more than 75 marks.
The main query then retrieves data from this temporary result set just like a table.

----------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------

Question 5 : Describe the concept of SQL Normalization and its primary goals. Briefly
explain the first three normal forms (1NF, 2NF, 3NF).

Answer :

- SQL Normalization is the process of organizing data in a database to reduce redundancy and improve data integrity. 
- It involves dividing large tables into smaller, well-structured tables and defining proper relationships between them.

Primary Goals of Normalization:

- Eliminate duplicate data
- Avoid update, insert, and delete anomalies
- Ensure data consistency and integrity
- Make the database easier to maintain and scale

1. First Normal Form (1NF):

A table is in 1NF if:
- Each column contains atomic (indivisible) values
- There are no repeating groups or multi-valued attributes
- Each record can be uniquely identified

Example idea: A student should not have multiple phone numbers in a single column.

2. Second Normal Form (2NF):

A table is in 2NF if:
- It is already in 1NF
- Every non-key attribute is fully dependent on the entire primary key(no partial dependency on part of a composite key)

Example idea: 
In a table with (student_id, course_id) as a composite key, student name should depend only on student_id, not on course_id.

3. Third Normal Form (3NF):

A table is in 3NF if:
- It is already in 2NF
- There are no transitive dependencies (non-key attributes should not depend on other non-key attributes)

Example idea: Student department name should not depend on department ID stored in the same table.

------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------

Question 6 : Create a database named ECommerceDB and perform the following tasks:

1. Create the following tables with appropriate data types and constraints:

● Categories
○ CategoryID (INT, PRIMARY KEY)
○ CategoryName (VARCHAR(50), NOT NULL, UNIQUE)

● Products
○ ProductID (INT, PRIMARY KEY)
○ ProductName (VARCHAR(100), NOT NULL, UNIQUE)
○ CategoryID (INT, FOREIGN KEY → Categories)
○ Price (DECIMAL(10,2), NOT NULL)
○ StockQuantity (INT)

● Customers
○ CustomerID (INT, PRIMARY KEY)
○ CustomerName (VARCHAR(100), NOT NULL)
○ Email (VARCHAR(100), UNIQUE)
○ JoinDate (DATE)

● Orders
○ OrderID (INT, PRIMARY KEY)
○ CustomerID (INT, FOREIGN KEY → Customers)
○ OrderDate (DATE, NOT NULL)
○ TotalAmount (DECIMAL(10,2) 

Answer :*/
CREATE DATABASE ECommerceDB;

use ECommerceDB ;

# Categories Table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE
);

# Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL UNIQUE,
    CategoryID INT,
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

# Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    JoinDate DATE
);

# Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

# 2. Insert the following records into each table .

# Categories Table
insert into Categories (CategoryID, CategoryName) values
(1, "Electronics"),
(2, "Books"),
(3, "Home Goods"),
(4, "Apparel");

# Products Table
insert into Products (ProductID, ProductName, CategoryID, Price, StockQuantity) values
(101, "Laptop Pro", 1, 1200.00, 50),
(102, "SQL Handbook", 2, 45.50, 200),
(103, "Smart Speaker", 1, 99.99, 150),
(104, "Coffee Maker", 3, 75.00, 80),
(105, "Novel: The Great SQL", 2, 25.00, 120),
(106, "Wireless Earbuds", 1, 150.00, 100),
(107, "Blender X", 3, 120.00, 60),
(108, "T-Shirt Casual", 4, 20.00, 300);

# Customers Table
insert into Customers (CustomerID, CustomerName, Email, JoinDate) values
(1, "Alice Wonderland", "alice@example.com", '2023-01-10'),
(2, "Bob the Builder", "bob@example.com", '2022-11-25'),
(3, "Charlie Chaplin", "charlie@example.com", '2023-03-01'),
(4, "Diana Prince", "diana@example.com", '2021-04-26');

# Orders Table
insert into Orders (OrderID, CustomerID, OrderDate, TotalAmount) values
(1001, 1, '2023-04-26', 1245.50),
(1002, 2, '2023-10-12', 99.99),
(1003, 1, '2023-07-01', 145.00),
(1004, 3, '2023-01-14', 150.00),
(1005, 2, '2023-09-24', 120.00),
(1006, 1, '2023-06-19', 20.00);

/* ----------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------

Question 7 : Generate a report showing CustomerName, Email, and the TotalNumberofOrders for each customer.
Include customers who have not placed any orders, in which case their TotalNumberofOrders should be 0.
Order the results by CustomerName.

Answer :*/

SELECT 
    c.CustomerName,
    c.Email,
    COUNT(o.OrderID) AS TotalNumberofOrders
FROM Customers c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID,
    c.CustomerName,
    c.Email
ORDER BY 
    c.CustomerName;

/* ----------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------

Question 8 : Retrieve Product Information with Category: 
Write a SQL query to display the ProductName, Price, StockQuantity, and CategoryName for all products.
Order the results by CategoryName and then ProductName alphabetically.

Answer :*/

SELECT 
    p.ProductName,
    p.Price,
    p.StockQuantity,
    c.CategoryName
FROM Products p
INNER JOIN Categories c
    ON p.CategoryID = c.CategoryID
ORDER BY 
    c.CategoryName,
    p.ProductName;
    
/*-------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

Question 9 : Write a SQL query that uses a Common Table Expression (CTE) and a
Window Function (specifically ROW_NUMBER() or RANK()) to display the
CategoryName, ProductName, and Price for the top 2 most expensive products in
each CategoryName.

Answer :*/

WITH RankedProducts AS (
    SELECT
        c.CategoryName,
        p.ProductName,
        p.Price,
        ROW_NUMBER() OVER (
            PARTITION BY c.CategoryName
            ORDER BY p.Price DESC
        ) AS rn
    FROM Products p
    JOIN Categories c
        ON p.CategoryID = c.CategoryID
)
SELECT
    CategoryName,
    ProductName,
    Price
FROM RankedProducts
WHERE rn <= 2
ORDER BY CategoryName, Price DESC;

/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------

Question 10 : You are hired as a data analyst by Sakila Video Rentals, a global movie rental company. 
The management team is looking to improve decision-making by analyzing existing customer, rental, and inventory data.
Using the Sakila database, answer the following business questions to support key strategic initiatives.

Tasks & Questions:
1. Identify the top 5 customers based on the total amount they’ve spent. Include customer
name, email, and total amount spent. */

use sakila;

USE sakila;

WITH Total_payment AS (
    SELECT 
        customer_id, 
        SUM(amount) AS Total_amount
    FROM payment
    GROUP BY customer_id
)
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS CustomerName,
    c.email,
    t.Total_amount
FROM customer c
JOIN Total_payment t
    ON c.customer_id = t.customer_id
ORDER BY 
    t.Total_amount DESC
LIMIT 5;


/* 2. Which 3 movie categories have the highest rental counts? Display the category name
and number of times movies from that category were rented.*/

SELECT 
    c.name AS CategoryName,
    COUNT(r.rental_id) AS RentalCount
FROM category c
JOIN film_category fc
    ON c.category_id = fc.category_id
JOIN inventory i
    ON fc.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
GROUP BY 
    c.category_id, c.name
ORDER BY 
    RentalCount DESC
LIMIT 3;


/* 3. Calculate how many films are available at each store and how many of those have
never been rented.*/

SELECT 
    s.store_id,
    COUNT(DISTINCT i.inventory_id) AS TotalFilms,
    COUNT(DISTINCT CASE 
        WHEN r.rental_id IS NULL THEN i.inventory_id 
    END) AS NeverRented
FROM store s
JOIN inventory i
    ON s.store_id = i.store_id
LEFT JOIN rental r
    ON i.inventory_id = r.inventory_id
GROUP BY 
    s.store_id;
    

/* 4. Show the total revenue per month for the year 2023 to analyze business seasonality.*/

SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS Month,
    SUM(amount) AS TotalRevenue
FROM payment
WHERE YEAR(payment_date) = 2023
GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY Month;

/*The Sakila sample database has a fixed historical dataset, and most payment_date values are in 2005, not 2023. 
So filtering for YEAR(payment_date) = 2023 gives zero results.*/


/* 5. Identify customers who have rented more than 10 times in the last 6 months*/

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS TotalRentals
FROM customer c
JOIN rental r
    ON c.customer_id = r.customer_id
WHERE r.rental_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(r.rental_id) > 10
ORDER BY TotalRentals DESC;

/* The rental_date values in Sakila are mostly in 2005 and 2006.
So no rentals exist in the last 6 months, so the query returns zero rows.*/



    


















