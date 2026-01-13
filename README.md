# Employee Management API

A RESTful CRUD API for managing company employees, built with Spring Boot 3.x, Spring Data JPA, and MySQL.

## Task Information

**Chosen Task:** Task C – Employee Management API

This project implements a complete RESTful API for employee management with full CRUD operations, input validation, error handling, and MySQL database integration.

## Features

- Complete CRUD operations for Employee entities
- Input validation for all fields
- Custom error handling with meaningful error messages
- Department-based filtering
- Duplicate email detection
- MySQL database integration with JPA/Hibernate
- RESTful API design with proper HTTP status codes

## Technologies Used

- Java 17
- Spring Boot 3.2.1
- Spring Web
- Spring Data JPA
- MySQL 8.0+
- Maven
- Jakarta Validation

## Project Structure

```
employee-management-api/
├── src/
│   ├── main/
│   │   ├── java/com/example/employeemanagement/
│   │   │   ├── controller/
│   │   │   │   └── EmployeeController.java
│   │   │   ├── entity/
│   │   │   │   └── Employee.java
│   │   │   ├── exception/
│   │   │   │   ├── DuplicateResourceException.java
│   │   │   │   ├── ErrorResponse.java
│   │   │   │   ├── GlobalExceptionHandler.java
│   │   │   │   └── ResourceNotFoundException.java
│   │   │   ├── repository/
│   │   │   │   └── EmployeeRepository.java
│   │   │   ├── service/
│   │   │   │   └── EmployeeService.java
│   │   │   └── EmployeeManagementApplication.java
│   │   └── resources/
│   │       └── application.properties
│   └── test/
└── pom.xml
```

## Prerequisites

- JDK 17 or higher
- Maven 3.6+
- MySQL 8.0+
- Postman or similar tool for API testing

## Database Configuration

### Step 1: Install MySQL

Make sure MySQL Server is installed and running on your machine.

### Step 2: Create Database (Optional)

The application will automatically create the database if it doesn't exist. However, you can manually create it:

```sql
CREATE DATABASE employee_db;
```

### Step 3: Configure Database Connection

Open `src/main/resources/application.properties` and update the following properties:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/employee_db?createDatabaseIfNotExist=true&useSSL=false&serverTimezone=UTC
spring.datasource.username=root
spring.datasource.password=your_password_here
```

Replace `your_password_here` with your MySQL root password.

**Important Configuration Notes:**
- Database name: `employee_db`
- Default username: `root`
- Password: Update with your MySQL password
- Port: 3306 (default MySQL port)
- The `createDatabaseIfNotExist=true` parameter will automatically create the database if it doesn't exist

## Building and Running the Application

### Using Maven Command Line

1. Navigate to the project directory:
```bash
cd employee-management-api
```

2. Build the project:
```bash
mvn clean install
```

3. Run the application:
```bash
mvn spring-boot:run
```

### Using Java Command

```bash
mvn clean package
java -jar target/employee-management-api-1.0.0.jar
```

The application will start on `http://localhost:8080`

## API Endpoints

### Base URL
```
http://localhost:8080/api/employees
```

### 1. Create Employee

**Endpoint:** `POST /api/employees`

**Request Body:**
```json
{
  "firstName": "John",
  "lastName": "Doe",
  "email": "john.doe@example.com",
  "department": "IT",
  "salary": 75000.00
}
```

**Response:** HTTP 201 Created
```json
{
  "id": 1,
  "firstName": "John",
  "lastName": "Doe",
  "email": "john.doe@example.com",
  "department": "IT",
  "salary": 75000.00
}
```

### 2. Get All Employees

**Endpoint:** `GET /api/employees`

**Response:** HTTP 200 OK
```json
[
  {
    "id": 1,
    "firstName": "John",
    "lastName": "Doe",
    "email": "john.doe@example.com",
    "department": "IT",
    "salary": 75000.00
  },
  {
    "id": 2,
    "firstName": "Jane",
    "lastName": "Smith",
    "email": "jane.smith@example.com",
    "department": "HR",
    "salary": 65000.00
  }
]
```

### 3. Get Employees by Department (Filter)

**Endpoint:** `GET /api/employees?department=IT`

**Response:** HTTP 200 OK
```json
[
  {
    "id": 1,
    "firstName": "John",
    "lastName": "Doe",
    "email": "john.doe@example.com",
    "department": "IT",
    "salary": 75000.00
  }
]
```

### 4. Get Employee by ID

**Endpoint:** `GET /api/employees/1`

