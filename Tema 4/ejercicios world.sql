use world;

show tables; -- city, country, countylanguage

describe city;

select * from city limit 10; -- limit establece un limite de filas que serán visualizadas

-- 1.- Show three of the five columns of the City table. There are lots of rows in the table. We limit the query to the
-- first 10 rows
select ID, Name, CountryCode from city limit 10;

-- 2.- The LIMIT clause can be followed by two numbers. The first one is the offset and the second one is
-- the number of rows to display. Show rows 16-20. El primer numero es el comienzo y el segundo la longitud
select ID, Name, CountryCode from city limit 15, 5;

-- 3.- There are 4079 cities in the table. We use the built-in COUNT() function to find out the number of rows;
select count(*) as CountryNumbers from city;

-- 4.- Show the most populated city in the table.
select Name, population from city where population=(select max(population) from city);

-- 5.- Show the least populated city in the table.
select Name, population from city where population=(select min(population) from city);

-- 6.- Returns all cities with a population above one million people
select name, population from city where population > 1000000;

-- 7.- Select all city names which begin with Kal.
select name from city where name like 'Kal%';

-- 8.- Select all columns for one specific city, namely Bratislava.
select * from city where name = 'Bratislava';

-- 9.- Find cities with a population in the range 670,000 and 700,000.
select name, population from city where population between 670000 and 700000;

-- 10.- Find the 10 most populated cities.
select name, population from city order by population desc limit 10;

-- 11.- Get the 10 least populated cities
select name, population from city order by population asc limit 10;

-- 12.- Order data by city name and get the first ten cities
select name from city order by name asc limit 10;

-- 13.- The total number of people in the towns of the New York.
select name, population from city where name='New York';

-- 14.- Select all districts of USA which have population over 3 million people.
select * from country where region = 'North America' and population > 3000000;

-- 15.- The name of the HeadofState. If the database is outdated updated it.
select * from country;
select name, HeadOfState from country;

-- número de países que hablan español
select * from countrylanguage;
select language, count(language) as numero from countrylanguage where language="Spanish";

-- nombre de los paises en los que se habla español
select name, language from country, countrylanguage
where language='Spanish' and country.code=countrylanguage.countrycode;

-- número de las ciudades que están en asia
select * from city;
select count(*) from city, country where countrycode=code and continent='Asia';

-- nombre de las ciudades europeas ordenadas de mayor a menor
select city.name, continent, city.population from city,country where continent='Europe' and countrycode=code order by city.population desc;

-- número de idiomas que se habla en eeuu
select count(*) from countrylanguage, country where countrycode=code and name='United States';

-- idioma oficial en eeuu
select country.name, language from country, countrylanguage where isofficial='T' and countrycode=code and name='United States';

-- nombre de las capitales de los paises en los que se habla francés
select city.name, language from city, country, countrylanguage where id=capital and code=country.code and language='french';

-- nombre de las capitales de los paises en los que el francés es el idioma oficial
select city.name, language, isofficial from city, country, countrylanguage where city.id=country.capital and country.code=countrylanguage.countrycode and language='french' and isofficial='t';

-- nombre de las ciudades de menos de 100000 habitantes en las que se habla francés y la esperanza de vida
-- en el país es superior a la media del mundo
select city.name, country.LifeExpectancy from city, country, countrylanguage 
where city.population<100000 and countrylanguage.language='french' 
and city.countrycode=country.code and country.code=countrylanguage.countrycode and
LifeExpectancy>(select avg(LifeExpectancy) from country);

-- Nombre de los continentes y numero de habitantes de cada continentes
select continent, sum(population) as "number of people" from country group by continent;

-- Nombre del continente mas poblado
select * from city;
select * from country;
select * from countrylanguage;

select continent, sum(population) from country group by continent order by sum(population) desc limit 1;

/* nombre de los idiomas que se hablan en asia
select continent, count(*) as languages from country, countrylanguage 
where country.code=countrylanguage.countrycode and continent='Asia';
*/
-- Nombre del continente en el que se hablan más idiomas
select continent, count(*) as languages from country, countrylanguage 
where country.code=countrylanguage.countrycode group by continent order by count(*) desc limit 1;
