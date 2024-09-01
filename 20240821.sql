-- comment
-- database -> table (row x column)
create database db_bc2405p;

-- login
use db_bc2405p;

-- Table name is per database
create table customers (
	id int,
    name varchar(50),
    email varchar(50)
);

-- insert into table_name (column1_name, .... ) values (column1_value, .....);
insert into customers (id, name, email) values (1, 'John Lau', 'john@gmail.com');
insert into customers (id, name, email) values (2, 'Peter Wong', 'peter@gmail.com');

-- "*" means all columns
-- "where" means conditions
select * from customers;
select * from customers where id = 2;
select * from customers where id = 1 or id = 2;
select * from customers where id = 1 and id = 2; -- no data matches this criteria
select name, email from customers where id = 1; -- John, john@gmail.com

-- order by 
select * from customers order by id; -- asc
select * from customers order by id asc; 
select * from customers order by id desc;

-- select, where (filter), order by (sort)
select * from customers where id = 1 order by id desc;

create table students (
	id integer, -- int
    name varchar(20),
    weight numeric(5,2), -- 5-2 (integer), 2 (decimal place)
    height numeric(5,2)
); 

insert into students (id, name, weight, height) values (1, 'John Wong', 60.7, 165.50);
insert into students (id, name, weight, height) values (2, 'Peter Wong', 65.7, 170);
insert into students (id, name, weight, height) values (3, 'Jenny Wong', 68.55, 180.5);
insert into students (id, name, weight, height) values (4, 'Jenny Wong', 90.35, 177.5);
insert into students (id, name, weight, height) values (5, 'Sally Cheung', 68.535, 177.5);


select * from students;
-- create table -> datetime, integer, numeric(10,2), varchar(10)


-- you can skip some column(s) when you execute insert statement
insert into students (id, name, weight) values (7, 'Benny Wong', 66.7);
select * from students;

-- If you don't specify the columns name, then you have to put all column values
insert into students values (8, 'Steven Wong', null, 165.7);

-- DDL (Data Definition Language) : create/drop table, add/drop column, modify column definition, 
-- DML (Data Manipulation Language) : insert row, update column, delete row, truncate table (only remove all data)

-- +, - , x, /, %
select weight + height as ABC, weight, height, id, name from students;

select s.weight + s.height as DEF, s.* from students s where s.weight > 65.5 order by name;

-- >, <, >=, <=, <>,!=, =
select * from students where id <> 6 and id <> 8;

-- not in
select * from students where id not in (6, 8);
select * from students where id in(1, 2, 3);

-- like, not like
select * from students where name = 'John Wong';
select * from students where name like '%Wong%'; -- Any name with prefix (o or more characters) and suffix (0 or more character)
select * from students where name like '%Wong'; -- end with Wong

select * from students where name not like '%Wong'; -- not end with Wong

-- Null check
select * from students where weight is null or height is null;

-- Functions
insert into students (id, name, weight, height) values (9, '張小強', 68.45, 177.8);
select char_length(s.name) as name_char_length, length(s.name) as name_length, s.* from students s;

-- substring() ->> start from 1
select upper(s.name), lower(s.name), substring(s.name, 1, 3), trim(s.name), replace(s.name, 'Wong', 'Chan'), s.* from students s;

-- Java: indexOf(), DB: instr() return position
-- position starts from 1
-- if not found, return 0
select instr(s.name, 'Wong'), s.* from students s;


create table orders (
	id integer,
    total_amount numeric(10,2),
    customer_id integer
);

select * from orders;
insert into orders values (1, 2005.10, 2);
insert into orders values (2, 10000.9, 2);
insert into orders values (3, 99.9, 1);

-- sum()
-- 3ms (without network consideration)
select sum(o.total_amount) from orders o;
select avg(o.total_amount) from orders o where customer_id = 2;

-- filter first, and then min(), max()
select min(o.total_amount), max(o.total_amount) from orders o where customer_id = 2;
select min(o.total_amount), max(o.total_amount) from orders o;

select o.*, 1 as number, 'hello' as string from orders o;

-- why can we put all functions in select statement?
-- Ans: Aggregation Functions
select min(o.total_amount), max(o.total_amount), sum(o.total_amount), avg(o.total_amount), count(o.total_amount) from orders o;
select min(o.total_amount), max(o.total_amount), sum(o.total_amount), avg(o.total_amount), count(1) from orders o;

-- 0.total_amount -> NOT an aggregate result
select o.total_amount, sum(o.total_amount) from orders o; -- error , NOT make sense
select o.total_amount, min(o.total_amount) from orders o; -- error , NOT make sense
select o.total_amount, max(o.total_amount) from orders o; -- error , NOT make sense

