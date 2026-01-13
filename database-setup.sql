-- Employee Management API - Database Setup Script
-- This script creates the database and provides sample data

-- Create database (if not exists)
CREATE DATABASE IF NOT EXISTS employee_db;

-- Use the database
USE employee_db;

-- Note: The 'employees' table will be automatically created by Hibernate
-- when you run the Spring Boot application with ddl-auto=update

-- However, if you want to create it manually, here's the schema:
/*
CREATE TABLE IF NOT EXISTS employees (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    department VARCHAR(255),
    salary DOUBLE NOT NULL,
    INDEX idx_department (department),
    INDEX idx_email (email)
);
*/

-- Sample data for testing (run this AFTER starting the application)
-- Uncomment the lines below if you want to insert sample data via SQL

/*
INSERT INTO employees (first_name, last_name, email, department, salary) VALUES
('John', 'Doe', 'john.doe@example.com', 'IT', 75000.00),
('Jane', 'Smith', 'jane.smith@example.com', 'HR', 65000.00),
('Mike', 'Johnson', 'mike.johnson@example.com', 'IT', 70000.00),
('Sarah', 'Williams', 'sarah.williams@example.com', 'Finance', 80000.00),
('Robert', 'Brown', 'robert.brown@example.com', 'Sales', 60000.00),
('Emily', 'Davis', 'emily.davis@example.com', 'Marketing', 68000.00),
('David', 'Miller', 'david.miller@example.com', 'IT', 85000.00),
('Lisa', 'Wilson', 'lisa.wilson@example.com', 'HR', 62000.00),
('James', 'Moore', 'james.moore@example.com', 'Engineering', 95000.00),
('Jennifer', 'Taylor', 'jennifer.taylor@example.com', 'Finance', 82000.00);
*/

-- Queries to verify data
-- SELECT * FROM employees;
-- SELECT * FROM employees WHERE department = 'IT';
-- SELECT COUNT(*) FROM employees;
-- SELECT department, COUNT(*) as employee_count FROM employees GROUP BY department;
-- SELECT department, AVG(salary) as avg_salary FROM employees GROUP BY department;

-- Clean up (use with caution - this will delete all data!)
-- DELETE FROM employees;
-- DROP TABLE employees;
-- DROP DATABASE employee_db;
