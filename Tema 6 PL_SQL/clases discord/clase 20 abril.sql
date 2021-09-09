-- VARRAY

ALUMNOS[0..N] --> 

-- ORACLE

(1..LONGITUD DEL ARRAY)

--  A la hora de declarar un array en ORACLE lo que estamos
-- haciendo realmente es declarar un nuevo tipo de variable
-- TYPE 

names(1):='Pepe';
names(2):='María';
...
names(5):='Ana';


set serveroutput on;
DECLARE 
   type namesarray IS VARRAY(5) OF VARCHAR2(10); 
   type grades IS VARRAY(5) OF INTEGER; 
   names namesarray; 
   marks grades; 
   total integer; 
BEGIN 
   names := namesarray('Kavita', 'Pritam', 'Ayan', 'Rishav', 'Aziz'); 
   marks:= grades(98, 97, 78, 87, 92); 
   total := names.count; 
   dbms_output.put_line('Total '|| total || ' Students'); 
   FOR i in 1 .. total LOOP 
      dbms_output.put_line('Student: ' || names(i) || 'Marks: ' || marks(i)); 
   END LOOP; 
END; 




describe emp;
select * from emp;



SELECT COUNT(dISTINCT(JOB)) FROM EMP;



set serveroutput on;
DECLARE
    TYPE jobsarray IS VARRAY(15) OF emp.job%type;
    tipo_trabajo jobsarray:=jobsarray();
    cursor c_trabajo IS SELECT DISTINCT(JOB) FROM EMP;
    i int:=1;
    longitud int:=0;
    v_trabajo emp.job%type;
BEGIN
    
    OPEN c_trabajo;
    LOOP
        tipo_trabajo.extend;
        -- array_var.extend es ir reservando la memoria necesaria para ir usando
        -- nuestro array. De forma dinámica vamos guardando trozos de memoria para
        -- nuestra variable de tipo array;
        FETCH c_trabajo INTO v_trabajo;
        exit when c_trabajo%notfound;
        tipo_trabajo(i):=v_trabajo;
        i:=i+1;
    END LOOP;
    CLOSE c_trabajo;

    longitud:=tipo_trabajo.count;
    -- variable de tipo array .count es devolver el tamaño de dicha variable
    
    for i in 1..longitud LOOP
        dbms_output.put_line(tipo_trabajo(i));
    end loop;
    dbms_output.put_line('La longitud de la variable de tipo array tipo_trabajo es '||longitud);
end;

select * from dept;


set serveroutput on;
DECLARE
    TYPE deptarray IS VARRAY(15) OF dept%rowtype;
    depararray deptarray:=deptarray();
    cursor c_dept IS SELECT * FROM dept;
    i int:=1;
    longitud int:=0;
    v_dept dept%rowtype;
BEGIN

    OPEN c_dept;
    LOOP
        depararray.extend;
        FETCH c_dept INTO v_dept;
        exit when c_dept%notfound;
        depararray(i):=v_dept;
        i:=i+1;
       
    END LOOP;
     
    CLOSE c_dept;
    
    longitud:=depararray.count;
    
    for i in 1..longitud LOOP
        dbms_output.put_line(depararray(i).deptno||' '||depararray(i).dname||' '||depararray(i).loc);
    end loop;
    
end;

describe dept;
















-- tabla para almacenar las personas de la BD
Create Table Personas (
Dni Varchar2(9) Primary Key,
Nombre Varchar2(15),
Apellidos Varchar2(15),
Edad Number
);
-- inserción de datos
Insert Into Personas(Dni,Nombre,Apellidos,Edad) Values ('11','Juan','Álvarez',18);
Insert Into Personas(Dni,Nombre,Apellidos,Edad) Values ('22','José','Jiménez',22);
Insert Into Personas(Dni,Nombre,Apellidos,Edad) Values ('33','María','Pérez',35);
Insert Into Personas(Dni,Nombre,Apellidos,Edad) Values ('44','Elena','Martínez',20);

-- tabla para los alumnos de informática
Create Table Alumnosinf (
Idmatricula Number Primary Key,
Nombre_Apellidos Varchar(50),
Precio Number);

-- Tabla para los alumnos
Create Table Alumnos (
Nummatricula Number Primary Key,
Nombre Varchar2(15),
Apellidos Varchar(30),
Titulacion Varchar(15),
Preciomatricula Number);


-- insertar valores
Insert Into Alumnos Values (1,'Juan','Álvarez','Administrativo',1000);
Insert Into Alumnos Values (2,'José','Jiménez','Informática',1200);
Insert Into Alumnos Values (3,'María','Pérez','Administrativo',1000);
Insert Into Alumnos Values (4,'Elena','Martínez','Informática',1200);

-- 1. Construya un bloque PL/SQL que pida al usuario su nombre por teclado 
-- y que posterior-mente lo visualice de la siguiente forma 
-- "El nombre introducido es: NOMBRE".

set serveroutput on;
declare
    p_Nombre varchar2(20):='&introduzca_nombre';
begin
    dbms_output.put_line('El nombre introducido es: '||p_Nombre);
end;   

-- 2.Construya un bloque PL/SQL que pida por teclado el dni de la persona 
-- y que posteriormente se muestre el nombre y la edad de la persona 
--correspondiente. Controla las posibles excepciones



