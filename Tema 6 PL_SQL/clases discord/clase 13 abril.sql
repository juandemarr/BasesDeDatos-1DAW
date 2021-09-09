create table employees(
ssn integer, 
name varchar2(20),
lastname varchar2(20), 
department integer,
primary key(ssn));


create table departments(
code integer primary key, name varchar2(20),
budget real);

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
insert into employees(ssn,name,lastname,department)
values('845657246','Kumar','Swamy',14);


create or replace FUNCTION par (numero number)
return boolean
as
begin
    if(numero mod(2)=0) then
        return true;
    else
        return false;
    end if;
end;


-- 1.- Realizar un cursor que muestre en pantalla el nombre de los departamentos 
-- y su presupuesto siempre que este sea mayor a 50000 y
-- el código del departamento sea impar.

DESCRIBE DEPARTMENTS;



DECLARE
    CURSOR nombre_dep IS
    select code,name from departments where budget>50000;
    v_nombre departments.name%type;
    v_codigo departments.code%type;
BEGIN
    OPEN nombre_dep;
    LOOP
        FETCH nombre_dep into v_codigo,v_nombre;
        exit when nombre_dep%notfound;
        if impar(v_codigo) then
        
            dbms_output.put_line('El departamento '||v_nombre);
        end if;
     END LOOP;
     CLOSE nombre_dep;
end;






-- CREAR UNA FUNCIÓN QUE SE LLAME IMPAR
-- DEVOLVER TRUE SI EL NÚMERO ES IMPAR
-- DEVOLVER FALSE SI EL NUMEROS ES PAR

CREATE OR REPLACE FUNCTION impar(numero number)
RETURN BOOLEAN
IS 
begin
    if(numero mod(2)=0) then
        RETURN FALSE;
    else
        RETURN TRUE;
    end if;
end;  




-- PROCEDIMIENTO Ejemplo(param1 [IN | OUT | IN OUT] tipo, param2 [IN | OUT |IN OUT]);



-- 2.- Realizar un bloque PL/SQL que muestre en pantalla el nombre del departamento y 
-- debajo los empleados de dicho departamento. (Se pueden utilizar cursores, funciones o procedimientos).

-- CREAR UN PROCEDIMIENTO QUE DADO UN CODIGO DE DEPARTAMENTO DIBUJE EN PANTALLA
-- LOS EMPLEADOS DE DICHO DEPARTAMENTO.


SELECT * FROM EMPLOYEES;



CREATE OR REPLACE procedure empleadosdeundepartamento(codigo in departments.code%type)
IS
cursor c_empleado is SELECT NAME,LASTNAME FROM EMPLOYEES WHERE department=codigo;
v_nombre employees.name%type;
v_apellidos employees.lastname%type;
BEGIN
    OPEN c_empleado;
    LOOP
        FETCH c_empleado INTO v_nombre,v_apellidos;
        exit when c_empleado%notfound;
        dbms_output.put_line(v_nombre||' '||v_apellidos);
    
    END LOOP;
       
    CLOSE c_empleado;

end;

cursor departamentos;

el código del departamento  y el nombre
    nombres de los empleados que pertenecen a dicho departamento.


Human Resources
    Ana
    pilar
    pepe
IT
    JAVIER
    JESUS


describe departments;

set serveroutput on;
declare
    CURSOR c_departamento is SELECT code,name from departments;
    v_codigo_departamento departments.code%type;
    v_nombre departments.name%type;
begin
    OPEN c_departamento;
    LOOP
        FETCH c_departamento INTO v_codigo_departamento,v_nombre;
        exit when c_departamento%notfound;
        dbms_output.put_line('El Departamento '||v_nombre||'  tiene los empleados ');
        empleadosdeundepartamento(v_codigo_departamento);

    END LOOP;
    CLOSE c_departamento;

end;


set serveroutput on;
dbms_output.put_line('Hello there');





-- 3.- Realizar una función que se llame existe_empleado y 
-- que reciba como argumento un código y que devuelva verdadero o falso.

describe employees;
describe departments;
-- si tenéis emp o dept lo hacéis exactmente igul


SELECT * FROM EMPLOYEES;


SELECT COUNT(*) FROM EMPLOYEES WHERE SSN=1233234877;
DEVELVE UNO SI EXISTE O CERO SINO EXISTE EL EMPLEADO


CREATE OR REPLACE FUNCTION existe_empleado(codigo employees.ssn%type)
return BOOLEAN
IS
existe int;
BEGIN
    
    SELECT COUNT(*)INTO existe FROM EMPLOYEES WHERE SSN=codigo;
    if existe=1 then RETURN TRUE;
    ELSE RETURN FALSE;
    end if;
END;

set serveroutput on;
DECLARE
    codigoempleado employees.ssn%type:=&codigo_empleado;
begin
    if existe_empleado(codigoempleado) then
        dbms_output.put_line('El empleado con ssn '||codigoempleado|| ' sí existe');
    else
        dbms_output.put_line('El empleado con ssn '||codigoempleado|| ' no existe');

    end if;

end;


DESCRIBE EMPLOYEES;
DESCRIBE DEPARTMENTS;

-- UNA FUNCIÓN QUE DEVUELVA EL NÚMERO DE APELLIDOS REPETIDOS QUE 
-- TIENEN LOS EMPLEADOS DADO UN SSN.
SELECT * FROM EMPLOYEES;



DESCRIBE CLIENTES;

-- UN PROCEDIMENTO QUE PONGA EN PANTALLA LOS DATOS DE LOS CLIENTES QUE
-- VIVEN EN UNA DETERMINADA  CIUDAD COMO ARGUMENTO y que nos devuelva
-- el número de clientes que viven en la misma ciudad.


CREATE OR REPLACE PROCEDURE clientes_ciudad(v_ciudad in clientes.ciudad%type, v_numeroclientes out int)
is
CURSOR c_clientes IS SELECT * from clientes WHERE ciudad=v_ciudad;
v_cliente clientes%rowtype;
BEGIN
    OPEN c_clientes;
    LOOP
        FETCH c_clientes INTO v_cliente;
        exit when c_clientes%notfound;
        dbms_output.put_line(v_cliente.nombrecliente||' '||v_cliente.apellidocontacto);
      
    END LOOP;
      
    CLOSE c_clientes;
    SELECT count(*) INTO v_numeroclientes from clientes  WHERE ciudad=v_ciudad;
end;

declare
    v_ciudad clientes.ciudad%type:='&introduce_ciudad';
    v_numero int;
begin
    dbms_output.put_line('Los clientes de la ciudad '||v_ciudad||' son los siguintes');
    clientes_ciudad(v_ciudad,v_numero);
    dbms_output.put_line('Y hay este número de clientes en la ciudad'||v_numero);
end;

select * from clientes;