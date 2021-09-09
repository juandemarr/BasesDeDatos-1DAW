create database cientifico;
use cientifico;
create table cientifico(
	dni varchar(20),
    nombre varchar(30),
    apellido varchar(30),
    fecha_nacimiento date,
    primary key(dni)
);
create table asignado(
	dni varchar(20),
    codigo varchar(30),
    primary key(dni,codigo),
    foreign key(dni) references cientifico(dni),
	foreign key (codigo) references proyecto(codigo)
);
create table proyecto(
	codigo varchar(30),
	nombre varchar(30),
	horas int(10),
	primary key(codigo)
); 

-- show tables from cientifico;
-- drop table cientifico;
-- drop table asignado;
-- drop table proyecto;


insert into cientifico values (1,"María", "Guzmán", "1974/02/12");
insert into cientifico values (2, "María", "Jiménez", "1954/02/11");
insert into cientifico values (3, "Rafael", "Girado", "1964/01/22");
insert into cientifico values (4, "Alonso", "Gómez", "1990/12/12");
insert into cientifico values (5, "Clara", "Antúnez", "1973/11/12");

insert into asignado values (1,"A");
insert into asignado values (1, "B");
insert into asignado values (1,"C");

insert into asignado values (2,"A");

insert into asignado values (3,"A");
insert into asignado values (2,"B");
insert into asignado values (4,"C");

insert into asignado values (4,"A");
insert into asignado values (4,"B");
insert into asignado values (4,"E");
insert into asignado values (4,"D");

insert into proyecto values ("A", "Bioquimica" ,410);
insert into proyecto values ("B", "Electrónica" ,1200);
insert into proyecto values ("C", "Geología" ,300);
insert into proyecto values ("D", "Tectónica" ,500);
insert into proyecto values ("E", "Histograma" ,70);

select * from cientifico;
select * from asignado;
select * from proyecto;

-- 1.- Relación completa de los científicos asignados a cada proyecto. Mostrar DNI, Nombre del
-- científico, Identificador del proyecto y nombre del proyecto.
select cientifico.dni, cientifico.nombre, proyecto.codigo, proyecto.nombre from cientifico inner join asignado 
on cientifico.dni=asignado.dni
inner join proyecto on asignado.codigo=proyecto.codigo;

-- 2.- Obtener el número de proyectos al que está asignado cada científico (mostrar el DNI y el nombre).
select cientifico.dni,cientifico.nombre,tabla1.total from cientifico inner join (
select dni, count(*) as total from asignado group by dni) as tabla1 on cientifico.dni=tabla1.dni;

-- 3.- Obtener el número de científicos asignados a cada proyecto (mostrar el identificador del
-- proyecto y el nombre del proyecto).
select proyecto.codigo,proyecto.nombre,tabla1.num_cientificos from proyecto inner join(
select codigo, count(*) as num_cientificos from asignado group by codigo) as tabla1 on proyecto.codigo=tabla1.codigo;

-- 4.- Obtener el número de dedicación de cada científico.
select cientifico.nombre, sum(proyecto.horas) from cientifico inner join asignado on cientifico.dni=asignado.dni
inner join proyecto on asignado.codigo=proyecto.codigo group by cientifico.dni; 

-- 5.- Obtener el DNI y el nombre de los científicos que se dedican a más de un proyecto y cuya
-- dedicación media a cada proyecto sea superior a las 80 horas.
select nombre, tabla1.dni,tabla1.total_proyectos from cientifico inner join (
select dni,count(*) as total_proyectos from asignado  group by asignado.dni having count(*) > 1 )
 as tabla1 on cientifico.dni=tabla1.dni;

select sum(proyecto.horas)
-- 6.- Nombre del científico que trabaja en todos los proyectos.
select nombre from cientifico inner join (
select dni, count(*) from asignado group by dni having count(*) = (select count(*) from proyecto)) as tabla1 
on cientifico.dni = tabla1.dni;

-- 7.- Nombre del científico que no trabaja en ningún proyecto.
select cientifico.nombre from cientifico inner join(
select dni, count(*) from asignado group by dni having count(*) = 0) as tabla1 on cientifico.dni=tabla1.dni;