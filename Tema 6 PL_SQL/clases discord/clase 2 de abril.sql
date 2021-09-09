/*CURSORES

SON TROZOS DE CÓDIGO PL/SQL EN LOS CUALES HAY UNA SENTENCIA SELECT

CURSORES IMPL�?CITOS
La sentencia select devuelve un único valor.
No tienen nombre


CURSORES EXPL�?CITOS
La sentencia select devuelve más de una fila.
Hay que declaralos (ponerle un nombre)
Hay que abrirlos OPEN nombre_cursor.

fetch lo que hacemos es recorrer el resultado uno a uno hasta llegar al final





*/
set serveroutput on;
CREATE TABLE employees(
ssn INTEGER, 
NAME VARCHAR2(20),
lastname VARCHAR2(20), 
department INTEGER,
PRIMARY KEY(ssn));


CREATE TABLE departments(
code INTEGER PRIMARY KEY, NAME VARCHAR2(20),
budget REAL);

INSERT INTO Departments(Code,NAME,Budget) 
VALUES(14,'IT',65000);
INSERT INTO Departments(Code,Name,Budget)
VALUES(37,'Accounting',15000);
INSERT INTO Departments(Code,Name,Budget)
VALUES(59,'Human
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
INSERT INTO employees(ssn,NAME,lastname,department)
VALUES('845657246','Kumar','Swamy',14);

SELECT * FROM employees;
SELECT * FROM departments;
select count(*)  from departments;
--1 REALIZAR UN CURSOR IMPL�?CITO QUE NOS DEVUELVA EL NÚMERO
-- DE DEPARTAMENTOS QUE TIENE LA EMPRESA
set serveroutput on;
declare
  numDept int:=0;

begin
  select count(*) INTO numDept from departments;
   dbms_output.put_line('Número de departamentos: ' ||numDept);
end;
select * from employees;
-- realizar un cursor que muestre en pantalla el name
-- y el lastname del empleado cuyo ssn es 123234877

describe employees;

set serveroutput on;
declare
  nombre varchar2(20);
  apellidos varchar2(20);
begin
  select name,lastname into nombre,apellidos from employees where ssn=123234877;
   dbms_output.put_line(nombre||apellidos);
  end;
  

  describe employees;
select name,lastname from employees;
-- UN CURSOR CON TODOS LOS NAMES Y LASTNAMES DE LA TABLA EMPLOYEES
-- NO PODEMOS USAR UN CURSO IMPLICITO
-- DEBEMOS DECLARAR UNO EXPL�?CITO

set serveroutput on;
declare
  nombre varchar2(20);
  apellidos varchar2(20);
  cursor nombre_empleados IS select name,lastname into nombre,apellidos from employees;
begin
  OPEN nombre_empleados;
  LOOP
    
    FETCH nombre_empleados INTO nombre,apellidos;
    exit when nombre_empleados%notfound;
    dbms_output.put_line(nombre||apellidos);
    
  END LOOP;
  
  CLOSE nombre_empleados;
   
  
  end;

select name,lastname from employees;

Realizar un cursor explicito (que se llame cursor_accountig) 
que escriba en pantalla los empleados del departamento accounting;

SET serveroutput ON;
DECLARE 
CURSOR numero_departamentos IS SELECT count(code) FROM departments;
v_code departments.code%TYPE;

BEGIN 

OPEN numero_departamentos;

fetch numero_departamentos INTO v_code;

dbms_output.put_line('NÃºmero de departamentos: ' ||v_code);

CLOSE numero_departamentos;

END;


-- Realizar un cursor explicito (que se llame cursor_accountig) 
-- que escriba en pantalla los empleados del departamento accounting;

SET serveroutput ON;
DECLARE 

CURSOR empleados_accounting 
IS SELECT employees.NAME, employees.lastname FROM employees,departments 
WHERE employees.department=departments.code and departments.name='Accounting';

v_name employees.NAME%TYPE;
v_lastname employees.lastname%TYPE;

BEGIN 

OPEN empleados_accounting;
loop
  fetch empleados_accounting INTO v_name, v_lastname;
  exit WHEN empleados_accounting%notfound;
  dbms_output.put_line(v_name || ',' ||v_lastname);
END loop;

CLOSE empleados_accounting;

END;
SELECT employees.NAME, employees.lastname FROM employees,departments 
WHERE employees.department=departments.code and departments.name='Accounting';

-- 1.- Que pida un número y diga si es primo o no.


set serveroutput on;
declare
    a int:=&te_pido_numero;
    contador int:=0;
begin
    for i in 1 .. a loop
        if mod(a,i)=0 then
            contador:=contador+1;
        end if;
    end loop;
    if contador<=2 then
        dbms_output.put_line('el número '||a||' es primo');
    else
        dbms_output.put_line('el número '||a||' no es primo');
    end if;
end;



-- 2.- Que muestre los números del 1 al 100.
set serveroutput on;

begin
    for i in 1 .. 100 loop
        dbms_output.put_line(i);
    end loop;
end;

-- 3.- Que muestre los números del 100 al 1.
set serveroutput on;

begin
    for i in reverse 1 .. 100 loop
        dbms_output.put_line(i);
    end loop;
end;

-- 4.- Que muestre los números pares que haya del 1 al 100.
set serveroutput on;

begin
    for i in 1 .. 100 step 2 loop
    
        if mod(i,2)=0 then
            dbms_output.put_line(i||' es par');
        end if;
        
    end loop;
end;

-- 5.- Que muestre los números impares que haya del 1 al 100.
set serveroutput on;

begin
    for i in 1 .. 100 loop
    
        if mod(i,2)!=0 then
            dbms_output.put_line(i||' es impar');
        end if;
        
    end loop;
end;

-- 6.- Que imprima la suma de todos los números que van del 1 al 100.
set serveroutput on;
declare
    total int:=0;
begin
    for i in 1 .. 100 loop
        
        total:=total+i;
        
    end loop;
    dbms_output.put_line(total);
end;

-- 7.- Que imprima la suma de todos los números pares que van del 1 al 100.
set serveroutput on;
declare
    total int:=0;
begin
    for i in 1 .. 100 loop
        if mod(i,2)=0 then
            total:=total+i;
        end if;
    end loop;
    dbms_output.put_line(total);
end;

-- 8.- Que imprima la suma de todos los números impares que van del 1 al 100.
set serveroutput on;
declare
    total int:=0;
begin
    for i in 1 .. 100 loop
        if mod(i,2)!=0 then
            total:=total+i;
        end if;
    end loop;
    dbms_output.put_line(total);
end;

-- 9.- Que imprima la suma de todos los números pares que van del 1 al 100 y diga cuántos hay.
set serveroutput on;
declare
    total int:=0;
    contador int:=0;
begin
    for i in 1 .. 100 loop
        if mod(i,2)=0 then
            total:=total+i;
            contador:=contador+1;
        end if;
    end loop;
    dbms_output.put_line(total);
    dbms_output.put_line('Hay '||contador||' pares');
end;

-- 10.- Que imprima la suma de todos los números impares que van del 1 al 100 y diga cuántos hay.
set serveroutput on;
declare
    total int:=0;
    contador int:=0;
begin
    for i in 1 .. 100 loop
        if mod(i,2)!=0 then
            total:=total+i;
            contador:=contador+1;
        end if;
    end loop;
    dbms_output.put_line(total);
    dbms_output.put_line('Hay '||contador||' impares');
end;

-- 11.- Que pida dos números y muestre todos los números que van desde el primero al segundo.
set serveroutput on;
declare
    a int:=&primer_número;
    b int:=&segundo_número;
    aux int;
    
begin

    if a<=b then
        for i in a .. b loop
            DBMS_OUTPUT.PUT_LINE (i);
        end loop;
        
    else
        aux:=a;
        a:=b;
        b:=aux;
        for i in a .. b loop
            DBMS_OUTPUT.PUT_LINE (i);
        end loop;
    end if;
    
end;

-- 12.- Que pida dos números y muestre todos los números pares que van desde el primero al segundo.
set serveroutput on;
declare
    a int:=&primer_número;
    b int:=&segundo_número;
    aux int;
    
begin

    if a<=b then
    
        for i in a .. b loop
            if mod(i,2)=0 then
                dbms_output.put_line(i);
            end if;
        end loop;
        
    else
        aux:=a;
        a:=b;
        b:=aux;
        for i in a .. b loop
            if mod(i,2)=0 then
                dbms_output.put_line(i);
            end if;
        end loop;
        
    end if;
    
end;

-- 13.- Que pida dos números y muestre todos los números impares que van desde el primero
-- al segundo. Se debe controlar que los valores son correctos
set serveroutput on;
declare
    a int:=&primer_número;
    b int:=&segundo_número;
    aux int;
    
begin

    if a<=b then
    
        for i in a .. b loop
            if mod(i,2)!=0 then
                dbms_output.put_line(i);
            end if;
        end loop;
        
    else
        aux:=a;
        a:=b;
        b:=aux;
        for i in a .. b loop
            if mod(i,2)!=0 then
                dbms_output.put_line(i);
            end if;
        end loop;
        
    end if;
    
end;

-- 14.- Que pida dos números y sume todos los números que van desde el primero al segundo.
set serveroutput on;
declare
    a int:=&primer_número;
    b int:=&segundo_número;
    aux int;
    total int:=0;
    
begin

    if a<=b then
        for i in a .. b loop
            total:=total+i;
        end loop;
        
    else
        aux:=a;
        a:=b;
        b:=aux;
        for i in a .. b loop
            total:=total+i;
        end loop;
    end if;
    dbms_output.put_line('la suma es: '||total);
end;

-- 15.- Que pida un número y muestre en pantalla el mismo número de asteriscos
set serveroutput on;
declare
    a int:=&escriba_un_número;
begin

    if a>=0 then
        for i in 1 .. a loop
            dbms_output.put_line('*');
        end loop;
        
    else
        dbms_output.put_line('escriba un número positivo');
    end if;
end;

-- 16.- Que calcule la media de X números, se dejarán de solicitar números hasta que se
-- introduzca el cero.
set serveroutput on;
declare
    media number;
    valor int;
begin
    loop
        valor:=&introduce_un_numero;
    exit when valor=0;
    end loop;
end;--Ni idea de cómo hacerlo o plantearlo

-- 17.- Que calcule la suma de los cuadrados de los 100 primeros números.
set serveroutput on;
declare
    cuadrado int;
    total int:=0;
begin
    for i in 1 .. 100 loop
        
        cuadrado:=i**2;
        total:=total+cuadrado;
        cuadrado:=0;
    end loop;
    dbms_output.put_line(total);
end;

/* Ni caso, me equivoqué y ya lo dejé por si luego me servía
primos del 1 al 100
set serveroutput on;
declare
    contador int:=0;
begin
    for i in 1 .. 100 loop
        
        for j in 1 .. i loop
            
            if mod(i,j)=0 then
                contador:=contador+1;
            end if;
            
        end loop;
        
        if contador<=2 then 
            dbms_output.put_line(i||' es primo');
        else
            dbms_output.put_line(i||' no es primo');
            
        end if;
        contador:=0;
    end loop;
end;
*/

