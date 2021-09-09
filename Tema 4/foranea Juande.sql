-- show databases;
drop database foranea; 
create database foranea;
use foranea;
create table proveedor (
	pr varchar(5) primary key,
    nombre varchar(20),
    estado int,
    ciudad varchar(20)
);

create table pieza(
	pz varchar(5) primary key,
    nombre varchar(20),
    color varchar(20),
    peso int,
    ciudad varchar(20)
);
-- drop table suministro;
create table suministro(
	codigo int primary key,
    pr varchar(5),
    pz varchar(5),
    cantidad int
);

-- show create table suministro;
alter table suministro add foreign key(pr) references proveedor(pr) on update cascade ;
alter table suministro add foreign key(pz) references pieza(pz) on update cascade ;

insert into proveedor values('S1','Salazar',20,'Londres');
insert into proveedor values('S2','James',10,'París');
insert into proveedor values('S3','Bernal',30,'París');
insert into proveedor values('S4','Corona',20,'Londres');
insert into proveedor values('S5','Aldana',30,'Atenas');

insert into pieza values('P1','tuerca','verde',12,'París');
insert into pieza values('P2','perno','rojo',17,'Londres');
insert into pieza values('P3','birlo','azul',17,'Roma');
insert into pieza values('P4','birlo','rojo',14,'Londres');
insert into pieza values('P5','birlo','azul',12,'París');
insert into pieza values('P6','engrane','rojo',19,'París');

insert into suministro values(1,'S1','P1',300);
insert into suministro values(2,'S1','P2',200);
insert into suministro values(3,'S1','P3',400);
insert into suministro values(4,'S1','P4',200);
insert into suministro values(5,'S1','P5',100);
insert into suministro values(6,'S1','P6',100);
insert into suministro values(7,'S2','P1',300);
insert into suministro values(8,'S2','P2',400);
insert into suministro values(9,'S3','P2',200);
insert into suministro values(10,'S4','P2',200);
insert into suministro values(11,'S4','P4',300);
insert into suministro values(12,'S4','P5',400);



select * from proveedor;
select * from pieza;
select * from suministro;
-- Caso 1
-- Si las reglas de borrado y modificación de ambas claves ajenas son restringir:
-- 1. ¿Se puede borrar la fila de PROVEEDOR que corresponde al proveedor S1?
-- no porque dará error al formar parte esa columna de una clave foránea en suministro
delete from proveedor where pr="S1";

-- 2. ¿Se puede borrar la fila de PROVEEDOR que corresponde al proveedor S5?
-- sí por que no aparece referenciada en la tabla suministro
delete from proveedor where pr="S5";

-- 3. En general ¿qué proveedores se pueden borrar?
-- Los que no son referenciados por ninguna clave foránea, en este caso S5

-- 4. ¿Se puede borrar de SUMINISTRO el envío del proveedor S1 y la pieza P2?
-- Sí porque no son datos que sean referenciados en otras tablas.
delete from suministro where pr='S1' and pz='P2';

-- 5. En general ¿qué envíos se pueden borrar?
-- Se pueden borrar todas las filas de la tabla suministro
delete from suministro;

-- 6. ¿Se puede insertar en SUMINISTRO un envío del proveedor S1 y de la pieza P7 con una candad de 300?
-- no se puede ya que el valor P7 no existe en la tabla pieza, y en la tabla suministro es una clave foránea de pieza, 
-- lo que quiere decir que tiene que existir previamente como clave primaria en pieza
insert into suministro values(13,'S1','P7',300);

-- 7. ¿Se puede insertar en SUMINISTRO un envío del proveedor S1 y de la pieza P6 con una candad de 200?
-- Sí ya que tanto el valor de pieza como de proveedor existen en sus tablas correspondientes como claves primarias.
insert into suministro values(13,'S1','P6',300);

-- 8. ¿Se puede insertar en SUMINISTRO un envío del proveedor S2 y de la pieza P3 con una cantidad de 400?
-- sí
insert into suministro values(14,'S2','P3',300);

-- 9. En general ¿Cuándo se puede insertar envíos en la tabla SUMINISTRO?
-- Cuando existan los valores como claves primarias en las tablas a las que hace referencia la clave foránea

-- 10. ¿Se puede borrar la fila de PIEZA que corresponde a la pieza P6?
-- no porque tiene un valor referenciado en la tabla suministro como clave foránea, y el delete especificado 
-- en esa clave es on restrict, el cual no permite borrar los valores referenciados por claves foráneas
delete from pieza where pz="P6";

-- 11. En general ¿qué piezas se pueden borrar?
-- las que no existan como clave primaria a la que hacen referencia.



-- Caso 2
-- Vuelve a dejar las tablas en su estado original. Cambia las reglas de comportamiento de SUMINISTRO.pr a propagar:
-- 1. ¿Se puede borrar la fila de PROVEEDOR que corresponde al proveedor S1?
-- Sí porque on delete cascade permite borrar tanto la fila indicada como los valores asociados como clave foránea
delete from proveedor where pr="S1";

-- 2. ¿Qué ha pasado con los envíos del proveedor S1?
-- También se han eliminado
select * from suministro where pr="S1";

-- 3. ¿Se puede borrar la fila de PROVEEDOR que corresponde al proveedor S5?
-- sí
delete from proveedor where pr="S5";

-- 4. En general ¿qué proveedores se pueden borrar?
-- todos

-- 5. ¿Se puede borrar de SUMINISTRO el envío del proveedor S2 y la pieza P2?
-- si
delete from suministro where pr="S2" and pz="P2";
delete from suministro where pz="P2";

-- 6. En general ¿qué envíos se pueden borrar?
-- todos
delete from suministro;