**Response:** HTTP 200 OK
```json
{
  "id": 1,
  "firstName": "John",
  "lastName": "Doe",
  "email": "john.doe@example.com",
  "department": "IT",
  "salary": 75000.00
}
```

**Error Response (Not Found):** HTTP 404 Not Found
```json
{
  "timestamp": "2026-01-13T10:30:00",
  "status": 404,
  "error": "Not Found",
  "message": "Employee not found with id : '999'",
  "path": "/api/employees/999"
}
```

### 5. Update Employee

**Endpoint:** `PUT /api/employees/1`

**Request Body:**
```json
{
  "firstName": "John",
  "lastName": "Doe",
  "email": "john.doe@example.com",
  "department": "Engineering",
  "salary": 85000.00
}
```

**Response:** HTTP 200 OK
```json
{
  "id": 1,
  "firstName": "John",
  "lastName": "Doe",
  "email": "john.doe@example.com",
  "department": "Engineering",
  "salary": 85000.00
}
```

### 6. Delete Employee

**Endpoint:** `DELETE /api/employees/1`

**Response:** HTTP 204 No Content

## Validation Rules

The API enforces the following validation rules:

- `firstName`: Required, cannot be blank
- `lastName`: Required, cannot be blank
- `email`: Required, cannot be blank, must be valid email format, must be unique
- `department`: Optional
- `salary`: Required, must be non-negative (>= 0)

### Validation Error Response

**Example:** HTTP 400 Bad Request
```json
{
  "timestamp": "2026-01-13T10:30:00",
  "status": 400,
  "error": "Bad Request",
  "message": "Validation failed",
  "path": "/api/employees",
  "details": [
    "firstName: First name is required",
    "email: Email should be valid",
    "salary: Salary must be non-negative"
  ]
}
```

### Duplicate Email Error Response

**Example:** HTTP 409 Conflict
```json
{
  "timestamp": "2026-01-13T10:30:00",
  "status": 409,
  "error": "Conflict",
  "message": "Employee already exists with email : 'john.doe@example.com'",
  "path": "/api/employees"
}
```

## Testing with Postman

### Quick Test Sequence

1. **Create Employee:**
   - Method: POST
   - URL: `http://localhost:8080/api/employees`
   - Headers: `Content-Type: application/json`
   - Body: Raw JSON (see example above)

2. **Get All Employees:**
   - Method: GET
   - URL: `http://localhost:8080/api/employees`

3. **Get Employee by ID:**
   - Method: GET
   - URL: `http://localhost:8080/api/employees/1`

4. **Filter by Department:**
   - Method: GET
   - URL: `http://localhost:8080/api/employees?department=IT`

5. **Update Employee:**
   - Method: PUT
   - URL: `http://localhost:8080/api/employees/1`
   - Headers: `Content-Type: application/json`
   - Body: Raw JSON with updated fields

6. **Delete Employee:**
   - Method: DELETE
   - URL: `http://localhost:8080/api/employees/1`

### Error Testing Scenarios

1. **Test 404 Error:** GET request to non-existent ID
   - URL: `http://localhost:8080/api/employees/999`

2. **Test Validation Error:** POST request with invalid data
   - Empty firstName, invalid email, negative salary

3. **Test Duplicate Email:** POST request with existing email

## Database Schema

The application automatically creates the following table:

```sql
CREATE TABLE employees (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    department VARCHAR(255),
    salary DOUBLE NOT NULL
);
```

## API Disclaimer

**AI Usage Declaration:**

This project was developed with the assistance of Claude Code (Claude Sonnet 4.5) as part of a Spring Boot learning exercise. The AI was used for:

1. **Code Generation:** Complete implementation of the Employee Management API including entities, repositories, services, controllers, and exception handling
2. **Project Structure:** Setting up Maven configuration and proper package organization following Spring Boot best practices
3. **Documentation:** Creating comprehensive README with API examples and setup instructions
4. **Best Practices:** Implementing proper validation, error handling, and RESTful design patterns

The student reviewed, understood, and tested all generated code to ensure functionality and compliance with project requirements.

## Troubleshooting

### Common Issues

1. **Database Connection Error:**
   - Verify MySQL is running
   - Check username and password in application.properties
   - Ensure port 3306 is not blocked

2. **Port 8080 Already in Use:**
   - Change port in application.properties: `server.port=8081`

3. **Maven Build Failure:**
   - Ensure Java 17 is installed: `java -version`
   - Clear Maven cache: `mvn clean`

## Author

Student Project - Spring Boot RESTful CRUD with MySQL
Course: Java Programming Project Work n. 2

## License

This project is created for educational purposes as part of a university assignment.
