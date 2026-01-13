@echo off
echo ============================================
echo Employee Management API - Quick Run Script
echo ============================================
echo.
echo This script will run your Spring Boot application
echo.
echo IMPORTANT: Make sure MySQL is running!
echo.

REM Check if we're in the right directory
if not exist "pom.xml" (
    echo ERROR: pom.xml not found. Please run this from the project root.
    pause
    exit /b 1
)

echo Starting application...
echo.
echo The application will be available at: http://localhost:8080
echo API endpoint: http://localhost:8080/api/employees
echo.
echo Press Ctrl+C to stop the application
echo.
echo ============================================
echo.

REM Try to run with Maven
mvn spring-boot:run

REM If Maven fails, show error message
if %errorlevel% neq 0 (
    echo.
    echo ============================================
    echo ERROR: Could not run with Maven
    echo.
    echo Please try running from VS Code instead:
    echo 1. Open: src/main/java/com/example/employeemanagement/EmployeeManagementApplication.java
    echo 2. Click "Run" above the main method
    echo ============================================
    pause
)