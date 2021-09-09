drop database salesman;
create database salesman;
use salesman;
create table salesman(
	salesman_id numeric(5),
    name varchar(30),
    city varchar(15),
    commission decimal(5,2),
    primary key (salesman_id)
);

create table customer(
	customer_id numeric(5),
    cust_name varchar(30),
    city varchar(15),
    grade numeric(3),
    primary key(customer_id)
);

create table orders(
	ord_no numeric(5),
    purch_amt decimal(8,2),
    ord_date date,
    customer_id numeric(5),
    salesman_id numeric(5),
    primary key(ord_no),
    foreign key (salesman_id) references salesman(salesman_id),
    foreign key (customer_id) references customer(customer_id)
);

insert into salesman values (5001,'James Hoog','New York',0.15);
insert into salesman values (5002,'Nail Knite','Paris',0.13);
insert into salesman values (5005,'Pit Alex','London',0.11);
insert into salesman values (5006,'Mc Lyon','Paris',0.14);
insert into salesman values (5003,'Lauson Hen','San Jose',0.12);
insert into salesman values (5007,'Paul Adam','Rome',0.13);


insert into customer values (3002,'Nick Rimando','New York',100);
insert into customer values (3005,'Graham Zusi','California',200);
insert into customer values (3001,'Brad Guzan','London',100);
insert into customer values (3004,'Fabian Johns','Paris',300);
insert into customer values (3007,'Brad Davis','New York',200);
insert into customer values (3009,'Geoff Camero','Berlin',100);
insert into customer values (3008,'Julian Green','London',300);
insert into customer values (3003,'Jozy Altidor','Moncow',200);


insert into orders values (70001,'150.5','2012-10-05',3005,5002);
insert into orders values (70009,'270.65','2012-09-10',3001,5005);
insert into orders values (70002,'65.26','2012-10-05',3002,5001);
insert into orders values (70004,'110.5','2012-08-17',3009,5003);
insert into orders values (70007,'948.5','2012-09-10',3005,5002);
insert into orders values (70005,'2400.6','2012-07-27',3007,5001);
insert into orders values (70008,'5760.0','2012-09-10',3002,5001);
insert into orders values (70010,'1983.43','2012-10-10',3004,5006);
insert into orders values (70003,'2480.4','2012-10-10',3009,5003);
insert into orders values (70012,'250.45','2012-06-27',3008,5002);
insert into orders values (70011,'75.29','2012-08-17',3003,5007);
insert into orders values (70013,'3045.6','2012-04-25',3002,5001);



select * from salesman;
select * from customer;
select * from orders;

-- 1.- Write a SQL statement to prepare a list with salesman name, customer name and their
-- cities for the salesmen and customer who belongs to same city.
select distinct salesman.name,customer.cust_name,salesman.city,customer.city from salesman, customer,orders 
where salesman.salesman_id=orders.salesman_id and
customer.customer_id=orders.customer_id and salesman.city=customer.city;

-- 2.- Write a SQL statement to make a list with order no, purchase amount, customer name and
-- their cities for those orders which order amount between 500 and 2000.
select ord_no, purch_amt, cust_name, city from orders, customer where customer.customer_id=orders.customer_id 
and purch_amt between 500 and 2000;

-- 3.- Write a SQL statement to know which salesman are working for which customer.
select salesman.salesman_id,customer.customer_id from salesman, customer, orders 
where salesman.salesman_id=orders.salesman_id and orders.customer_id=customer.customer_id;

-- 4.- Write a SQL statement to find the list of customers who appointed a salesman for their
-- jobs who gets a commission from the company is more than 12%.
select cust_name,commission from customer, orders, salesman where customer.customer_id=orders.customer_id 
and orders.salesman_id=salesman.salesman_id and salesman.commission>0.12;

-- 5.- Write a SQL statement to find the list of customers who appointed a salesman for their
-- jobs who does not live in same city where there customer lives, and gets a commission is
-- above 12% .
select cust_name from customer,orders,salesman where customer.customer_id=orders.customer_id 
and orders.salesman_id=salesman.salesman_id 
and salesman.city not in (select city from customer) and commission>0.12; 

-- 6.- Write a SQL statement to find the details of a order i.e. order number, order date, amount
-- of order, which customer gives the order and which salesman works for that customer and
-- how much commission he gets for an order.
select ord_no, ord_date, purch_amt, orders.customer_id, orders.salesman_id, commission 
from orders, customer, salesman where orders.customer_id=customer.customer_id 
and orders.salesman_id=salesman.salesman_id;

