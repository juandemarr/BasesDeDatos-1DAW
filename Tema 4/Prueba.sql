create database prueba;
create database prueba;-- da error

show databases;
use prueba;
show tables;

CREATE TABLE alumno (
    dni INT PRIMARY KEY,
    nombre VARCHAR(15),
    apellidos VARCHAR(20),
    direccion VARCHAR(50),
    edad INT
);

show tables;
select * from alumno;
insert into alumno values(1,'Pepe','Pérez','Calle Ancha',15);
insert into alumno values(2,'María','Pérez','Calle Ancha',15);
insert into alumno (dni,nombre,apellidos) values (3,'Ana','García');

select * from alumno;

create table materias(
codigo int primary key,
nombre varchar(15),
curso int);

insert into materias values(1,'Matemáticas',1);
insert into materias values(2,'Lengua',2);
insert into materias values(3,'Inglés',2);

select * from materias;
delete from materias where codigo=1;
delete from materias where codigo=2;
delete from materias where codigo=3;

drop table materias;
describe materias;

/*EJERCICIO LIBROS ENDMODO*/
use prueba;
create table libros(
titulo varchar(40),
autor varchar(20),
editorial varchar(15),
precio float,
cantidad integer
);

insert into libros values ('El aleph','Borges','Emece',45.50,100,1),('Alicia en el pais de las maravillas','Lewis Carroll','Planeta',25,200,2),('Matemáticas estas ahí','Paenza','Planeta',15.8,200,3);

alter table libros
add ISBN varchar(10) primary key;

delete from libros;

describe libros;
select * from libros;

/*EJERCICIO auto_increment y default*/
use prueba;
create table autor(
codigo int primary key auto_increment,
nombre varchar(20) default 'anonimo',
nacionalidad varchar(20));

describe autor;

insert into autor(nombre,nacionalidad) values ('Arthur','Españita');

select * from autor;

/*EJERCICIO tabla escribe (relacion m a m de autor y libros, tablas ya creadas) , pk cod_autor y ISBN_libro
mismo tipo de datos k las columnas ya creadas*/

create table escribe(
codigo int,
ISBN varchar(10),
primary key(codigo, ISBN),
-- foreign key (codigo) references autor (codigo),
foreign key (ISBN) references libros(ISBN)
);

insert into escribe values(1,1);
insert into escribe valueS(1,10);

drop table escribe;
describe escribe;
select * from escribe;

alter table escribe
add foreign key (codigo) references autor(codigo);

/*EJERCICIO CREAR TABLA TIPO DE DATO*/
/*create table tipodedato(
entero int,
pequeño_entero tinyint,*/

select DNI from alumno;
select * from alumno;
select dni,nombre from alumno;

select apellidos from alumno where apellidos='Pérez';
select * from alumno where apellidos='Pérez' and edad =15;
select * from alumno where apellidos='García' or edad=15;

-- edad sea distinta!= ó <>

-- muestre todos los libros que cuestan menos de 40 euros
-- operadores relacionales < > <= >= = !=
select titulo from libros where precio < 40;
select * from libros;

/* Seleccionar los libros que cuestan más de 20 euros
y cuya cantidad sea inferior a 500*/
select * from libros where precio > 20 and cantidad < 500;

-- funciones de agregación máximo, mínimo, media de una determinada columna
select max(precio) from libros;
select min(precio) from libros;
select avg(precio) from libros;

-- anidar select
select * from libros where precio=(select min(precio) from libros);

insert into libros values ('Alicia en el pais de las maravillas','Lewis Carroll','Planeta',25,200,3);
delete from libros where cantidad = 200;
select * from libros;
insert into libros values ('Matemáticas estas ahí','Paenza','Planeta',15.8,200,3);
insert into libros values ('Matemáticas estas ahí','Paenza','Planeta',15.8,200,3);

create table employee
(ecode integer primary key,
ename varchar(20),
gender char(1),
grade char(2),
gross integer);

insert into employee
values(1001, 'Ravi', 'M','E4',50000);

update employee
set gross=gross*1.10
where ecode=1001;

-- descuento 25% al precio de los libros cuya editorial es planeta
select * from libros;
update libros
set precio=precio*0.75 where editorial='Planeta';

-- 
insert into employee values(1002,'Akash','M','A1',35000);
insert into employee values(1004,'Neela','F','B2',38965);
insert into employee values(1005,'Sunny','M','A2',30000);
insert into employee values(1006,'Ruby','F','A1',45000);
insert into employee values(1009,'Neema','F','A2',52000);

select min(gross) from employee;
select max(gross) from employee;
select avg(gross) from employee;

select count(gender) from employee
where gender='F';

select gender from employee; -- me saldrán repetidos M y F, para evitarlo:
select distinct gender from employee;

select count(*) from employee; -- cuenta todas las filas
insert into employee values(1010,'Neema','','A2',52000);
select count(gender) from employee;-- no cuenta los valores nulos

-- ver kien cobra mas
select ename from employee where gross=(select max(gross) from employee); 

-- subir sueldo a las mujeres un 10%
update employee set gross=gross*1.10 where gender='F';

-- ejercicio endomo en ingles
update employee
set gross=58000, grade='B2'
where ecode=1009;
-- ejemplo 1
update employee
set gross = gross +100;
-- ejemplo 2
update employee
set gross=gross*2
where grade='A1'or grade='A2';
-- ejemplo 3
update employee
set grade='A2'
where ecode = 1004 and ename='Neema';

delete from employee where grade ='A1';

/* operador like
nombre like '%a'; que terminen en a
nombre like '__a'; los guiones bajos representan un caracter
nombre like 'p%'; empiece por p
nombre like '%p%'; que este p en medio


operador order by
select titulo from libro order by libro ASC (lo rodena en orden ascendente)
										DESC

select max(precio) from libros;
select min(precio) from libros;
select avg(precio) from libros;
select sum(precio) from libros;