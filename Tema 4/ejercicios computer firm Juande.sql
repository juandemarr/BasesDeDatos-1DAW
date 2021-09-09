create database computerfirm;
use computerfirm;
create table product(
	maker varchar(10),
    model varchar(50),
    type varchar(50),
    primary key(model)
);
create table PC(
	code int,
    model varchar(50),
    speed smallint,
    ram smallint,
    hd real,
    cd varchar(10),
    price real,
    primary key(code),
    foreign key(model) references product(model)
);
create table laptop(
	code int, 
    model varchar(50),
    speed smallint,
    ram smallint,
    hd real,
    price real,
    screen tinyint,
    primary key(code),
    foreign key(model) references product(model)
);
create table printer(
	code int,
    model varchar(50),
    color char(1),
    type varchar(10),
    price real,
    primary key(code),
    foreign key(model) references product(model)
);

insert into product values

('A','1232','PC'),

('A','1233','PC'),

('A','1276','Printer'),

('A','1298','Laptop'),

('A','1401','Printer'),

('A','1408','Printer'),

('A','1752','Laptop'),

('B','1121','PC'),

('B','1750','Laptop'),

('C','1321','Laptop'),

('D','1288','Printer'),

('D','1433','Printer'),

('E','1260','PC'),

('E','1434','Printer'),

('E','2112','PC'),

('E','2113','PC');

insert into pc values

('1','1232',500,64,5.0,'12x',600),

('10','1260',500,32,10.0,'12x',350),

('11','1233',900,128,40.0,'40x',980),

('12','1233',800,128,20.0,'50x',970),

('2','1121',750,128,14.0,'40x',850),

('3','1233',800,64,5.0,'12x',600),

('4','1121',600,128,14.0,'40x',850),

('5','1121',600,128,8.0,'40x',850),

('6','1233',750,128,20.0,'50x',950),

('7','1232',500,32,10.0,'12x',400),

('8','1232',450,64,8.0,'24x',350),

('9','1232',450,32,10.0,'24x',350)

;

insert into laptop values

(1,'1298',350,32,4.0,700,11),

(2,'1321',500,64,8.0,970,12),

(3,'1750',750,128,12.0,1200,14),

(4,'1298',600,64,10.0,1050,15),

(5,'1752',750,128,10.0,1150,14),

(6,'1298',450,64,10.0,950,12)

;

insert into printer values

(1,'1276','n','laser',400),

(2,'1433','y','jet',270),

(3,'1434','y','jet',290),

(4,'1401','n','matrix',150),

(5,'1408','n','matrix',270),

(6,'1288','n','laser',400);

select * from product;
select * from PC;
select * from laptop;
select * from printer;

-- 1. Find the model number, speed and hard drive capacity for all the PCs with 
-- prices below $500. Result set: model, speed, hd.
select model, speed, hd from pc where price<500;

-- 2. Find printer makers. Result set: maker.
select distinct maker from product where type="Printer";
-- otra forma
select maker from product where type="Printer" group by maker;

-- 3. Find the model number, RAM and screen size of the laptops with prices over $1000.
select model, ram, screen from laptop where price > 1000;

-- 4. Find the model number, speed and hard drive capacity of the PCs having 12x
-- CD and prices less than $600 or having 24x CD and prices less than $600.
select model, speed, hd, cd from pc where (cd='12x' and price<600) or (cd='24x' and price<600);

-- 5. Point out the maker and speed of the laptops having hard drive capacity more or equal to 10 Gb.
select maker, speed,hd from laptop,product where laptop.model=product.model and hd>=10;
-- inner join
select maker,speed from product inner join laptop on product.model=laptop.model where hd>=10

-- 6. Find out the models and prices for all the products (of any type) produced by maker B.
select code, product.model,pc.price from product,pc where product.model=pc.model and maker='B'
union
select code, product.model,laptop.price from product,laptop where product.model=laptop.model and maker='B'
union
select code, product.model,printer.price from product,printer where product.model=printer.model and maker='B';
-- si no se pone la columna code, se pondria union all


-- 7. Find out the makers that sale PCs but not laptops.
select maker from product,pc where product.model=pc.model and maker not in
(select maker from product, laptop where product.model=laptop.model);

