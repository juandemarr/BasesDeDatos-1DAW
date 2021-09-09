drop database gimnasio;
create database gimnasio;
USE gimnasio;
create table monitor(
	dni int(11) primary key,
    nombre varchar(20),
    telefono varchar(9),
    titulacion varchar(10)
);
create table socio(
	dni int(11) primary key,
    nombre varchar(20),
    direccion varchar(20),
    telefono varchar(9)
);
create table aparatos(
	codigo int(11) primary key,
    descripcion varchar(10),
    estado varchar(10)
);
create table salas(
	numero int(11) primary key,
    superficie int(2),
    ubicacion varchar(10),
    tipo varchar(10)
);
create table clases(
	codigo int(11) primary key,
    descripcion varchar(10),
    DiaHora time
);
create table tienen(
	numero int(11),
    codigo int(11),
    primary key(numero,codigo),
    foreign key(numero) references salas(numero),
    foreign key(codigo) references aparatos(codigo)
);
create table se_imparten(
	numero int(11),
    codigo int(11),
    primary key(numero,codigo),
    foreign key(numero) references salas(numero),
    foreign key(codigo) references clases(codigo)
);
create table son_impartidas(
	codigo int(11),
    dni int(11),
    primary key(codigo, dni),
    foreign key (codigo) references clases(codigo),
    foreign key (dni) references monitor(dni)
);
create table asisten(
	dni int(11),
    codigo int(11),
    primary key(dni,codigo),
    foreign key (dni) references socio(dni),
    foreign key(codigo) references clases(codigo)
);

insert into Monitor values
(11,'Jose García','953333333','INEF'),
(22,'Ana Gil','963333334','INEF'),
(33,'Ana Martín','953333335','F.P.'),
(44,'Pepe Pérez','953333336','INEF');


insert into Socio values
(1,'Manolo Arcos','Libertad','95311111'),
(2,'Jose Rodríguez','Trinidad','95322222'),
(3,'Patricia Jiménez','Ancha','95322222'),
(4,'Soledad Martínez','Rastro','95322222'),
(5,'Inmaculada Pérez','Cava','95322222'),
(6,'Nicolás Ortega','Nueva','95322222'),
(7,'Federico Noriega','Trinidad','95322222'),
(8,'Rodríguez','Cava','95322222');

insert into Aparatos values
(1,'Banco','Bueno'),
(2,'Pesa','Malo'),
(3,'Colchón','Nuevo'),
(4,'Barra','Bueno'),
(5,'Banco','Nuevo'),
(6,'Pesa','Nuevo');

insert into Salas values
(1,10,'Planta 1','Cardio'),
(2,20,'Planta 1','Aerobic'),
(3,25,'Planta 1','Aerobic'),
(4,10,'Planta 2','Sauna'),
(5,10,'Planta 2','Masaje'),
(6,15,'Planta 2','Cardio');

insert into Clases values
(1,'Aerobic','9:00:00'),
(2,'Aerobic','10:00:00'),
(5,'Aerobic','14:00:00'),
(3,'Step','20:00:00'),
(4,'Spining','21:00:00');

insert into Tienen values
(4,4),(5,5),(2,1),(3,2),(3,3),(6,6);

insert into Se_Imparten values
(2,1),(2,2),(3,3),(3,4),(3,5);

insert into Son_Impartidas values
(1,11),(2,22),(3,33),(4,22),(5,33);

insert into Asisten values
(1,1),(1,5),(2,2),(3,4),(3,5),(4,3),(5,3),(6,3),(7,1),(7,5),(7,2),(8,4),(8,5);



select * from socio;
select * from monitor;
select * from son_impartidas;
select * from aparatos;
select * from clases;
select * from salas;
select * from se_imparten;
select * from aparatos;
select * from tienen;

-- 1. Nombre y teléfono de los socios del gimnasio que viven en Trinidad.
select nombre, telefono from socio where direccion="Trinidad";

-- 2. Nombre y teléfono del socio que vive en Cava.
select nombre, telefono from socio where direccion="Cava";

-- 3. Nombre y dirección de los socios que asisten a aeróbic.
select * from clases;

select nombre, direccion from socio, asisten, clases 
where socio.dni=asisten.dni and asisten.codigo=clases.codigo and descripcion="Aerobic";

-- 4. Nombre y dirección de los socios que asisten a step
select nombre, direccion from socio, asisten, clases 
where socio.dni=asisten.dni and asisten.codigo=clases.codigo and descripcion="Step";

-- 5. Nombre de los socios que asisten a las clases de Ana Gil.
select socio.nombre from socio, asisten, clases,son_impartidas,monitor 
where socio.dni=asisten.dni and asisten.codigo=clases.codigo and clases.codigo=son_impartidas.codigo and 
son_impartidas.dni=monitor.dni and monitor.nombre="Ana Gil";

-- 6. Nombre de los monitores que tiene titulación de la INEF.
select nombre from monitor where titulacion="INEF";

-- 7. Descripción de los aparatos nuevos.
select descripcion from aparatos where estado="nuevo";

-- 8. Nombre y dirección de los socios que asisten a clase antes de las 16:00 horas.
select nombre,direccion,diahora from socio, asisten, clases where socio.dni=asisten.dni and asisten.codigo=clases.codigo 
and diahora<"21:00:00";

