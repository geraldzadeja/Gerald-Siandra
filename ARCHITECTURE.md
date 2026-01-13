# Architecture Documentation - Employee Management API

## System Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────┐
│                          CLIENT LAYER                                │
│  (Postman, Browser, cURL, Mobile App, Web Frontend)                 │
└─────────────────────────────────┬───────────────────────────────────┘
                                  │
                                  │ HTTP Requests (JSON)
                                  │
┌─────────────────────────────────▼───────────────────────────────────┐
│                      CONTROLLER LAYER                                │
│  ┌────────────────────────────────────────────────────────────┐    │
│  │           EmployeeController.java                           │    │
│  │  @RestController                                            │    │
│  │  @RequestMapping("/api/employees")                          │    │
│  │                                                              │    │
│  │  • POST   /api/employees          → createEmployee()        │    │
│  │  • GET    /api/employees          → getAllEmployees()       │    │
│  │  • GET    /api/employees?dept=IT  → getAllEmployees(dept)   │    │
│  │  • GET    /api/employees/{id}     → getEmployeeById()       │    │
│  │  • PUT    /api/employees/{id}     → updateEmployee()        │    │
│  │  • DELETE /api/employees/{id}     → deleteEmployee()        │    │
│  │                                                              │    │
│  │  Responsibilities:                                           │    │
│  │  - Handle HTTP requests/responses                           │    │
│  │  - Validate input (@Valid)                                  │    │
│  │  - Return appropriate status codes                          │    │
│  └────────────────────────────────────────────────────────────┘    │
└─────────────────────────────────┬───────────────────────────────────┘
                                  │
                                  │ Method Calls
                                  │
┌─────────────────────────────────▼───────────────────────────────────┐
│                       SERVICE LAYER                                  │
│  ┌────────────────────────────────────────────────────────────┐    │
│  │              EmployeeService.java                           │    │
│  │  @Service                                                   │    │
│  │                                                              │    │
│  │  • createEmployee(employee)                                 │    │
│  │    → Check duplicate email                                  │    │
│  │    → Save employee                                          │    │
│  │                                                              │    │
│  │  • getAllEmployees()                                        │    │
│  │    → Retrieve all records                                   │    │
│  │                                                              │    │
│  │  • getEmployeesByDepartment(dept)                           │    │
│  │    → Filter by department                                   │    │
│  │                                                              │    │
│  │  • getEmployeeById(id)                                      │    │
│  │    → Find by ID or throw exception                          │    │
│  │                                                              │    │
│  │  • updateEmployee(id, details)                              │    │
│  │    → Find existing employee                                 │    │
│  │    → Check duplicate email if changed                       │    │
│  │    → Update and save                                        │    │
│  │                                                              │    │
│  │  • deleteEmployee(id)                                       │    │
│  │    → Find and delete                                        │    │
│  │                                                              │    │
│  │  Responsibilities:                                           │    │
│  │  - Business logic                                           │    │
│  │  - Data validation                                          │    │
│  │  - Transaction management                                   │    │
│  │  - Exception handling                                       │    │
│  └────────────────────────────────────────────────────────────┘    │
└─────────────────────────────────┬───────────────────────────────────┘
                                  │
                                  │ Repository Calls
                                  │
┌─────────────────────────────────▼───────────────────────────────────┐
│                     REPOSITORY LAYER                                 │
│  ┌────────────────────────────────────────────────────────────┐    │
│  │          EmployeeRepository.java                            │    │
│  │  @Repository                                                │    │
│  │  extends JpaRepository<Employee, Long>                      │    │
│  │                                                              │    │
│  │  Provided by Spring Data JPA:                               │    │
│  │  • save(employee)                                           │    │
│  │  • findAll()                                                │    │
│  │  • findById(id)                                             │    │
│  │  • delete(employee)                                         │    │
│  │                                                              │    │
│  │  Custom Query Methods:                                      │    │
│  │  • findByDepartment(department)                             │    │
│  │  • findByEmail(email)                                       │    │
│  │                                                              │    │
│  │  Responsibilities:                                           │    │
│  │  - Database operations (CRUD)                               │    │
│  │  - Query generation                                         │    │
│  │  - Data persistence                                         │    │
│  └────────────────────────────────────────────────────────────┘    │
└─────────────────────────────────┬───────────────────────────────────┘
                                  │
                                  │ JPA/Hibernate
                                  │