-- 7. ¿Se puede borrar la fila de PIEZA que corresponde a la pieza P6?
-- no, ya que sus valores están referenciados como claves foráneas con la cláusula on delete restrict 
-- que impide que se puedan borrar en la tabla pieza
delete from pieza where pz="P6";

-- 8. ¿Se puede borrar la fila de PIEZA que corresponde a la pieza P2?
-- no
delete from pieza where pz="P2";

-- 9. En general ¿qué piezas se puede borrar?
-- ninguna que esté referenciada como clave foránea.
delete from pieza;



-- Caso 3
-- Vuelve a dejar las tablas en su estado original. Cambia las reglas de comportamiento de SUMINISTRO.pz a propagar:
-- 1. ¿Se puede borrar la fila de PROVEEDOR que corresponde al proveedor S1?
-- no porque el delete de su valor referenciado es on restrict.
delete from proveedor where pr="S1";

-- 2. ¿Qué ha pasado con los envíos del proveedor S1?
-- siguen en la tabla
select * from suministro where pr="S1";

-- 3. ¿Se puede borrar la fila de PROVEEDOR que corresponde al proveedor S5?
-- si porque no está referenciado en la tabla suministro
delete from proveedor where pr="S5";

-- 4. En general ¿qué proveedores se pueden borrar?
-- los que no estén referenciados en suministro

-- 5. ¿Se puede borrar de SUMINISTRO el envío del proveedor S2 y la pieza P2?
-- sí
delete from suministro where pr="S2" and pz="P2";

-- 6. En general ¿qué envíos se pueden borrar?
-- todos
delete from suministro;

-- 7. ¿Se puede borrar la fila de PIEZA que corresponde a la pieza P6?
-- sí, ya que la cláusula delete de su fk es on cascade, la cual permite el borrado
delete from pieza where pz="P6";

-- 8. ¿Se puede borrar la fila de PIEZA que corresponde a la pieza P2?
-- sí
delete from pieza where pz="P2";

-- 9. ¿Qué ha pasado con los envíos de la pieza P2?
-- también se han borrado
select * from suministro where pz="P2";

-- 10. En general ¿qué piezas se pueden borrar?
-- todas


-- Caso 4
-- Vuelve a dejar las tablas en su estado original. Cambia las reglas de comportamiento de ambas claves, 
-- de modo que para el borrado escojas restringir y para la modificación escojas propagar:
-- ¿Se puede borrar la fila de PROVEEDOR que corresponde al proveedor S1?
-- no ya que es delete on restrict
delete from proveedor where pr="S1";

-- 1. ¿Se puede borrar la fila de PROVEEDOR que corresponde al proveedor S5?
-- sí, ya que este valor no está referenciado en la clave foránea de suministro-proveedor
delete from proveedor where pr="S5";

-- 2. En general ¿qué proveedores se pueden borrar?
-- los que no estén referenciados

-- 3. ¿Se puede modificar en PROVEEDOR el código del proveedor S1 y cambiarlo por S6?
-- sí ya que la cláusula update se encuentra on cascade y el código s6 no está creado
select * from suministro;
select * from proveedor;
update proveedor set pr="S6" where pr="S1";
update proveedor set pr="S4" where pr="S3"; -- no

-- 4. ¿Qué ha pasado con los envíos del proveedor S1?
-- se han actualizado y ahora son del proveedor S6
select * from suminitro;

-- 5. ¿Se puede modificar en SUMINISTRO el envío del proveedor S3, poniendo que es el proveedor S4?
-- sí, y no cambia el valor en la tabla "padre" proveedor
update suministro set pr="S4" where pr="S3";
select * from suministro;
select * from proveedor;

-- 6. ¿Se puede modificar en SUMINISTRO el envío anterior, poniendo que es el proveedor S5?
-- sí
update suministro set pr="S5" where pr="S4";
select * from suministro;

-- 7. ¿Se puede modificar en SUMINISTRO el envío anterior, poniendo que es el proveedor S7?
-- no ya que el proveedor S7 en la tabla proveedor no existe.
update suministro set pr="S7" where pr="S5";

-- 8. ¿Cuándo se puede modificar el código de un proveedor en PROVEEDOR?
-- cuando el código no esté creado;
select * from proveedor;
update proveedor set pr="S7" where pr="S5"; -- sí
update proveedor set pr="S2" where pr="S7"; -- no

-- 9. ¿Cuándo se puede modificar el código de un proveedor en un envío de SUMINISTRO?
-- cuando el valor del proveedor esté creado como clave principal en la tabla proveedor
select * from suministro;
select * from proveedor;
update suministro set pr="S3" where pr="S2";-- sí
update suministro set pr="S10" where pr="S6"; -- no


-- 10. En general ¿qué piezas se pueden borrar?
-- las de la tabla suministro
delete from suministro where pz="P2";-- sí
delete from pieza where pz="P2";-- no por ser delete on restrict

-- 11. ¿Cuándo se puede modificar el código de una pieza en PIEZA?
-- cuando la cláusula update esté on cascade, al tener una clave foránea que referencia a esta columna, 
-- y el valor nuevo no esté ya creado como pk
update pieza set pz="P8" where pz="P6";-- sí
update pieza set pz="P3" where pz="P2";-- no
select * from pieza;

-- 12. En general ¿qué envíos se pueden borrar?
-- todos
delete from suministro;

-- 13. ¿Cuándo se puede modificar el código de una pieza en un envío de SUMINISTRO?
-- cuando el nuevo valor exista en la tabla "padre" a la que referencia y la cláusula update sea on cascade, 
-- en la clave foránea correspondiente de la tabla suministro.
update suministro set pz="P1" where pr="P3";