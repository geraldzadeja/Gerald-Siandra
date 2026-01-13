# Script to add Albanian employees to the database
# Make sure your Spring Boot application is running!

$baseUrl = "http://localhost:8080/api/employees"

Write-Host "Adding Albanian employees to the database..." -ForegroundColor Green
Write-Host ""

# Employee 1
$employee1 = @{
    firstName = "Arben"
    lastName = "Hoxha"
    email = "arben.hoxha@zadejaberisha.com"
    department = "IT"
    salary = 75000.00
} | ConvertTo-Json

Write-Host "Adding Arben Hoxha..." -ForegroundColor Yellow
try {
    Invoke-RestMethod -Uri $baseUrl -Method POST -Body $employee1 -ContentType "application/json"
    Write-Host "✓ Arben Hoxha added!" -ForegroundColor Green
} catch {
    Write-Host "Already exists or error" -ForegroundColor Red
}
Write-Host ""

# Employee 2
$employee2 = @{
    firstName = "Teuta"
    lastName = "Berisha"
    email = "teuta.berisha@zadejaberisha.com"
    department = "HR"
    salary = 65000.00
} | ConvertTo-Json

Write-Host "Adding Teuta Berisha..." -ForegroundColor Yellow
try {
    Invoke-RestMethod -Uri $baseUrl -Method POST -Body $employee2 -ContentType "application/json"
    Write-Host "✓ Teuta Berisha added!" -ForegroundColor Green
} catch {
    Write-Host "Already exists or error" -ForegroundColor Red
}
Write-Host ""

# Employee 3
$employee3 = @{
    firstName = "Bekim"
    lastName = "Krasniqi"
    email = "bekim.krasniqi@zadejaberisha.com"
    department = "IT"
    salary = 70000.00
} | ConvertTo-Json

Write-Host "Adding Bekim Krasniqi..." -ForegroundColor Yellow
try {
    Invoke-RestMethod -Uri $baseUrl -Method POST -Body $employee3 -ContentType "application/json"
    Write-Host "✓ Bekim Krasniqi added!" -ForegroundColor Green
} catch {
    Write-Host "Already exists or error" -ForegroundColor Red
}
Write-Host ""

# Employee 4
$employee4 = @{
    firstName = "Fjolla"
    lastName = "Bytyqi"
    email = "fjolla.bytyqi@zadejaberisha.com"
    department = "Finance"
    salary = 80000.00
} | ConvertTo-Json

Write-Host "Adding Fjolla Bytyqi..." -ForegroundColor Yellow
try {
    Invoke-RestMethod -Uri $baseUrl -Method POST -Body $employee4 -ContentType "application/json"
    Write-Host "✓ Fjolla Bytyqi added!" -ForegroundColor Green
} catch {
    Write-Host "Already exists or error" -ForegroundColor Red
}
Write-Host ""

# Employee 5
$employee5 = @{
    firstName = "Alban"
    lastName = "Morina"
    email = "alban.morina@zadejaberisha.com"
    department = "Sales"
    salary = 60000.00
} | ConvertTo-Json

Write-Host "Adding Alban Morina..." -ForegroundColor Yellow
try {
    Invoke-RestMethod -Uri $baseUrl -Method POST -Body $employee5 -ContentType "application/json"
    Write-Host "✓ Alban Morina added!" -ForegroundColor Green
} catch {
    Write-Host "Already exists or error" -ForegroundColor Red
}
Write-Host ""

# Employee 6
$employee6 = @{
    firstName = "Lirije"
    lastName = "Gashi"
    email = "lirije.gashi@zadejaberisha.com"
    department = "Marketing"
    salary = 68000.00
} | ConvertTo-Json

Write-Host "Adding Lirije Gashi..." -ForegroundColor Yellow
try {
    Invoke-RestMethod -Uri $baseUrl -Method POST -Body $employee6 -ContentType "application/json"
    Write-Host "✓ Lirije Gashi added!" -ForegroundColor Green
} catch {
    Write-Host "Already exists or error" -ForegroundColor Red
}
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Albanian employees added successfully!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "View all employees at: http://localhost:8080/api/employees" -ForegroundColor Yellow
Write-Host "Or visit: http://localhost:8080" -ForegroundColor Yellow