┌─────────────────────────────────▼───────────────────────────────────┐
│                       ENTITY LAYER                                   │
│  ┌────────────────────────────────────────────────────────────┐    │
│  │                 Employee.java                               │    │
│  │  @Entity                                                    │    │
│  │  @Table(name = "employees")                                 │    │
│  │                                                              │    │
│  │  Fields:                                                    │    │
│  │  • Long id                    @Id @GeneratedValue           │    │
│  │  • String firstName           @NotBlank                     │    │
│  │  • String lastName            @NotBlank                     │    │
│  │  • String email               @NotBlank @Email @Unique      │    │
│  │  • String department          (optional)                    │    │
│  │  • Double salary              @NotNull @Min(0)              │    │
│  │                                                              │    │
│  │  Responsibilities:                                           │    │
│  │  - Data model definition                                    │    │
│  │  - Validation rules                                         │    │
│  │  - Database mapping                                         │    │
│  └────────────────────────────────────────────────────────────┘    │
└─────────────────────────────────┬───────────────────────────────────┘
                                  │
                                  │ SQL Queries
                                  │
┌─────────────────────────────────▼───────────────────────────────────┐
│                       DATABASE LAYER                                 │
│  ┌────────────────────────────────────────────────────────────┐    │
│  │                    MySQL Database                           │    │
│  │                    (employee_db)                            │    │
│  │                                                              │    │
│  │  Table: employees                                           │    │
│  │  ┌─────────────┬──────────────┬────────────┬──────────┐   │    │
│  │  │ Column      │ Type         │ Constraint │ Example  │   │    │
│  │  ├─────────────┼──────────────┼────────────┼──────────┤   │    │
│  │  │ id          │ BIGINT       │ PK, AUTO   │ 1        │   │    │
│  │  │ first_name  │ VARCHAR(255) │ NOT NULL   │ John     │   │    │
│  │  │ last_name   │ VARCHAR(255) │ NOT NULL   │ Doe      │   │    │
│  │  │ email       │ VARCHAR(255) │ UNIQUE, NN │ j@ex.com │   │    │
│  │  │ department  │ VARCHAR(255) │ NULL       │ IT       │   │    │
│  │  │ salary      │ DOUBLE       │ NOT NULL   │ 75000.00 │   │    │
│  │  └─────────────┴──────────────┴────────────┴──────────┘   │    │
│  │                                                              │    │
│  │  Responsibilities:                                           │    │
│  │  - Data storage                                             │    │
│  │  - Data integrity                                           │    │
│  │  - Unique constraints                                       │    │
│  └────────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────────┘
```

## Exception Handling Flow

```
┌─────────────────────────────────────────────────────────────────────┐
│                    EXCEPTION HANDLING                                │
│                                                                       │
│  ┌────────────────────────────────────────────────────────────┐    │
│  │        GlobalExceptionHandler.java                          │    │
│  │  @RestControllerAdvice                                      │    │
│  │                                                              │    │
│  │  Exception Handlers:                                        │    │
│  │                                                              │    │
│  │  1. ResourceNotFoundException                               │    │
│  │     → HTTP 404 Not Found                                    │    │
│  │     → Employee not found error response                     │    │
│  │                                                              │    │
│  │  2. DuplicateResourceException                              │    │
│  │     → HTTP 409 Conflict                                     │    │
│  │     → Duplicate email error response                        │    │
│  │                                                              │    │
│  │  3. MethodArgumentNotValidException                         │    │
│  │     → HTTP 400 Bad Request                                  │    │
│  │     → Validation errors list                                │    │
│  │                                                              │    │
│  │  4. Exception (catch-all)                                   │    │
│  │     → HTTP 500 Internal Server Error                        │    │
│  │     → Generic error response                                │    │
│  │                                                              │    │
│  │  Error Response Format:                                     │    │
│  │  {                                                           │    │
│  │    "timestamp": "2026-01-13T10:30:00",                      │    │
│  │    "status": 404,                                           │    │
│  │    "error": "Not Found",                                    │    │
│  │    "message": "Employee not found with id : '1'",           │    │
│  │    "path": "/api/employees/1",                              │    │
│  │    "details": [ ... ]  // optional                          │    │
│  │  }                                                           │    │
│  └────────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────────┘
```

## Request/Response Flow

### Example: Create Employee

```
1. CLIENT sends POST request:
   ┌─────────────────────────────────────┐
   │ POST /api/employees                 │
   │ Content-Type: application/json      │
   │                                     │
   │ {                                   │
   │   "firstName": "John",              │
   │   "lastName": "Doe",                │
   │   "email": "john@example.com",      │
   │   "department": "IT",               │
   │   "salary": 75000.00                │
   │ }                                   │
   └─────────────────────────────────────┘
                    ↓