set serveroutput on;
Declare
     p_Dni varchar2(9):='&introduzca_dni';
     p_Nombre varchar2(25);
     p_Edad integer;
Begin
 Select Nombre,Edad Into p_Nombre,p_Edad From Personas Where Dni=p_Dni;
dbms_output.put_line(' El nombre es: ' || p_nombre || ' y tiene: '|| p_Edad|| ' años');
Exception
 When No_Data_Found Then
 dbms_output.put_line('Error al introducir DNI');
End;

-- 3.- Construya un bloque PL/SQL con la misma funcionalidad 
-- pero utilizando un registro(%rowtype) para almacenar el 
-- nombre y la edad de la persona elegida. Controla las posibles excepciones

set serveroutput on;
declare
    p_dni varchar2(9):='&introduzca_dni';
    r_personas personas%rowtype;
begin
    -- select personas.nombre,personas.edad into r_personas.nombre,r_personas.edad from personas where dni=p_dni;
    select * into r_personas from personas where dni=p_dni;
    dbms_output.put_line(' El nombre es: ' || r_personas.nombre || ' y tiene: '|| r_personas.edad|| ' años');
exception when NO_DATA_FOUND
then 
    dbms_output.put_line('Error al introducir DNI');
end;

-- 4.- Construya un cursor que inserte sólo los alumnos de informática en la tabla AlumnosInf, teniendo en cuenta la estructura de esta tabla, así por ejemplo, 
-- debe tener en cuenta que el atributo nombre_apellidos resulta de la concatenación de los atributos nombre y apellidos. Antes de la inserción de cada tupla en la tabla AlumnosInf debe mostrar por pantalla el nombre y el apellido que va a insertar. 
-- Controla las posibles excepciones y utilizar %rowtype tabla para almacenar todos los alumnos de la BD

set serveroutput on;

declare

    cursor r_informatica is select numMatricula,nombre,apellidos,precioMatricula from alumnos 
            left join alumnosInf on numMatricula=idMatricula 
        where titulacion like 'Informática' and idMatricula is null;
    alumno Alumnos%rowtype;
begin
    open r_informatica;
        loop
            fetch r_informatica into alumno.numMatricula, alumno.nombre, alumno.apellidos, alumno.precioMatricula;
            exit when r_informatica%notfound;
            dbms_output.put_line('Nombre: ' || alumno.nombre || ' Apelidos:' || alumno.apellidos);
            insert into AlumnosInf (IDMatricula, nombre_apellidos, precio) 
            values (alumno.numMatricula, alumno.nombre || ' ' || alumno.apellidos, alumno.precioMatricula);
        end loop;
    close r_informatica;
end;

select * from AlumnosInf;
select * from Alumnos;
describe emp;
delete emp where empno=1;



TRIGGERS

Los disparadores o triggers son bloques de pl/sql asociados a una tabla 
y que se ejecutan automáticamente como reacción a una operacion DML 
específica (INSERT,UPDATE,DELETE) sobre dicha tabla.

PL/SQL sirven para reforzar o mantener la integridad de nuestra Base de Datos.

select * from emp;
select * from dept;

insert into emp values(2,'Ana','Salesman',7839,sysdate,25000,null,40);

select * from emp;

1.- código empleado repetido.
2.- código departamento que no existe
3.- código manager que no existe.
4.- sueldo sea mayor que el del presidente.

TRIGGER 

INSERT OR UPDATE OR DELETE

insert emp

insert into emp values(2,'Ana','Salesman',7839,sysdate,25000,null,40);

TRIGGER 

MEDIANTE UNA VARIABLE 


:NEW.SAL-->25000

:NEW.JOB-->Salesman

UPDATE
SELECT * FROM EMP;

UPDATE EMP SET JOB='Salesman' where empno=7369;

:new.job-->salesman

:old.job-->clerk

DELETE 

:OLD.0

set serveroutput on;
declare
  dni string(9);
  dni_length Exception;
begin
  dni:='&Introduce_el_dni';
  if length(dni)!=9 then
    raise dni_length;
  end if;
  dbms_output.put_line('El dni introducido es: ' || dni);
Exception
  when value_error then
    dbms_output.put_line('El dni es incorrecto');
  when dni_length then
    dbms_output.put_line('El dni es incorrecto');
end;



declare
  CURSOR insertarAlumnos IS select nombre, apellidos, numMatricula, precioMatricula from alumnos where titulación=Informática;
  a_nombre alumnos.nombre%rowtype;
  a_apellidos alumnos.apellidos%rowtype;
  a_idMatr alumnos.numMatricula%rowtype;
  a_prMatr alumnos.precioMatricula%rowtype;
  a_nombreApll varchar(50);
begin
  LOOP
     FETCH insertarAlumnos INTO a_nombre, a_apellidos, a_idMatr, a_prMatr;
     dbms_output.put_line(a_nombre||', '||a_apellidos);
     a_nombreApll:=(a_nombre||a_apellidos);
     insert into AlumnosInf values(a_idMatr,a_nombreApll,a_prMatr);
     exit when insertarAlumnos%notfound;
  END LOOP;
exception
  
end;













