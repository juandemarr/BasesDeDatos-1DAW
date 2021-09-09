create database employee_management;
use employee_management;
create table Departments(
	Code integer,
    Name varchar(20),
	Budget real,
    primary key(code)
);
create table Employees(
	SSN integer,
    Name varchar(20),
    LastName varchar(20),
    Department integer,
    primary key(SSN),
	foreign key(Department) references Departments(Code)
);

INSERT INTO Departments(Code,Name,Budget) VALUES(14,'IT',65000);
INSERT INTO Departments(Code,Name,Budget)
VALUES(37,'Accounting',15000);
INSERT INTO Departments(Code,Name,Budget) VALUES(59,'Human
Resources',240000);
INSERT INTO Departments(Code,Name,Budget)
VALUES(77,'Research',55000);
INSERT INTO Employees(SSN,Name,LastName,Department)
VALUES('123234877','Michael','Rogers',14);
INSERT INTO Employees(SSN,Name,LastName,Department)
VALUES('152934485','Anand','Manikutty',14);
INSERT INTO Employees(SSN,Name,LastName,Department)
VALUES('222364883','Carol','Smith',37);
INSERT INTO Employees(SSN,Name,LastName,Department)
VALUES('326587417','Joe','Stevens',37);
INSERT INTO Employees(SSN,Name,LastName,Department)
VALUES('332154719','Mary-Anne','Foster',14);
INSERT INTO Employees(SSN,Name,LastName,Department)
VALUES('332569843','George','ODonnell',77);
INSERT INTO Employees(SSN,Name,LastName,Department)
VALUES('546523478','John','Doe',59);
INSERT INTO Employees(SSN,Name,LastName,Department)
VALUES('631231482','David','Smith',77);
INSERT INTO Employees(SSN,Name,LastName,Department)
VALUES('654873219','Zacary','Efron',59);
INSERT INTO Employees(SSN,Name,LastName,Department)
VALUES('745685214','Eric','Goldsmith',59);
INSERT INTO Employees(SSN,Name,LastName,Department)
VALUES('845657245','Elizabeth','Doe',14);
INSERT INTO Employees(SSN,Name,LastName,Department)
VALUES('845657246','Kumar','Swamy',14);


select * from departments;
select * from employees;
-- 1. Select the last name of all employees.
select lastname from employees;

-- 2. Select the last name of all employees, without duplicates.
select lastname from employees group by lastname;
-- select dstinct lastname from employees;

-- 3. Select all the data of employees whose last name is "Smith".
select * from employees where lastname="Smith";

-- 4. Select all the data of employees whose last name is "Smith" or "Doe".
select * from employees where lastname="Smith" or lastname="Doe";
-- select * from employees where lastname in ('Smith','Doe');	//solo sirve para el or

-- 5. Select all the data of employees that work in department 14.
select * from employees where department =14;

-- 6. Select all the data of employees that work in department 37 or department 77.
select * from employees where department =37 or department =77;

-- 7. Select all the data of employees whose last name begins with an "S".
select * from employees where lastname like "S%";

-- 8. Select the sum of all the departments' budgets.
select sum(budget) from departments;

-- 9. Select the number of employees in each department (you only need to show the department code and the number of employees).
select department, count(*) from employees group by department;

-- 10. Select all the data of employees, including each employee's department's data.
select employees.*, departments.name, budget from employees, departments where code=department;

-- 11. Select the name and last name of each employee, along with the name and budget of the employee's department.
select employees.name, lastname, departments.name as DepartmentName, budget from employees, departments where code=department;

-- 12. Select the name and last name of employees working for departments with a budget greater than $60,000.
select employees.name, lastname, departments.name as DepartmentName, budget from employees, departments where code=department and budget>60000;

-- 13. Select the departments with a budget larger than the average budget of all the departments.
select name from departments where budget > (select avg(budget) from departments);
select name from departments having budget > avg(budget);

-- 14. Select the names of departments with more than two employees.
 select name from departments where code in
 (select department from employees group by department having count(*)>2);
-- ???

-- 15. Select the name and last name of employees working for departments with second lowest budget.
select employees.name, lastname, budget from employees, departments where code=department order by budget asc limit 2,1; 
-- order by budget asc

-- 16. Add a new department called "Quality Assurance", with a budget of $40,000 and
-- departmental code 11. Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
insert into departments values (11,"Quality Assurance", 40000);
insert into employees values (847219811,"Mary", "Moore", 11);

-- 17. Reduce the budget of all departments by 10%.
update departments set budget= budget * 0.9;

-- 18. Reassign all employees from the Research department (code 77) to the IT department (code 14).
update employees set department=14 where department=77;

-- 19. Delete from the table all employees in the IT department (code 14).
delete from employees where department=14;

-- 20. Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
delete from employees where department=(select code from  departments where budget >= 60000);

-- 21. Delete from the table all employees.
delete from employees;