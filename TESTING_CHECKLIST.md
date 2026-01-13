# Testing Checklist for Employee Management API

Use this checklist to ensure all endpoints and scenarios are tested properly. Take screenshots of each test for your documentation.

## Prerequisites
- [ ] Application is running on http://localhost:8080
- [ ] MySQL database is connected
- [ ] Postman is installed and collection is imported

---

## Test 1: Create Employee (Success Scenario)

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

**Expected Result:**
- [ ] HTTP Status Code: 201 Created
- [ ] Response includes all fields with generated ID
- [ ] Response matches request data

**Screenshot:** Save as `01_create_employee_success.png`

---

## Test 2: Create Additional Employees

Create at least 3 more employees with different departments:

**Employee 2:**
```json
{
  "firstName": "Jane",
  "lastName": "Smith",
  "email": "jane.smith@example.com",
  "department": "HR",
  "salary": 65000.00
}
```

**Employee 3:**
```json
{
  "firstName": "Mike",
  "lastName": "Johnson",
  "email": "mike.johnson@example.com",
  "department": "IT",
  "salary": 70000.00
}
```

**Employee 4:**
```json
{
  "firstName": "Sarah",
  "lastName": "Williams",
  "email": "sarah.williams@example.com",
  "department": "Finance",
  "salary": 80000.00
}
```

**Expected Result:**
- [ ] All employees created successfully with HTTP 201
- [ ] Each has unique ID

**Screenshot:** Save as `02_create_multiple_employees.png`

---

## Test 3: Get All Employees

**Endpoint:** `GET /api/employees`

**Expected Result:**
- [ ] HTTP Status Code: 200 OK
- [ ] Response contains array of all employees
- [ ] Array has 4 elements

**Screenshot:** Save as `03_get_all_employees.png`

---

## Test 4: Get Employee by ID

**Endpoint:** `GET /api/employees/1`

**Expected Result:**
- [ ] HTTP Status Code: 200 OK
- [ ] Response contains employee with ID 1
- [ ] All fields are correct

**Screenshot:** Save as `04_get_employee_by_id.png`

---

## Test 5: Filter by Department

**Endpoint:** `GET /api/employees?department=IT`

**Expected Result:**
- [ ] HTTP Status Code: 200 OK
- [ ] Response contains only IT department employees
- [ ] Should return 2 employees (John and Mike)

**Screenshot:** Save as `05_filter_by_department.png`

---

## Test 6: Update Employee

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

**Expected Result:**
- [ ] HTTP Status Code: 200 OK
- [ ] Response shows updated department and salary
- [ ] ID remains the same

**Screenshot:** Save as `06_update_employee_success.png`

---

## Test 7: Delete Employee

**Endpoint:** `DELETE /api/employees/4`

**Expected Result:**
- [ ] HTTP Status Code: 204 No Content
- [ ] No response body

**Verify Deletion:**
- [ ] GET /api/employees returns 3 employees
- [ ] GET /api/employees/4 returns 404 error

**Screenshot:** Save as `07_delete_employee_success.png`

---

## Test 8: Error - Employee Not Found (404)

**Endpoint:** `GET /api/employees/999`

**Expected Result:**
- [ ] HTTP Status Code: 404 Not Found
- [ ] Response body contains error details:
  ```json
  {
    "timestamp": "...",
    "status": 404,
    "error": "Not Found",
    "message": "Employee not found with id : '999'",
    "path": "/api/employees/999"
  }
  ```

**Screenshot:** Save as `08_error_404_not_found.png`

---

## Test 9: Error - Validation Error (400)

**Endpoint:** `POST /api/employees`

**Request Body (Invalid):**
```json
{
  "firstName": "",
  "lastName": "",
  "email": "invalid-email",
  "department": "IT",
  "salary": -1000
}
```

**Expected Result:**
- [ ] HTTP Status Code: 400 Bad Request
- [ ] Response includes validation errors:
  - firstName: First name is required
  - lastName: Last name is required
  - email: Email should be valid
  - salary: Salary must be non-negative

