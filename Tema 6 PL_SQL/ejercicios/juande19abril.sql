-- tabla para almacenar las personas de la BD
CREATE TABLE personas (
dni VARCHAR2(9) PRIMARY KEY,
nombre VARCHAR2(15),
apellidos VARCHAR2(15),
edad NUMBER
);
-- inserción de datos
INSERT INTO personas(dni,nombre,apellidos,edad) VALUES ('11','Juan','Álvarez',18);
INSERT INTO personas(dni,nombre,apellidos,edad) VALUES ('22','José','Jiménez',22);
INSERT INTO personas(dni,nombre,apellidos,edad) VALUES ('33','María','Pérez',35);
INSERT INTO personas(dni,nombre,apellidos,edad) VALUES ('44','Elena','Martínez',20);
?
select * from personas;
/*1. Construya un bloque PL/SQL que pida al usuario su nombre por teclado y que posteriormente lo visualice de la siguiente forma
"El nombre introducido es: NOMBRE".*/
set serveroutput on;
declare
    nombre varchar2(50):='&Introduce_tu_nombre';--en varhcar2 para que no pete si se introducen letras. acepta todos los valores y si no lo encuentra aparece la excepcion no_data_found
begin
    dbms_output.put_line('El nombre introducido es: '||nombre);
end;

/*2. Construya un bloque PL/SQL que pida por teclado el dni de la persona y que posteriormente se muestre el nombre y la edad de la persona 
correspondiente. Controla las posibles excepciones*/
set serveroutput on;
declare

    dni_introducido varchar2(20):='&introduce_dni';
    v_nombre personas.nombre%type;
    v_edad personas.edad%type;

begin
    
    select nombre,edad into v_nombre,v_edad from personas where dni=dni_introducido;
    dbms_output.put_line(v_nombre||' tiene '||v_edad||' años');
    
exception

    when no_data_found then
        dbms_output.put_line('No existe el DNI');
        
end;


/*3.- Construya un bloque PL/SQL con la misma funcionalidad pero utilizando un registro(%rowtype) para almacenar el nombre y la edad 
de la persona elegida. Controla las posibles excepciones*/
set serveroutput on;
declare
    dni_introducido varchar2(20):='&introduce_dni';
    registro personas%rowtype;
    
begin
    select * into registro from personas where dni=dni_introducido;--como registro es solo una variable, en select solo puede aparecer "un valor", 
                                                                                                     --en este caso *. En el dbms se especificará qué columnas queremos.
    dbms_output.put_line(registro.nombre||' tiene '||registro.edad);
    
exception
    when no_data_found then
        dbms_output.put_line('No existe el dni');

end;
?
/*4.- Construya un cursor que inserte sólo los alumnos de informática en la tabla AlumnosInf, teniendo en cuenta la estructura de esta tabla, 
así por ejemplo, debe tener en cuenta que el atributo nombre_apellidos resulta de la concatenación de los atributos nombre y apellidos. 
Antes de la inserción de cada tupla en la tabla AlumnosInf debe mostrar por pantalla el nombre y el apellido que va a insertar. 
Controla las posibles excepciones y utilizar %rowtype*/
-- tabla para almacenar todos los alumnos de la BD
CREATE TABLE Alumnos (
numMatricula NUMBER PRIMARY KEY,
nombre VARCHAR2(15),
apellidos VARCHAR(30),
titulacion VARCHAR(15),
precioMatricula NUMBER);
-- tabla para los alumnos de informática
CREATE TABLE AlumnosInf (
IDMatricula NUMBER PRIMARY KEY,
nombre_apellidos VARCHAR(50),
precio NUMBER);

-- insertar valores
INSERT INTO Alumnos VALUES (1,'Juan','Álvarez','Administrativo',1000);
INSERT INTO Alumnos VALUES (2,'José','Jiménez','Informática',1200);
INSERT INTO Alumnos VALUES (3,'María','Pérez','Administrativo',1000);
INSERT INTO Alumnos VALUES (4,'Elena','Martínez','Informática',1200);



set serveroutput on;
declare
    cursor alumno is select * from Alumnos where titulacion='Informática';
    registro Alumnos%rowtype;
begin

    open alumno;
    loop
        fetch alumno into registro;
        exit when alumno%notfound;
        
        dbms_output.put_line(registro.nummatricula||' '||registro.nombre||registro.apellidos||' '||registro.preciomatricula);
        insert into alumnosinf values(registro.nummatricula,registro.nombre||' '||registro.apellidos,registro.preciomatricula);
        end loop;
    close alumno;
end;

select * from alumnosinf;