-- group by
select sum(total_amount) from orders where customer_id = 1;
select sum(total_amount) from orders where customer_id = 2;

-- group by -> select "group key" and agg functions
-- o.* -> group information or individual data information?
select o.customer_id, sum(o.total_amount), avg(o.total_amount), min(o.total_amount), max(o.total_amount), count(1)
from orders o group by o.customer_id; -- OK

select o.customer_id, sum(o.total_amount), o.id from orders o group by o.customer_id; -- NOT OK, why?

1 99.9
2 12006

-- group by "unique key" -> meaningless
select o.id, sum(o.total_amount) from orders o group by o.id

-- GROUP BY + HAVING
insert into orders values (4, 10000.9, 3);
insert into orders values (5, 20000, 3);

select o.customer_id, avg(o.total_amount) 
from orders o 
where o.customer_id in (2, 3) -- first filter before group by (5 row -> 4 rows, 4 x 3) -> result: 4 rows x 3 columns
group by o.customer_id -- result: 2 rows x 2 columns
having avg(o.total_amount) > 10000 -- another filter after group by (result): 1 row x 2 columns
order by avg(o.total_amount) 
;

-- 2 tables ( one to many)
-- where, group by, having, order by

-- example: authors and books

select * from customers where name = 'JOHN LAU'; -- case insenstive
select * from customers where UPEER (name) = 'JOHN LAU'; -- if case senitive, we should use upper () or lower ()


select * from customers where name like '%HN%';
select * from customers where name like 'JO%LAU';

select * from customers where name like '_OHN%';
select * from customers where name like '_HN%';

select ROUND(total_amount, 0), o.* from orders o;

select ceil(o.total_amount),floor(o.total_amount), ROUND(total_amount, 0), o.* from orders o;

select POWER(2, 3.5) AS result;

select 1, ABS(-5) from dual;

-- Date formatting (MYSQL)
select date_format('2023-08-31', '%Y-%m-%d') from dual;
select date_format('2023-08-31', '%Y-%m-%d') + INTERVAL 1 DAY from dual;
select str_to_date('2023-08-31', '%Y-%m-%d') + INTERVAL 1 DAY from dual;

-- Oracle
select to_date('20230831', 'YYYYMMDD') + 1 from dual;

-- Extract Year or Month or Day (MySQL)
SELECT EXTRACT(YEAR FROM date_format('2023-08-31', '%Y-%m-%d')) from dual;
SELECT EXTRACT(MONTH FROM date_format('2023-08-31', '%Y-%m-%d')) from dual;
SELECT EXTRACT(DAY FROM date_format('2023-08-31', '%Y-%m-%d')) from dual;

Result:
2024 2
2023 2
2022 1

select EXTRACT(YEAR from tran_date) as YEAR, count(1) as NUMBER_OF_ORDERS
from orders
group by EXTRACT(YEAR from tran_date)
having count(1) >= (2);



select * from orders;
alter table orders add column tran_date date; -- DDL

update orders
set tran_date = DATE_FORMAT('2023-08-31', '%Y-%m-%d')
where id = 1;

update orders
set tran_date = DATE_FORMAT('2024-08-02', '%Y-%m-%d')
where id = 2;

update orders
set tran_date = DATE_FORMAT('2023-12-04', '%Y-%m-%d')
where id = 3;

update orders
set tran_date = DATE_FORMAT('2024-02-28', '%Y-%m-%d')
where id = 4;

update orders
set tran_date = DATE_FORMAT('2022-06-01', '%Y-%m-%d')
where id = 5;

-- COALESCE / IFNULL doesn't update the original data
select ifnull(s.weight, 'N/A'), ifnull(s.height, 'N/A'), s.* from students s;
select COALESCE(s.weight, 'N/A'), COALESCE(s.height, 'N/A'), s.* from students s;

-- < 2000 'S' 
-- >= 2000 and <= 10000 -> 'M'
-- >= 1000 -> 'L'
select CASE WHEN o.total_amount < 2000 THEN 'S'
			WHEN o.total_amount  between 2000 and 10000 THEN 'M'
			ELSE 'L'
		END AS category
	,o.*
 from orders o;
 
 
 -- between (inclusive)
select * 
from orders 
where tran_date between DATE_FORMAT('2023-08-31', '%Y-%m-%d')
and DATE_FORMAT('2023-12-04', '%Y-%m-%d');


-- EXISTS (custoemrs, orders)
-- Find the customer(s) who has order(s)

