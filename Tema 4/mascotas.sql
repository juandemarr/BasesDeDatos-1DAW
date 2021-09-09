create database mascotas;
use mascotas;
CREATE TABLE mascotas (
    nombre VARCHAR(20),
    propietario VARCHAR(20),
    especie VARCHAR(20),
    sexo CHAR(1),
    nacimiento DATE,
    fallecimiento DATE,
    primary key(nombre, propietario)
);

select * from mascotas;
insert into mascotas values('Fluffy','Arnoldo','Gato','f','1999-02-04',null);
insert into mascotas values('Mau','Juan','Gato','m','1998-03-17',null);
insert into mascotas values('Buffy','Arnoldo','Perro','f','1999-05-13',null);
insert into mascotas values('FanFan','Benito','Perro','m','2000-08-27',null);
insert into mascotas values('Kaiser','Diana','Perro','m','1998-08-31','2012-07-29');
insert into mascotas values('Chispa','Omar','Ave','f','1998-09-11',null);
insert into mascotas values('Wicho','Tomás','Ave',null,'2000-02-09',null);
insert into mascotas values('Skim','Benito','Serpiente','m','2001-04-29',null);

-- 1. Cambia la fecha de nacimiento de Kaiser a 1989-08-31
update mascotas
set  nacimiento='1989-08-31' where nombre='Kaiser'; 

-- 2. Deseamos verificar el cambio que hicimos a la fecha de nacimiento de Kaiser
select * from mascotas;

-- 3. Deseamos conocer qué mascotas nacieron después del 2000
select * from mascotas where nacimiento>='2000-01-01';

-- 4. Deseamos conocer los nombres y los propietarios de las perras
select nombre, propietario from mascotas where especie='Perro' and sexo='f';

-- 5. Deseamos conocer los nombres y propietarios de las perras y las gatas
select nombre, propietario, especie, sexo from mascotas where (especie='Perro' or especie='Gato') and sexo='f';

-- 6. Deseamos conocer la fecha de nacimiento de nuestras mascotas
select nombre, nacimiento from mascotas where fallecimiento is null;

-- 7.  Conocer quién tiene alguna mascota
select nombre, propietario from mascotas where fallecimiento is null; -- select distinct es para que no salgan repetidos

-- 8. Obtener la fecha de nacimiento de los perros y los gatos
select nombre, especie, nacimiento from mascotas where especie='Perro' or especie='Gato';

-- 9. Nombre de las mascotas ordenadas for fecha de nacimiento
select nombre, nacimiento from mascotas order by nacimiento;

-- 10. Nombre de las mascotas ordenadas por fecha de nacimiento en orden inverso
select nombre, nacimiento from mascotas order by nacimiento DESC;

-- 11. Nombre de las mascotas ordenadas por especie y fecha de nacimiento en orden inverso
select nombre, especie, nacimiento from mascotas order by especie, nacimiento DESC;

-- 12. Nombre de las mascotas cuyo cumpleaños es el próximo mes
select nombre, nacimiento from mascotas where nacimiento like '%-02-%';

-- 13. Nombre de las mascotas que empiezan por B
select nombre from mascotas where nombre like 'B%';

-- 14. Nombre de las mascotas que terminan por fy
select nombre from mascotas where nombre like '%fy';

-- 15. Deseamos conocer cuántas mascotas tiene cada uno de los propietarios
select propietario, count(*) from mascotas group by  propietario;

-- 16. El número de animales por especie;
select * from mascotas;

-- 21 Seleccionar aquel propietario que tiene más mascotas
select propietario, count(*) from mascotas group by propietario order by count(*) desc limit 2; 

-- 22 Las edas de las mascotas que han fallecido
select nombre, TIMESTAMPDIFF(YEAR, nacimiento, fallecimiento) as añostranscurridos 
from mascotas where fallecimiento is not null; -- as es para indicar un alias a esa columna y que no aparezca la funcion como titulo, sino ese nombre
-- TIMESTAMPDIFF(YEAR / MONTH / DAY)

