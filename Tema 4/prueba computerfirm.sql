create database holacaracola;
drop database if exists holacaracola;
show databases;


use computerfirm;
show tables;
-- 1. Find the model number, speed and hard drive capacity for all the PCs with
-- prices below $500. Result set: model, speed, hd.
select * from pc;
select * from product;
select * from laptop;
select * from printer;

select model, speed, hd from pc where price < 500; 

-- 2. Find printer makers. Result set: maker.
select maker from product inner join printer on product.model=printer.model;

-- 3. Find the model number, RAM and screen size of the laptops with prices over
-- $1000.
select model, ram, screen from laptop where price > 1000;

-- 4. Find the model number, speed and hard drive capacity of the PCs having 12x
-- CD and prices less than $600 or having 24x CD and prices less than $600.
select model, speed, hd from pc where (cd = '12x' and price < 600) or (cd = '24x' and price < 600);

-- 5. Point out the maker and speed of the laptops having hard drive capacity more
-- or equal to 10 Gb.
select maker, speed from product inner join laptop on product.model=laptop.model where hd >= 10;

-- 6. Find out the models and prices for all the products (of any type) produced by
-- maker B.
select maker,pc.model, price from pc, product where pc.model=product.model and maker ='B'
union
select maker,laptop.model, price from laptop, product where laptop.model=product.model and maker ='B'
union
select maker,printer.model, price from printer, product where printer.model=product.model and maker ='B';

-- 7. Find out the makers that sale PCs but not laptops.
select maker from product, pc where product.model=pc.model and maker not in(
select maker from product, laptop where product.model=laptop.model);

-- 8. Find the printers having the highest price. Result set: model, price.
select code, price from printer where price=(select max(price) from printer);

-- 9. Find out the average speed of PCs.
select avg(speed) from pc;

-- 10. Find all the makers who have all their models of PC type in the PC table
select maker from product where type='PC' and model in (select model from pc);

-- 11. Find out the average speed of the PCs produced by maker A.
select avg(speed) from pc inner join product on product.model=pc.model where maker='A';

-- 12. Find the hard drive sizes that are equal among two or more PCs. Result set: hd.
select hd, count(*) from pc group by hd having count(*)>=2;

-- 13. Find the pairs of PC models having similar speeds and RAM. As a result, each
-- resulting pair is shown only once, i.e. (i, j) but not (j, i). Result set: model with
-- high number, model with low number, speed, and RAM.
select pc1.model, pc1.speed, pc2.speed, pc1.ram, pc2.ram from pc pc1 , pc pc2 
where pc1.model=pc2.model and pc1.speed=pc2.speed and pc1.ram=pc2.ram;


-- 14. Find the laptops having speeds less than all PCs. Result set: type, model, speed.
select speed from laptop where speed < (
select min(speed) from pc);

-- 15. Find the makers of the cheapest color printers. Result set: maker, Price

-- 16. Find the makers producing at least three distinct models of PCs. Result set:
-- maker, number of models.
-- 17. Find the makers producing at least both a pc having speed not less than 750
-- MHz and a laptop having speed not less than 750 MHz. Result set: Maker
-- 18. Find the model number of the product (PC, laptop, or printer) with the highest
-- price.Result set: model
-- 19. Find the printer makers which also produce PCs with the lowest RAM and the
-- highest-speed processor among PCs with the lowest RAM. Result set: maker.
-- 20. Define the average price of the PCs and laptops produced by maker A.Result
-- set: single total price.
-- 21. Define the average size of the PC hard drive for each maker that also produces
-- printers.Result set: maker, average capacity of HD.