2. CONTROLLER receives and validates:
   - @Valid triggers validation
   - Calls service.createEmployee()
                    ↓
3. SERVICE processes:
   - Checks if email exists
   - If duplicate → throw DuplicateResourceException
   - If valid → calls repository.save()
                    ↓
4. REPOSITORY persists:
   - JPA generates SQL INSERT
   - Executes against MySQL
   - Returns saved entity with ID
                    ↓
5. SERVICE returns:
   - Employee object with generated ID
                    ↓
6. CONTROLLER responds:
   - Sets HTTP 201 Created
   - Returns JSON response
                    ↓
7. CLIENT receives response:
   ┌─────────────────────────────────────┐
   │ HTTP/1.1 201 Created                │
   │ Content-Type: application/json      │
   │                                     │
   │ {                                   │
   │   "id": 1,                          │
   │   "firstName": "John",              │
   │   "lastName": "Doe",                │
   │   "email": "john@example.com",      │
   │   "department": "IT",               │
   │   "salary": 75000.00                │
   │ }                                   │
   └─────────────────────────────────────┘
```

## Validation Flow

```
┌─────────────────────────────────────────────────────────────────────┐
│                      VALIDATION FLOW                                 │
│                                                                       │
│  Client Request                                                      │
│       ↓                                                              │
│  @Valid annotation in Controller                                    │
│       ↓                                                              │
│  Jakarta Validation checks:                                         │
│       ↓                                                              │
│  ┌──────────────────────────────────────────────────────┐          │
│  │ Field Validations:                                    │          │
│  │                                                        │          │
│  │ firstName:                                            │          │
│  │   @NotBlank → "First name is required"               │          │
│  │                                                        │          │
│  │ lastName:                                             │          │
│  │   @NotBlank → "Last name is required"                │          │
│  │                                                        │          │
│  │ email:                                                │          │
│  │   @NotBlank → "Email is required"                    │          │
│  │   @Email    → "Email should be valid"                │          │
│  │                                                        │          │
│  │ salary:                                               │          │
│  │   @NotNull → "Salary is required"                    │          │
│  │   @Min(0)  → "Salary must be non-negative"           │          │
│  └──────────────────────────────────────────────────────┘          │
│       ↓                                                              │
│  If validation fails:                                               │
│       → MethodArgumentNotValidException                             │
│       → GlobalExceptionHandler catches                              │
│       → Returns HTTP 400 with error details                         │
│       ↓                                                              │
│  If validation passes:                                              │
│       → Proceed to Service layer                                    │
│       → Business logic validation (duplicate email)                 │
│       → Database operation                                          │
└─────────────────────────────────────────────────────────────────────┘
```

## Component Dependencies

```
┌─────────────────────────────────────────────────────────────────────┐
│                    DEPENDENCY INJECTION                              │
│                                                                       │
│  Spring Boot Application                                            │
│         │                                                            │
│         ├─→ @SpringBootApplication                                  │
│         │   ComponentScan, AutoConfiguration                        │
│         │                                                            │
│         ├─→ EmployeeController                                      │
│         │   └─→ @Autowired EmployeeService                          │
│         │                                                            │
│         ├─→ EmployeeService                                         │
│         │   └─→ @Autowired EmployeeRepository                       │
│         │                                                            │
│         ├─→ EmployeeRepository (Spring Data JPA)                    │
│         │   └─→ Auto-implemented by Spring                          │
│         │                                                            │
│         └─→ GlobalExceptionHandler                                  │
│             └─→ Handles all controller exceptions                   │
│                                                                       │
│  Dependency Injection Benefits:                                     │
│  • Loose coupling                                                   │
│  • Easy testing                                                     │
│  • Maintainability                                                  │
│  • Inversion of Control                                             │
└─────────────────────────────────────────────────────────────────────┘
```

## Data Flow Patterns

### Pattern 1: Successful Operation
```
Client → Controller → Service → Repository → Database
                                              ↓
