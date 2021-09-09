show databases;
use computerfirm;
drop database computerfirm;

create database computerfirm;
use computerfirm;
create table product(
	maker varchar(10),
    model varchar(50),
    type varchar(50),
    primary key (model)
);

create table laptop(
	code int not null,
    model varchar (50) not null,
    speed smallint not null,
    ram smallint not null,
    hd real not null,
    price float,
    screen tinyint not null
);
alter table laptop add constraint primary key(code);
alter table laptop add constraint foreign key(model) references product(model);

create table pc(
	code int not null,
    model varchar(50) not null,
    speed smallint not null,
    ram smallint not null,
    hd real not null,
    cd varchar(10) not null,
    price float,
    primary key(code),
    foreign key(model) references product(model)
);

create table printer(
	code int not null,
    model varchar(50) not null,
    color char(1) not null,
    type varchar(50) not null,
    price float,
    primary key (code),
    foreign key (model) references product(model)
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

-- alter table con primary key
alter table product drop primary key;
describe product;
alter table product add constraint primary key(model);

-- alter table con foreign key
show create table pc; -- buscamos el codigo referencia de la foreign key y lo usamos
-- en la siguiente
alter table pc drop foreign key pc_ibfk_1;
alter table pc add constraint foreign key(model) references product(model);

-- delete from pc;
-- drop table pc;
show tables;
describe laptop;
describe pc;
describe product;
describe printer;

-- alter table con add column
alter table pc add column hora int;
describe pc;

update pc set hora=1 where code=1;
select * from pc;
-- borrar contenido de una columna
update pc set hora=null where code=1;

-- borrar columna
alter table pc drop column hora;
use computerfirm;
select * from printer;
-- 15. Find the makers of the cheapest color printers. Result set: maker, Price
select maker, price from product,printer where product.model=printer.model and printer.model in(
select model, min(price) from printer where model in(select model from printer where color='y'));


-- 16. Find the makers producing at least three distinct models of PCs. Result set: maker, number of models.

-- 17. Find the makers producing at least both a pc having speed not less than 750
-- MHz and a laptop having speed not less than 750 MHz. Result set: Maker


-- 18. Find the model number of the product (PC, laptop, or printer) with the highest price.Result set: model


-- 19. Find the printer makers which also produce PCs with the lowest RAM and the
-- highest-speed processor among PCs with the lowest RAM. Result set: maker.


-- la buena


-- 20. Define the average price of the PCs and laptops produced by maker A.Result set: single total price.


-- 21. Define the average size of the PC hard drive for each maker that also produces 
-- printers.Result set: maker, average capacity of HD.