-- 8. Find the printers having the highest price. Result set: model, price.
select model, price from printer where price=(select max(price) from printer);

-- 9. Find out the average speed of PCs.
select avg(speed) from pc;

-- 10. Find all the makers who have all their models of PC type in the PC table
select distinct maker from product where type='PC' and maker not in 
(select maker from product where type='PC' and model not in(select model from pc));

select product.maker, product.model, pc.model
from product left join pc
on product.model=pc.model
where product.type='PC' and pc.model is null; -- el is null te ahorra tener que restarle la interseccion, where not in inner join
-- para este ej seria sin el is null

-- 11. Find out the average speed of the PCs produced by maker A.
select avg(speed) from product, pc where product.model=pc.model and maker='A';

-- 12. Find the hard drive sizes that are equal among two or more PCs. Result set: hd.
select hd, count(*) from pc group by hd having count(*)>=2; 
-- otra forma
select distinct t.hd from pc t where exists(select * from pc);

-- 13. Find the pairs of PC models having similar speeds and RAM. As a result, each
-- resulting pair is shown only once, i.e. (i, j) but not (j, i). Result set: model with
-- high number, model with low number, speed, and RAM.
select distinct p1.model as 'modelP1',p2.model as 'modelP2', p1.ram as 'ramP1',p2.ram as 'ramP2',p1.speed as 'speedP1',p2.speed as 'speedP2' 
from pc p1,pc p2 where p1.speed=p2.speed and p1.ram=p2.ram;

-- 14. Find the laptops having speeds less than all PCs. Result set: type, model, speed.
select type, laptop.model, speed from product, laptop where product.model=laptop.model and speed <ALL(select speed from pc);
-- otra forma
select type, laptop.model, speed from product, laptop where product.model=laptop.model and speed < (select min(speed) from pc);

-- 15. Find the makers of the cheapest color printers. Result set: maker, Price
select maker, price from product, printer where product.model=printer.model and 
price=(select min(price) from printer where color='y') and color='y';

-- 16. Find the makers producing at least three distinct models of PCs. Result set: maker, number of models.
select maker, count(*) as "number of models" from product where type='PC' group by maker having count(*) >= 3;

-- 17. Find the makers producing at least both a pc having speed not less than 750
-- MHz and a laptop having speed not less than 750 MHz. Result set: Maker
select distinct maker from product, pc where speed>=750 and product.model=pc.model and maker in
(select maker from product,laptop where product.model=laptop.model and speed>=750);

-- 18. Find the model number of the product (PC, laptop, or printer) with the highest price.Result set: model
select model,max(price) from
(select model, price from pc where price=(select max(price) from pc) union
select model, price from laptop where price=(select max(price) from laptop) union
select model, price from printer where price=(select max(price) from printer)) as maxprices
where price=(select max(price) from(
select model, price from pc where price=(select max(price) from pc) union
select model, price from laptop where price=(select max(price) from laptop) union
select model, price from printer where price=(select max(price) from printer)) as maxprices);


-- 19. Find the printer makers which also produce PCs with the lowest RAM and the
-- highest-speed processor among PCs with the lowest RAM. Result set: maker.
select distinct maker from product where type='Printer' and maker in
(select maker from product,pc where product.model=pc.model and 
type='PC' and pc.model in(
select model from pc where ram = (select min(ram) from pc)));
-- la buena
select distinct maker from product,pc where product.model = pc.model
and ram=(select min(ram) from pc) and speed=(select max(speed) from pc where ram=(select min(ram) from pc) and maker in
(select maker from product where type='Printer'));

-- 20. Define the average price of the PCs and laptops produced by maker A.Result set: single total price.
select avg(price) from (
select price from pc, product where maker='A' and product.model=pc.model union
select price from laptop, product where maker='A' and product.model=laptop.model)as mediatabla;

-- 21. Define the average size of the PC hard drive for each maker that also produces 
-- printers.Result set: maker, average capacity of HD.
select maker,avg(hd) from product,pc where maker in(select maker from product where type='Printer') and product.model=pc.model group by maker;




