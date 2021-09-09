/*Realizar un cursor implícito que devuelva el número de departamentos que hay en un empresa (tabla dept)
Realizar un cursor explicito (que se llame cursor_accountig) que escriba en pantalla los empleados 
del departamento accounting;
Las tablas dept y emp sino las tenéis las podéis crear en base a las que tenemos en mysql.*/
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


-- cursor implícito numero de departamentos

set serveroutput on;
declare
    numDep int;
begin
    select count(*) into numDep from departments;
    DBMS_OUTPUT.put_line('Número de departamentos: '||numDep);
end;


--Cursor explícito con numero de departamentos

set serveroutput on;
declare
    cursor c1 is select count(*) from departments;
    numeroDep int;
begin
    open c1;
    fetch c1 into numeroDep;
    dbms_output.put_line('Número de departamentos: '||numeroDep);
    close c1;
end;


-- cursor explícito empleados del departamento accounting
select * from departments;
select * from employees;

set serveroutput on;
declare

    nombreEmp employees.name%type;
    cursor cursor_accounting is select employees.name from employees, departments where departments.name='Accounting' 
                        and departments.code=employees.department;    
begin
     
    open cursor_accounting;

    loop
    
        fetch cursor_accounting into nombreEmp;
        
        exit when cursor_accounting%NOTFOUND;
        dbms_output.put_line(nombreEmp);
        
    end loop;
    
    close cursor_accounting;    
    
end;


-- con for
set serveroutput on;

declare
    cursor cursor_accounting is select employees.name from employees, departments where departments.name='Accounting' 
                        and departments.code=employees.department;    
begin
     
    for registro in cursor_accounting loop  --la variable registro se declara automaticamente en el for
        dbms_output.put_line(registro.name);
    end loop;
end;


-------------------------------------------------------------------------

--Realizar un cursor que muestre en pantalla el nombre de los departamentos 
--y su presupuesto siempre que 
--este sea mayor a 50000 y el codigo del departamento sea impar
-- devolver true si el numero es impar
-- devolver false si el numero es par
select * from departments;

create or replace function impar(numero number) --como se va a usar lo creamos en funcion, tbn xk devuelve true or false
return boolean
is
begin
    if(numero mod(2)=0) then
        return false;
    else
        return true;
    end if;
end;



set serveroutput on;
declare

    v_codigo departments.code%type;
    v_nombre departments.name%type;
    v_presupuesto departments.budget%type;
    cursor nombre_dep is
        select code,name,budget from departments where budget>50000;

begin

    open nombre_dep;
    loop 
        fetch nombre_dep into v_codigo,v_nombre,v_presupuesto;
        exit when nombre_dep%notfound;
        
        if impar(v_codigo) then --llamo a la funcion impar y le paso el codigo
            dbms_output.put_line('El departamento '||v_nombre||' tiene de presupuesto '||v_presupuesto);
        end if;
        
    end loop;
    close nombre_dep;

end;


--Realizar un bloque pl/sql que muestre en pantalla el nombre del departamento y debajo los de dicho departamento.
--(se puede utilizar cursores, funciones o procedimientos)

-- crear un procedimiento que dado un codigo de departamento dibuje en pantalla los
--empleados de dicho departamento
--*si queremos que un procedure nos devuelva un valor, el parametro out, al meterlo en un avariable del bloque pl/sql, lo que mostramos es esa variable
--EJEMPLO: 
create or replace procedure departamento_presupuesto --in variable de entrada, out variable de salida, in out variable de entrada y salida
(codigo in departments.code%type, presupuesto out departments.budget%type);
--*

select * from employees;

create or replace procedure empleadosdeundepartamento (codigo in departments.code%type)
is
    cursor c_empleado is select name,lastname from employees where department=codigo;
    v_nombre employees.name%type;
    v_apellidos employees.lastname%type;

begin
    open c_empleado;
    loop
        fetch c_empleado into v_nombre,v_apellidos;
        exit when c_empleado%notfound;
        dbms_output.put_line(v_nombre||'  '||v_apellidos);
    end loop;
    
    close c_empleado;
end;


--ahopra metemos el procedure en el programa principal
set serveroutput on;
declare 

    cursor c_departamento is select code,name from departments;
    v_codigo_departamento departments.code%type;
    v_nombre departments.name%type;

begin
    open c_departamento;
    
    loop
        fetch c_departamento into v_codigo_departamento,v_nombre;
        exit when c_departamento%notfound;
        
        dbms_output.put_line('El departamento '||v_nombre||' tiene los empleados');
        empleadosdeundepartamento(v_codigo_departamento);
    end loop;
    
    close c_departamento;
end;



--Realizar que se llame existe_empleado y que reciba como argumento un codigo
select * from employees;
select count(*) from employees where ssn=123234877;
--devuelve uno si existe o cero si no existe el empleado

create or replace function existe_empleado(codigo employees.ssn%type)
return boolean
is
    existe int;
    
begin
    
    select count(*) into existe from employees where ssn=codigo;
    if existe=1 then 
        return true;
    else 
        return false;
    end if;
end;


set serveroutput on;
declare
    codigoempleado employees.ssn%type:=&codigo_empleado;
begin
    if existe_empleado(codigoempleado) then
        dbms_output.put_line('El empleado con ssn '||codigoempleado||' si existe');
    else
        dbms_output.put_line('El empleado con ssn '||codigoempleado||' no existe');
    end if;
end;


--realizar una funcion que devuelva el numero de apellidos repetidos que
-- tienen los empleados dado un ssn
describe employees;
describe departments;


create or replace function apellidosRepetidos(v_ssn employees.ssn%type) return string is

    v_apellido employees.lastname%type;
begin
    
    select lastname into v_apellido from employees where ssn=v_ssn;
    return v_apellido;
    
end;



create or replace function numeroApellidos(v_apellido employees.lastname%type)
return int
is
    v_numero int;
begin
    select count(*) into v_numero from employees where lastname=v_apellido;
    return v_numero;
end;
-------------------------
/*set serveroutput on;
declare
    seguridad_social employees.ssn%type:=&introduce_ssn;
    numero_repetidos int;
begin
   
    select count(*) into numero_repetidos from employees where lastname=ApellidosRepetidos(seguridad_social) ;
    dbms_output.put_line(numero_repetidos);
end;
*/
-----------------------------
set serveroutput on;
declare
    v_ssn employees.ssn%type:=&introduce_ssn;--da igual k la variable v_ssn la haya usado antes en una funcion ya que son de ambitos distintos y no da problema por llamarse igual aqui
    v_numero int;
    existeSSN int;
    e_noSSN exception;
    
begin
    select count(*) into existeSSN from employees where ssn=v_ssn;
    if existeSSN = 0 then
        raise e_noSSN;
    end if;
    
    v_numero:=numeroApellidos(apellidosRepetidos(v_ssn));
    dbms_output.put_line('El numero de apellidos es '||v_numero);
    
exception
    when e_noSSN then
        dbms_output.put_line('El ssn '||v_ssn||' no existe');
    
end;


select * from employees;