insert into customers values (3, 'Jenny Yu', 'jenny@hotmail.com');
insert into customers values (4, 'Benny Kwok', 'benny@hotmail.com');
select * from customers;
select * from orders;

-- "o.customer_id = c.id" -> check if the customer exists in orders
-- Approach 1 (you cannot select columns from order table)
select *
from customers c
where exists (select 1 from orders o where o.customer_id = c.id);

-- JOIN tables
-- 4 customers x 6 orders -> 24 rows
select *
from customers c inner join orders o; -- on

-- INNER JOIN is similar to EXISTS
-- Approach 2
select c.id, c.name, o.total_amount;
select distinct c.id, c.name
from customers c inner join orders o on o.customer_id = c.id;




select *
from customers c
where not exists (select 1 from orders o where o.customer_id = c.id);

select * from orders;

insert into orders values (6, 9999, 3, DATE_FORMAT('2024-08-04', '%Y=%M-%d'));

-- distinct one column
select distinct concat_ws('-', extract(YEAR from tran_date), extract(MONTH from tran_date)) from orders;
-- distinct two columns
select distinct concat_ws('-', extract(YEAR from tran_date), extract(MONTH from tran_date)), total_amount from orders;


select o.*, (select max(total_amount) from orders), 1
from ordres o;

-- Subquery (slow performance)
-- First SQL to execute: select id form customers where name like '%LAU'
-- Secondly, DBMS executes "select * from orders where customer_id in ...."
select *
from orders
where customer_id in (select id from customers where name like '%LAU');


select * from orders;

insert into orders values (7, 400.0, null, DATE_FORMAT('2023-08-31', '%Y-%m-%d'));

-- LEFT JOIN
select c.*, o.*
from customers c left join orders on c.id = o.customer_id;

select o.*, c.*
from orders o left join customers c on c.id = o.customer_id;


-- RIGHT JOIN
select o.*, c.*
from customers c right join orders on c.id = o.customer_id;

select c.*, o.*
from orders o right join customers c on c.id = o.customer_id;

-- left join + Group by
-- count(o.id) is different to count(c.id)
-- Step 1: Left Join (key)
-- Step 2: Where
-- Step 3: Group by
-- Step 4: order by
-- Setp 5: select -> count(), max(), ifnull()
select c.id, count(1) number_of_orders, ifnull (max(total_amount), 0) as max_amount_of_orders
from customers c left join orders on c.id = o.customer_id 
where (o.total_amount > 100.0 or o.total_amount is null)
group by c.id, c.name
order by c.name asc;


select * from customers;
insert into customers values (4, 'Mary Chan', 'mary@gmail.com');
delete from customers where name = 'Mary Chan';


-- Add PK
ALTER TABLE customers ADD CONSTRAINT pK_customer_id PRIMARY KEY (id);


-- Duplicate value for PK
insert into customers values (4, 'Mary Chan', 'mary@gmail.com'); -- error
insert into customers values (5, 'Mary Chan', 'mary@gmail.com'); -- OK

-- ADD FK (
ALTER TABLE orders ADD CONSTAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customers(id);

select * from orders;
insert into orders values (8, 9000, 10, DATE_FORMAT('2024-08-04', '%Y-%m-%d'));
-- NOT OK, we do not have customer_id 10

insert into orders values (8, 9000, 5, DATE_FORMAT('2024-08-04', '%Y-%m-%d')); -- OK, we have customer_id 5

-- Table Design: PK & FK ensures data is inserted / updated with integrity & consistency
-- Primary Key and foreign key are also a type of constriants 
-- Every table has one PK only, but may be more than one FK.

-- Other Constriants: Unique Constriant
-- Unique
select * from customers;
ALTER TABLE customers ADD CONSTRAINT unique_email UNIQUE (email);
insert into customers values (6, 'John Chan', 'john@gmail.com'); -- error

-- NOT NULL (one or more columns can be "NOT NULL"
ALTER TABLE customers modify name varchar(50) not null;




-- NOT exists (most likely happen), better performance
select d.*
from department d
where not exists (select 1 from employee e where e.deparment_id = d.department.id);

-- Similar to "Not Exists", but you can select both table d & e columns
select d.*, e.*
from department d left join employee e on e.department_id = d.department_id
where e.employee_id is null;


select name, email
from customers
union all
select id, total_amount
from orders;


-- UNION -> distinct
select 1
from customers
union all
select 1
from orders;


-- combine two result set, no matter any duplicated
select 1
from customers
union all
select 1
from orders;





