-- 9. Número y tipo de las salas que tienen más de 12 metros cuadrados.
select numero, tipo from salas where superficie>12;

-- 10. Nombre de los alumnos de Pepe.
select socio.nombre from socio, asisten, clases, son_impartidas, monitor where socio.dni=asisten.dni 
and asisten.codigo=clases.codigo and clases.codigo=son_impartidas.codigo and son_impartidas.dni=monitor.dni and 
monitor.nombre like 'pepe%';

-- 11. Nombre de los socios que asisten a clase en la primera planta.
select socio.nombre, ubicacion from socio, asisten, clases, se_imparten, salas where
socio.dni=asisten.dni and asisten.codigo=clases.codigo and clases.codigo=se_imparten.codigo and se_imparten.numero=salas.numero
and ubicacion='Planta 1';

-- 12. Aparatos que están situados en la 1º planta.
select descripcion from aparatos,tienen,salas where aparatos.codigo=tienen.codigo and tienen.numero=salas.numero and ubicacion='Planta 1';

-- 13. Todas las clases y todos los alumnos que asisten a esas clases.
select clases.descripcion,socio.nombre from socio, asisten, clases where
socio.dni=asisten.dni and asisten.codigo=clases.codigo;

-- 14. Monitores y las clases que dan y a qué hora la dan.
select monitor.nombre,clases.descripcion,clases.diahora from monitor,son_impartidas,clases 
where monitor.dni=son_impartidas.dni and son_impartidas.codigo=clases.codigo;

-- 15. Clases que se dan en salas de más de 22 metros cuadrados.
select clases.descripcion,superficie from clases,se_imparten,salas where clases.codigo=se_imparten.codigo and se_imparten.numero=salas.numero
and superficie > 22;


-- monitores que imparten clases en salas con superficie superior a la media de las superficies de las salas.
select monitor.nombre from monitor,son_impartidas,clases,se_imparten,salas 
where monitor.dni=son_impartidas.dni and son_impartidas.codigo=clases.codigo and clases.codigo=se_imparten.codigo
and se_imparten.numero=salas.numero and salas.superficie>(select avg(superficie) from salas);

-- 16 nombre de los socios y numero de clases a las que asisten
select socio.nombre,count(clases.codigo) 
from socio,asisten,clases where socio.dni=asisten.dni 
and asisten.codigo=clases.codigo 
group by socio.nombre;

-- 17 nombre de los monitores y numero de clases que dan
select monitor.nombre,count(*) 
from monitor,clases,son_impartidas 
where monitor.dni=son_impartidas.dni and 
son_impartidas.codigo=clases.codigo 
group by monitor.nombre;

-- 18 socios que no asisten a ninguna clase
select nombre from socio where nombre 
not in(select socio.nombre 
from socio,asisten,clases where socio.dni=asisten.dni 
and asisten.codigo=clases.codigo);

insert into Socio values
(10,'Hola Arcos','Libertad','95311111');

select nombre,asisten.codigo from socio left join 
asisten on socio.dni=asisten.dni 
where asisten.codigo is null;

-- 19 monitores que imparten todas las clases
insert into Son_Impartidas values
(1,33),(2,33),(4,33);

select monitor.nombre from monitor,son_impartidas,clases 
where monitor.dni=son_impartidas.dni and 
son_impartidas.codigo=clases.codigo group by monitor.dni
having count(son_impartidas.codigo) = 
(select count(*) from clases);

/*select monitor.nombre,count(clases.codigo) from monitor,son_impartidas,clases where monitor.dni=son_impartidas.dni
and son_impartidas.codigo=clases.codigo group by monitor.dni having count(clases.codigo)=
(select count(*) from clases);*/

-- 20 nombre, direccion y telefono de los socios que usan colchon
select distinct nombre, direccion, telefono,aparatos.descripcion from socio,asisten,clases,se_imparten,salas,tienen,aparatos
where socio.dni=asisten.dni and asisten.codigo=clases.codigo and clases.codigo=se_imparten.codigo 
and se_imparten.numero=salas.numero and salas.numero=tienen.numero and tienen.codigo=aparatos.codigo
and aparatos.descripcion="colchon";

-- 21 socios que usen más de dos aparatos diferentes;
select socio.nombre,count(aparatos.codigo) from socio,asisten,clases,se_imparten,salas,tienen,aparatos
where socio.dni=asisten.dni and asisten.codigo=clases.codigo and clases.codigo=se_imparten.codigo 
and se_imparten.numero=salas.numero and salas.numero=tienen.numero and tienen.codigo=aparatos.codigo
group by socio.nombre having count(aparatos.codigo)>2;

-- 22 descripcion de aparatos que están en las clases de step
select aparatos.descripcion from clases,se_imparten,salas,tienen,aparatos
where clases.codigo=se_imparten.codigo and se_imparten.numero=salas.numero
and salas.numero=tienen.numero and tienen.codigo=aparatos.codigo
and clases.descripcion="step";

-- crear una vista con los alumnos de ana gil, se llama la vista alumnos_anagil
select monitor.nombre from 

-- VIEW
create view clases_matutinas as 
	(select * from clases where diahora<'15:00:00');

select * from clases_matutinas;

drop view clases_matutinas;