UNIDAD 7.- Bases de datos Objeto-relacionales.



Las estructuras de datos que se utilizan para almacenar la información siguen siendo
tablas, los usuarios pueden utilizar muchos de los mecanismos de orientación a objetos
para definir y acceder a los datos. 


Por esta razón, se dice que se trata de un modelo de datos objeto-relacional.


Oracle proporciona mecanismos para que el usuario pueda definir sus propios tipos
de datos, cuya estructura puede ser compleja, y que se pueden aplicar para asignar un tipo a
una columna de una tabla. 

También reconoce el concepto de objetos, de tal manera que un
objeto tiene un tipo, se almacena en cierta fila de cierta tabla y 
tiene un identificador único (OID). 

Estos identificadores se pueden utilizar para referenciar a otros objetos y así
representar relaciones de asociación y de agregación. 

Oracle también proporciona mecanismos para asociar métodos a tipos, 
y constructores para diseñar tipos de datos multivaluados (colecciones) y tablas anidadas.
La mayor deficiencia de este sistema es la imposibilidad de definir jerarquías 
de especialización y herencia, lo cual es una importante
desventaja con respecto a las bases de datos orientadas a objetos. 


Tipos de Datos Definidos por el Usuario
Los usuarios de Oracle pueden definir sus propios tipos de datos, pudiendo ser de dos
categorías: 

tipos de objetos (object types) 

y tipos para colecciones (collection types). 

Para construir los tipos de usuario se utilizan los tipos básicos provistos por el sistema 
y otros tipos de usuario previamente definidos.
Un tipo define una estructura y un comportamiento común para un conjunto 
de datos de las aplicaciones. 

CREATE or replace TYPE direccion_t AS OBJECT (
calle VARCHAR2(200),
ciudad VARCHAR2(200),
prov CHAR(2),
codpos VARCHAR2(20) ) ; 


CREATE OR REPLACE TYPE clientes_t AS OBJECT (
clinum NUMBER,
clinomb VARCHAR2(200),
direccion direccion_t,
telefono VARCHAR2(20),
fecha_nac DATE,
MEMBER FUNCTION edad RETURN NUMBER,
PRAGMA RESTRICT_REFERENCES(edad,WNDS)
) ; 




-- CREAR UN TIPO DE OBJETO QUE SE LLAMA TABLA
-- LARGO Y EL ANCHO
-- MÉTODOS AREA, PER�?METRO, PRECIO


CREATE OR REPLACE TYPE TABLA_MADERA AS OBJECT(
largo integer,
ancho integer,
member function area return integer,
member function perimetro return integer,
member function precio (precio_por_unidad float) return float);

CREATE OR REPLACE TYPE BODY TABLA_MADERA AS
member function area return integer AS
v_resultado integer;
BEGIN
    v_resultado:=ancho*largo;
    RETURN v_resultado;
END area;

member function perimetro return integer AS
    v_resultado integer;
BEGIN
    v_resultado:=2*largo+2*ancho;
    return v_resultado;
END perimetro;

member function precio (precio_por_unidad float) return float AS
    v_resultado float;
BEGIN
    v_resultado:=area*precio_por_unidad;
    return v_resultado;
END precio;
END;

drop table mueble;

CREATE TABLE MUEBLE(
codigo int primary key,
cantidad int,
tabla tabla_madera);

describe mueble;

select * from mueble;
insert into mueble values(1,2,new tabla_madera(185,45));

insert into mueble values(2,5,new tabla_madera(200,45));
insert into mueble values(3,5,new tabla_madera(100,100));

Select * from mueble;

-- 
set serveroutput on;

Declare
    objeto tabla_madera;
    
begin
    objeto:= new tabla_madera(185,45);
    dbms_output.put_line('El �rea del objeto es '||objeto.area);
    insert into mueble values(3,5,objeto);
end;


select m.tabla.largo, m.tabla.ancho from mueble m; --para acceder a los valores del objeto hay que declarar si o si un alias a la tabla y acceder con el alias.nombreColumna.nombreVariableDelObjeto


MI_TABLA_MADERA_PINO TABLA_MADERA(30,35);--al tener el objeto ya los parametros, x eso no hay que pasarselos a las funciones que declaramos dentro del objeto
MI_TABLA_MADERA_PINO.AREA;

OBJETO ESTUDIANTE(PESO,ALTURA)
PEPITO (70,185)