Client ← Controller ← Service ← Repository ← Success
```

### Pattern 2: Validation Error
```
Client → Controller → @Valid → Validation Fails
                                     ↓
Client ← Error Response ← GlobalExceptionHandler
```

### Pattern 3: Business Logic Error
```
Client → Controller → Service → Business Rule Violation
                                (duplicate email, not found)
                                         ↓
Client ← Error Response ← Exception ← Service
```

### Pattern 4: Database Error
```
Client → Controller → Service → Repository → Database Error
                                                    ↓
Client ← Error Response ← GlobalExceptionHandler ← Exception
```

## Technology Stack Details

```
┌─────────────────────────────────────────────────────────────────────┐
│                    TECHNOLOGY LAYERS                                 │
│                                                                       │
│  ┌────────────────────────────────────────────────────────────┐    │
│  │ Presentation Layer:                                         │    │
│  │ • Spring Web MVC                                            │    │
│  │ • Jackson (JSON serialization)                              │    │
│  │ • Jakarta Validation                                        │    │
│  └────────────────────────────────────────────────────────────┘    │
│                           ↓                                          │
│  ┌────────────────────────────────────────────────────────────┐    │
│  │ Business Layer:                                             │    │
│  │ • Spring Core (IoC, DI)                                     │    │
│  │ • Spring Context                                            │    │
│  │ • Custom Services                                           │    │
│  └────────────────────────────────────────────────────────────┘    │
│                           ↓                                          │
│  ┌────────────────────────────────────────────────────────────┐    │
│  │ Persistence Layer:                                          │    │
│  │ • Spring Data JPA                                           │    │
│  │ • Hibernate ORM                                             │    │
│  │ • JDBC                                                      │    │
│  └────────────────────────────────────────────────────────────┘    │
│                           ↓                                          │
│  ┌────────────────────────────────────────────────────────────┐    │
│  │ Database Layer:                                             │    │
│  │ • MySQL 8.0+                                                │    │
│  │ • MySQL Connector/J                                         │    │
│  └────────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────────┘
```

## Configuration Flow

```
┌─────────────────────────────────────────────────────────────────────┐
│              APPLICATION CONFIGURATION                               │
│                                                                       │
│  application.properties                                             │
│         │                                                            │
│         ├─→ Server Configuration                                    │
│         │   • server.port=8080                                      │
│         │                                                            │
│         ├─→ Database Configuration                                  │
│         │   • spring.datasource.url                                 │
│         │   • spring.datasource.username                            │
│         │   • spring.datasource.password                            │
│         │   • spring.datasource.driver-class-name                   │
│         │                                                            │
│         ├─→ JPA Configuration                                       │
│         │   • spring.jpa.hibernate.ddl-auto=update                  │
│         │   • spring.jpa.show-sql=true                              │
│         │   • spring.jpa.properties.hibernate.dialect               │
│         │                                                            │
│         └─→ Error Handling Configuration                            │
│             • server.error.include-message=always                   │
│             • server.error.include-binding-errors=always            │
│                                                                       │
│  Spring Boot Auto-Configuration:                                    │
│  • Scans @SpringBootApplication package                             │
│  • Detects Spring Web → Configures Tomcat                           │
│  • Detects Spring Data JPA → Configures Hibernate                   │
│  • Detects MySQL driver → Configures DataSource                     │
└─────────────────────────────────────────────────────────────────────┘
```

---

## Architecture Benefits

### Separation of Concerns
- Each layer has a specific responsibility
- Changes in one layer don't affect others
- Easy to maintain and extend

### Scalability
- Can add more controllers for different resources
- Can add caching in service layer
- Can switch database without changing business logic

### Testability
- Each layer can be tested independently
- Easy to mock dependencies
- Clear boundaries for unit tests

### Maintainability
- Clear code organization
- Easy to locate and fix bugs
- Consistent patterns throughout

---

This architecture follows industry-standard best practices for building RESTful APIs with Spring Boot.