**Screenshot:** Save as `09_error_400_validation.png`

---

## Test 10: Error - Duplicate Email (409)

**Endpoint:** `POST /api/employees`

**Request Body (Using existing email):**
```json
{
  "firstName": "Robert",
  "lastName": "Brown",
  "email": "john.doe@example.com",
  "department": "Sales",
  "salary": 60000.00
}
```

**Expected Result:**
- [ ] HTTP Status Code: 409 Conflict
- [ ] Response body contains error:
  ```json
  {
    "timestamp": "...",
    "status": 409,
    "error": "Conflict",
    "message": "Employee already exists with email : 'john.doe@example.com'",
    "path": "/api/employees"
  }
  ```

**Screenshot:** Save as `10_error_409_duplicate_email.png`

---

## Test 11: Error - Update Non-Existent Employee (404)

**Endpoint:** `PUT /api/employees/999`

**Request Body:**
```json
{
  "firstName": "Test",
  "lastName": "User",
  "email": "test@example.com",
  "department": "IT",
  "salary": 50000.00
}
```

**Expected Result:**
- [ ] HTTP Status Code: 404 Not Found
- [ ] Error message indicates employee not found

**Screenshot:** Save as `11_error_404_update_not_found.png`

---

## Test 12: Error - Delete Non-Existent Employee (404)

**Endpoint:** `DELETE /api/employees/999`

**Expected Result:**
- [ ] HTTP Status Code: 404 Not Found
- [ ] Error message indicates employee not found

**Screenshot:** Save as `12_error_404_delete_not_found.png`

---

## Test 13: Validation - Negative Salary

**Endpoint:** `POST /api/employees`

**Request Body:**
```json
{
  "firstName": "Test",
  "lastName": "User",
  "email": "test@example.com",
  "department": "IT",
  "salary": -5000
}
```

**Expected Result:**
- [ ] HTTP Status Code: 400 Bad Request
- [ ] Validation error: "salary: Salary must be non-negative"

**Screenshot:** Save as `13_validation_negative_salary.png`

---

## Test 14: Validation - Invalid Email Format

**Endpoint:** `POST /api/employees`

**Request Body:**
```json
{
  "firstName": "Test",
  "lastName": "User",
  "email": "notanemail",
  "department": "IT",
  "salary": 50000
}
```

**Expected Result:**
- [ ] HTTP Status Code: 400 Bad Request
- [ ] Validation error: "email: Email should be valid"

**Screenshot:** Save as `14_validation_invalid_email.png`

---

## Test 15: Database Verification

**Using MySQL Workbench or command line:**

```sql
USE employee_db;
SELECT * FROM employees;
```

**Expected Result:**
- [ ] Table exists
- [ ] Records match the created employees
- [ ] Email column has unique constraint

**Screenshot:** Save as `15_database_verification.png`

---

## Summary

After completing all tests:

- [ ] All 15 tests completed
- [ ] All screenshots captured and named correctly
- [ ] All expected HTTP status codes verified
- [ ] Error responses contain proper JSON format
- [ ] Validation rules enforced correctly
- [ ] Database records verified

## Notes for Documentation

When creating your Word/ODT document:

1. **For each test, include:**
   - Test name and number
   - API endpoint and HTTP method
   - Request body (if applicable)
   - Response screenshot
   - HTTP status code
   - Brief description of what was tested

2. **Organize tests by category:**
   - Success scenarios (Tests 1-7)
   - Error handling (Tests 8-12)
   - Validation (Tests 13-14)
   - Database verification (Test 15)

3. **Add a summary section:**
   - Total tests performed
   - All success/failure results
   - Any observations or issues encountered

## Optional Additional Tests

- [ ] Create employee with zero salary (should succeed)
- [ ] Create employee without department (should succeed, department is optional)
- [ ] Filter by non-existent department (should return empty array)
- [ ] Update employee email to duplicate (should return 409)
- [ ] Create 10+ employees and verify pagination (if implemented)

---

**Good luck with your testing!**
