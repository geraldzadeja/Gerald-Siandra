# Quick Start Guide - Employee Management API

## Step-by-Step Setup Instructions

### 1. Prerequisites Check

Make sure you have installed:
- Java JDK 17 or higher
- Maven 3.6+
- MySQL 8.0+
- Postman (or any REST client)

Verify installations:
```bash
java -version
mvn -version
mysql --version
```

### 2. MySQL Database Setup

#### Option A: Using MySQL Workbench
1. Open MySQL Workbench
2. Connect to your local MySQL server
3. The database will be created automatically when you run the application

#### Option B: Using MySQL Command Line
```bash
mysql -u root -p
```

Then create the database (optional, as the app will create it automatically):
```sql
CREATE DATABASE employee_db;
EXIT;
```

### 3. Configure Database Connection

1. Navigate to the project folder:
```bash
cd employee-management-api
```

2. Open `src/main/resources/application.properties`

3. Update the MySQL password (line 5):
```properties
spring.datasource.password=YOUR_MYSQL_PASSWORD
```

Replace `YOUR_MYSQL_PASSWORD` with your actual MySQL root password.

### 4. Build and Run the Application

#### Using Maven:
```bash
mvn clean install
mvn spring-boot:run
```

#### Alternative - Using the JAR file:
```bash
mvn clean package
java -jar target/employee-management-api-1.0.0.jar
```

### 5. Verify Application Started

You should see output similar to:
```
Started EmployeeManagementApplication in X.XXX seconds
```

The API is now running on: `http://localhost:8080`

### 6. Test the API

#### Quick Test Using Browser:
Open browser and navigate to:
```
http://localhost:8080/api/employees
```

You should see an empty JSON array: `[]`

#### Using Postman:

1. **Import Collection:**
   - Open Postman
   - Click "Import"
   - Select `Employee-Management-API.postman_collection.json`

2. **Test Sequence:**

   a. **Create First Employee:**
   - Select "Create Employee" request
   - Click "Send"
   - Verify: HTTP 201 Created

   b. **Get All Employees:**
   - Select "Get All Employees" request
   - Click "Send"
   - Verify: HTTP 200 OK with employee list

   c. **Get Employee by ID:**
   - Select "Get Employee by ID" request
   - Click "Send"
   - Verify: HTTP 200 OK with employee details

   d. **Update Employee:**
   - Select "Update Employee" request
   - Modify salary or department in body
   - Click "Send"
   - Verify: HTTP 200 OK with updated data

   e. **Delete Employee:**
   - Select "Delete Employee" request
   - Click "Send"
   - Verify: HTTP 204 No Content

#### Using cURL (Command Line):

**Create Employee:**
```bash
curl -X POST http://localhost:8080/api/employees \
  -H "Content-Type: application/json" \
  -d "{\"firstName\":\"John\",\"lastName\":\"Doe\",\"email\":\"john.doe@example.com\",\"department\":\"IT\",\"salary\":75000.00}"
```

**Get All Employees:**
```bash
curl http://localhost:8080/api/employees
```

**Get Employee by ID:**
```bash
curl http://localhost:8080/api/employees/1
```

**Update Employee:**
```bash
curl -X PUT http://localhost:8080/api/employees/1 \
  -H "Content-Type: application/json" \
  -d "{\"firstName\":\"John\",\"lastName\":\"Doe\",\"email\":\"john.doe@example.com\",\"department\":\"Engineering\",\"salary\":85000.00}"
```

**Delete Employee:**
```bash
curl -X DELETE http://localhost:8080/api/employees/1
```

### 7. Common Test Scenarios

#### Test Validation Errors:
```bash
curl -X POST http://localhost:8080/api/employees \
  -H "Content-Type: application/json" \
  -d "{\"firstName\":\"\",\"lastName\":\"\",\"email\":\"invalid\",\"salary\":-1000}"
```
Expected: HTTP 400 Bad Request with validation errors

#### Test Duplicate Email:
1. Create an employee
2. Try to create another employee with the same email
Expected: HTTP 409 Conflict

#### Test Not Found:
```bash
curl http://localhost:8080/api/employees/999
```
Expected: HTTP 404 Not Found

### 8. View Database Records

Using MySQL Workbench or command line:
```sql
USE employee_db;
SELECT * FROM employees;
```

### 9. Stop the Application

Press `Ctrl + C` in the terminal where the application is running.

## Troubleshooting

### Issue: "Cannot connect to database"
**Solution:**
- Check MySQL is running: `sudo systemctl status mysql` (Linux) or check Services (Windows)
- Verify credentials in application.properties
- Check port 3306 is not blocked

### Issue: "Port 8080 already in use"
**Solution:**
- Change port in application.properties: `server.port=8081`
- Or stop the process using port 8080

### Issue: "Maven build fails"
**Solution:**
- Ensure Java 17 is installed and JAVA_HOME is set
- Clear Maven cache: `mvn clean`
- Delete `target` folder and rebuild

### Issue: "Table 'employees' doesn't exist"
**Solution:**
- Check `spring.jpa.hibernate.ddl-auto=update` in application.properties
- Restart the application to auto-create tables

## Next Steps

1. Test all CRUD endpoints using Postman
2. Take screenshots of each successful request/response
3. Document any errors encountered and their solutions
4. Experiment with different data and scenarios
5. Review the code to understand the architecture

## Project Structure Overview

```
Controller Layer → Service Layer → Repository Layer → Database
     ↓                  ↓                ↓
  REST API      Business Logic    Data Access (JPA)
```

## Important Files

- **Main Application:** `EmployeeManagementApplication.java`
- **Entity Model:** `Employee.java`
- **API Endpoints:** `EmployeeController.java`
- **Business Logic:** `EmployeeService.java`
- **Database Access:** `EmployeeRepository.java`
- **Error Handling:** `GlobalExceptionHandler.java`
- **Configuration:** `application.properties`

## Support

For detailed API documentation, see [README.md](README.md)