-- 7.- Write a SQL statement to make a join within the tables salesman, customer and orders in
-- such a form that the same column of each table will appear once and only the relational rows
-- will come.
select distinct orders.salesman_id, orders.customer_id, salesman.name, salesman.city, commission ,ord_no,ord_date, purch_amt, cust_name, customer.city, grade 
from salesman inner join orders on salesman.salesman_id=orders.salesman_id 
inner join customer on orders.customer_id=customer.customer_id;

-- 8.- Write a SQL statement to make a list in ascending order for the customer who works either
-- through a salesman or by own.
select distinct cust_name from customer left join orders on customer.customer_id=orders.customer_id 
order by customer.customer_id asc;

-- 9.- Write a SQL statement to make a list in ascending order for the customer who holds a
-- grade less than 300 and works either through a salesman or by own.
select distinct cust_name from customer left join orders on customer.customer_id=orders.customer_id 
where grade < 300 order by cust_name asc;

-- 10.- Write a SQL statement to make a report with customer name, city, order number, order
-- date and order amount in ascending order according to the order date to find that either any
-- of the existing customer have placed no order or placed one or more orders.
select cust_name, city, ord_no, ord_date, purch_amt from customer left join orders 
on customer.customer_id=orders.customer_id order by ord_date asc;

-- 11.- Write a SQL statement to make a report with customer name, city, order number, order
-- date, order amount salesman name and commission to find that either any of the existing
-- customer have placed no order or placed one or more orders by their salesman or by own.
select cust_name, customer.city, ord_no, ord_date, purch_amt, name, commission 
from customer left join orders on customer.customer_id=orders.customer_id inner join salesman 
on orders.salesman_id=salesman.salesman_id;

-- 12.- Write a SQL statement to make a list in ascending order for the salesmen who works
-- either for one or more customer or not yet join under any of the customer.
select distinct salesman.name from salesman left join orders on salesman.salesman_id=orders.salesman_id 
order by salesman.name asc;

-- 13.- Write a SQL statement to make a list for the salesmen who works either for one or more
-- customer or not yet join under any of the customer who placed either one or more orders or
-- no order to their supplier.
select distinct salesman.name from salesman left join orders on salesman.salesman_id=orders.salesman_id 
right join customer on orders.customer_id=customer.customer_id;

-- 14.- Write a SQL statement to make a list for the salesmen who either work for one or more
-- customer or yet to join any of the customer. The customer, may have placed, either one or
-- more orders on or above order amount 2000 and must have a grade, or he may not have
-- placed any order to the associated supplier.
select salesman.name, purch_amt, grade from salesman left join orders on salesman.salesman_id=orders.salesman_id 
inner join customer on orders.customer_id=customer.customer_id where purch_amt > 2000 and grade is not null;

-- 15.- Write a SQL statement to make a report with customer name, city, order no. order date,
-- purchase amount for those customers from the existing list who placed one or more orders or
-- which order(s) have been placed by the customer who are not in the list.
select cust_name, customer.city, ord_no, ord_date, purch_amt from customer left join orders 
on customer.customer_id=orders.customer_id;

-- 16.- Write a SQL statement to make a report with customer name, city, order no. order date,
-- purchase amount for only those customers in the list who must have a grade and placed one
-- or more orders or which order(s) have been placed by the customer who are neither in the list
-- not have a grade.
select cust_name, customer.city, ord_no, ord_date, purch_amt from customer inner join orders 
on customer.customer_id=orders.customer_id where grade is not null union
select cust_name, customer.city, ord_no, ord_date, purch_amt from customer left join orders 
on customer.customer_id=orders.customer_id where orders.customer_id is null and grade is null;

-- 17.- Write a SQL statement to make a cartesian product between salesman and customer i.e.
-- each salesman will appear for all customer and vice versa.
select name, cust_name from salesman,customer;

-- 18.- Write a SQL statement to make a cartesian product between salesman and customer i.e.
-- each salesman will appear for all customer and vice versa for those customer who belongs to
-- a city.
select name, cust_name, customer.city from salesman,customer where cust_name in(select cust_name from customer where city is not null);

-- 19.- Write a SQL statement to make a cartesian product between salesman and customer i.e.
-- each salesman will appear for all customer and vice versa for those salesmen who belongs to
-- a city and the customers who must have a grade.
select name, cust_name from salesman,customer where cust_name in
(select cust_name from customer where city is not null) and grade is not null;

-- 20.- Write a SQL statement to make a cartesian product between salesman and customer i.e.
-- each salesman will appear for all customer and vice versa for those salesmen who must
-- belongs a city which is not the same as his customer and the customers should have a own
-- grade.
select name, cust_name, salesman.city, customer.city from salesman,customer where salesman.city != customer.city and grade is not null;
