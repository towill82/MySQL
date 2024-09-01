-- comment
create database db_selflearn;
use db_selflearn;

create table products (
	id int,
    itemnumber varchar (10),
    productname varchar (50),
    price numeric (5,2)
    );
    
    insert into products (id, itemnumber, productname, price) values (1, 'G001', 'EngerixB', 10.0);
	insert into products (id, itemnumber, productname, price) values (2, 'G002', 'Havrix', 8.5);
    insert into products (id, itemnumber, productname, price) values (3, 'G003', 'Boostrix', 23.45);
    insert into products (id, itemnumber, productname, price) values (4, 'G004', 'Fluarix', 6.25);
    
select * from products;
