@echo off
REM Employee Management API - Setup and Run Script
REM This script helps you set up and run the Spring Boot application

echo ===============================================
echo Employee Management API - Setup Script
echo ===============================================
echo.

REM Check Java installation
echo [1/5] Checking Java installation...
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Java is not installed or not in PATH
    echo Please install Java 17 or higher
    pause
    exit /b 1
)
java -version
echo.

REM Check Maven installation
echo [2/5] Checking Maven installation...
mvn -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Maven is not installed or not in PATH
    echo Please install Maven 3.6 or higher
    pause
    exit /b 1
)
mvn -version
echo.

REM Check MySQL
echo [3/5] Checking MySQL...
echo Please ensure MySQL is running on localhost:3306
echo Press any key to continue if MySQL is ready...
pause >nul
echo.

REM Build project
echo [4/5] Building project with Maven...
call mvn clean install
if %errorlevel% neq 0 (
    echo ERROR: Maven build failed
    echo Please check the error messages above
    pause
    exit /b 1
)
echo Build successful!
echo.

REM Run application
echo [5/5] Starting Spring Boot application...
echo.
echo ===============================================
echo Application will start on: http://localhost:8080
echo API Base URL: http://localhost:8080/api/employees
echo.
echo To stop the application, press Ctrl+C
echo ===============================================
echo.
call mvn spring-boot:run

pause
