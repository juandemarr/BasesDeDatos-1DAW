create table mascotas(
  nombre varchar2(20) primary key,
  propietario varchar2(20),
  especie varchar2(20),
  sexo char(1),
  nacimiento nvarchar2(10),
  fallecimiento nvarchar2(10)
);

insert into mascotas values('Fluffy','Arnoldo','Gato','f','1999-02-04',null);
insert into mascotas values('Mau','Juan','Gato','m','1998-03-17',null);
insert into mascotas values('Buffy','Arnoldo','Perro','f','1999-05-13',null);
insert into mascotas values('FanFan','Benito','Perro','m','2000-08-27',null);
insert into mascotas values('Kaiser','Diana','Perro','m','1998-08-31','2012-07-29');
insert into mascotas values('Chispa','Omar','Ave','f','1998-09-11',null);
insert into mascotas values('Wicho','TomÃ¡s','Ave',null,'2000-02-09',null);
insert into mascotas values('Skim','Benito','Serpiente','m','2001-04-29',null);

select * from mascotas2;

rename mascotas to mascotas2;

create table articulo(
  cold number(7),
  nombre varchar2(25),
  precio number(11,2) default 3.5
);

insert into articulo (cold, nombre) values('1','lápiz');

drop table cliente;
create table cliente (
  dni varchar(9) not null
);


-- -----------------------------------------------------------------------------------

create table cliente(
dni varchar2(9),
nombre varchar2(50),
constraint dni_sinnulos primary key(dni)
);

describe cliente;

create table pelicula(
  cod number(5) primary key,
  titulo varchar2(20),
  año varchar2(20),
  duracion_minutos number(5)
);

create table alquiler(
  dni varchar2(9),
  cod_pelicula number(5),
  constraint alquiler_pk primary key(dni,cod_pelicula),
  constraint dni_fk foreign key(dni) references cliente(dni),
  constraint pelicula_fk foreign key(cod_pelicula) references pelicula(cod)
);

insert into alquiler values('123456',5);
insert into cliente values('123456', 'María');
insert into pelicula values(5,'ET','1982',120);
insert into pelicula values(1,'The Goonies','1983',115);
insert into cliente values('1234567','Pepe');
insert into pelicula values(2,'Volver a empezar','1984',130);
insert into alquiler values('123456',2);
insert into cliente values('123456778','Manolo');


select * from cliente;
select * from pelicula;
select * from alquiler;

-- PROBAR QUÉ JOINS FUNCIONAN EN ORACLE LEFT JOIN, RIGHT JOIN, INNER JOIN...
-- mostrar los clientes que hayan alquilado alguna película
select distinct nombre from cliente inner join alquiler on cliente.dni=alquiler.dni;

-- mostrar los clientes que hayan alquilado más de una película
select nombre,count(cod_pelicula) from cliente inner join alquiler on cliente.dni=alquiler.dni group by nombre having count(cod_pelicula)>1;
-- si hay mas cosas en el select antes o después del count, hay que incluirlas en el group by para que no de error

-- mostrar las películas que no han sido alquiladas
select cod from pelicula where cod not in(select cod_pelicula from alquiler);

select titulo from pelicula left join alquiler on pelicula.cod=alquiler.cod_pelicula where cod_pelicula is null;


-- mostrar las películas que empiezan por v
select titulo from pelicula where titulo like 'V%';

-- mostrar los clientes que empiezan por m
select nombre from cliente where nombre like'M%';

-- mostrar los clientes que todavía no han alquilado ninguna película
select dni,nombre from cliente where dni not in(select dni from alquiler);

select nombre from cliente left join alquiler on cliente.dni=alquiler.dni where cod_pelicula is null;


-- mostrar las películas que duran más que la media de las películas
select titulo,duracion_minutos from pelicula where duracion_minutos > (select avg(duracion_minutos) from pelicula);


-- mostrar la película que ha sido más alquilada
select titulo from pelicula where cod in (select cod_pelicula from alquiler,pelicula where pelicula.cod=alquiler.cod_pelicula 
group by cod_pelicula having count(cod_pelicula)= 
(select max(maximo) from (select count(cod_pelicula) as maximo, cod_pelicula from alquiler group by cod_pelicula)));

------------------------------------------------------------------------------------------------------------

-- para introducir algo desde teclado
select titulo from pelicula where cod=&codigo_de_la_pelicula;

-------------------------------------------------------------------------------------------------------------

create user prueba
identified by prueba;

grant create session to prueba;
grant create table to prueba;

create role ventas;
grant create session to ventas;
grant create table to ventas;
grant create view to ventas;
grant ventas to prueba;

---------------
revoke create table from prueba;
