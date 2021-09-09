drop database libreria;

create database leftjoin;
use leftjoin;
drop table if exists clientes, provincias;
create table clientes (
codigo int unsigned auto_increment,
nombre varchar(30) not null,
domicilio varchar(30),
ciudad varchar(20),
codigoProvincia tinyint unsigned,
telefono varchar(11),
primary key(codigo),
foreign key (codigoProvincia) references provincias(codigo)
);
create table provincias(
codigo tinyint unsigned auto_increment,
nombre varchar(20),
primary key (codigo)
);
insert into provincias (nombre) values('Cordoba');insert into provincias (nombre) values('Santa Fe');
insert into provincias (nombre) values('Corrientes');
insert into provincias (nombre) values('Misiones');
insert into provincias (nombre) values('Salta');
insert into provincias (nombre) values('Buenos Aires');
insert into provincias (nombre) values('Neuquen');
insert into clientes (nombre,domicilio,ciudad,codigoProvincia,telefono)
values ('Lopez Marcos', 'Colon 111', 'Córdoba',1,'null');
insert into clientes (nombre,domicilio,ciudad,codigoProvincia,telefono)
values ('Perez Ana', 'San Martin 222', 'Cruz del Eje',1,'4578585');
insert into clientes (nombre,domicilio,ciudad,codigoProvincia,telefono)
values ('Garcia Juan', 'Rivadavia 333', 'Villa Maria',1,'4578445');
insert into clientes (nombre,domicilio,ciudad,codigoProvincia,telefono)
values ('Perez Luis', 'Sarmiento 444', 'Rosario',2,null);
insert into clientes (nombre,domicilio,ciudad,codigoProvincia,telefono)
values ('Pereyra Lucas', 'San Martin 555', 'Cruz del Eje',1,'4253685');
insert into clientes (nombre,domicilio,ciudad,codigoProvincia,telefono)
values ('Gomez Ines', 'San Martin 666', 'Santa Fe',2,'0345252525');
insert into clientes (nombre,domicilio,ciudad,codigoProvincia,telefono)
values ('Torres Fabiola', 'Alem 777', 'Villa del Rosario',1,'4554455');
insert into clientes (nombre,domicilio,ciudad,codigoProvincia,telefono)
values ('Lopez Carlos', 'Irigoyen 888', 'Cruz del Eje',1,null);
insert into clientes (nombre,domicilio,ciudad,codigoProvincia,telefono)
values ('Ramos Betina', 'San Martin 999', 'Cordoba',1,'4223366');
insert into clientes (nombre,domicilio,ciudad,codigoProvincia,telefono)
values ('Lopez Lucas', 'San Martin 1010', 'Posadas',4,'0457858745');

-- 4- Queremos saber de qué provincias no tenemos clientes:
select provincias.nombre, clientes.nombre from provincias left join clientes 
on provincias.codigo=clientes.codigoProvincia where clientes.codigoprovincia is null;

select provincias.nombre from provincias where codigo not in( select provincias.codigo from provincias,clientes
where provincias.codigo=clientes.codigoProvincia);

-- 5- Queremos saber de qué provincias si tenemos clientes, sin repetir el nombre de la provincia:
select provincias.nombre, clientes.nombre from provincias inner join clientes on provincias.codigo=clientes.codigoprovincia;

-- 6- Omita la referencia a las tablas en la condición "on" para verificar que la sentencia no se ejecuta porque el nombre 
-- del campo "codigo" es ambiguo (ambas tablas lo tienen):
select codigo from provincias left join clientes on codigo=codigoprovincia;