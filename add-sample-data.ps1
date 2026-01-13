# PowerShell Script to Add Sample Employees
# Make sure your Spring Boot application is running!

$baseUrl = "http://localhost:8080/api/employees"

Write-Host "Adding sample employees to the database..." -ForegroundColor Green
Write-Host ""

# Employee 1
$employee1 = @{
    firstName = "John"
    lastName = "Doe"
    email = "john.doe@example.com"
    department = "IT"
    salary = 75000.00
} | ConvertTo-Json

Write-Host "Adding John Doe..." -ForegroundColor Yellow
Invoke-RestMethod -Uri $baseUrl -Method POST -Body $employee1 -ContentType "application/json"
Write-Host "✓ John Doe added!" -ForegroundColor Green
Write-Host ""

# Employee 2
$employee2 = @{
    firstName = "Jane"
    lastName = "Smith"
    email = "jane.smith@example.com"
    department = "HR"
    salary = 65000.00
} | ConvertTo-Json

Write-Host "Adding Jane Smith..." -ForegroundColor Yellow
Invoke-RestMethod -Uri $baseUrl -Method POST -Body $employee2 -ContentType "application/json"
Write-Host "✓ Jane Smith added!" -ForegroundColor Green
Write-Host ""

# Employee 3
$employee3 = @{
    firstName = "Mike"
    lastName = "Johnson"
    email = "mike.johnson@example.com"
    department = "IT"
    salary = 70000.00
} | ConvertTo-Json

Write-Host "Adding Mike Johnson..." -ForegroundColor Yellow
Invoke-RestMethod -Uri $baseUrl -Method POST -Body $employee3 -ContentType "application/json"
Write-Host "✓ Mike Johnson added!" -ForegroundColor Green
Write-Host ""

# Employee 4
$employee4 = @{
    firstName = "Sarah"
    lastName = "Williams"
    email = "sarah.williams@example.com"
    department = "Finance"
    salary = 80000.00
} | ConvertTo-Json

Write-Host "Adding Sarah Williams..." -ForegroundColor Yellow
Invoke-RestMethod -Uri $baseUrl -Method POST -Body $employee4 -ContentType "application/json"
Write-Host "✓ Sarah Williams added!" -ForegroundColor Green
Write-Host ""

# Employee 5
$employee5 = @{
    firstName = "Robert"
    lastName = "Brown"
    email = "robert.brown@example.com"
    department = "Sales"
    salary = 60000.00
} | ConvertTo-Json

Write-Host "Adding Robert Brown..." -ForegroundColor Yellow
Invoke-RestMethod -Uri $baseUrl -Method POST -Body $employee5 -ContentType "application/json"
Write-Host "✓ Robert Brown added!" -ForegroundColor Green
Write-Host ""

# Employee 6
$employee6 = @{
    firstName = "Emily"
    lastName = "Davis"
    email = "emily.davis@example.com"
    department = "Marketing"
    salary = 68000.00
} | ConvertTo-Json

Write-Host "Adding Emily Davis..." -ForegroundColor Yellow
Invoke-RestMethod -Uri $baseUrl -Method POST -Body $employee6 -ContentType "application/json"
Write-Host "✓ Emily Davis added!" -ForegroundColor Green
Write-Host ""

# Employee 7
$employee7 = @{
    firstName = "David"
    lastName = "Miller"
    email = "david.miller@example.com"
    department = "IT"
    salary = 85000.00
} | ConvertTo-Json

Write-Host "Adding David Miller..." -ForegroundColor Yellow
Invoke-RestMethod -Uri $baseUrl -Method POST -Body $employee7 -ContentType "application/json"
Write-Host "✓ David Miller added!" -ForegroundColor Green
Write-Host ""

# Employee 8
$employee8 = @{
    firstName = "Lisa"
    lastName = "Wilson"
    email = "lisa.wilson@example.com"
    department = "HR"
    salary = 62000.00
} | ConvertTo-Json

Write-Host "Adding Lisa Wilson..." -ForegroundColor Yellow
Invoke-RestMethod -Uri $baseUrl -Method POST -Body $employee8 -ContentType "application/json"
Write-Host "✓ Lisa Wilson added!" -ForegroundColor Green
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "All sample employees added successfully!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "View all employees at: http://localhost:8080/api/employees" -ForegroundColor Yellow