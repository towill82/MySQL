-- create new database
Create database BOOTCAMP_EXERCISE1;

-- get into database
use BOOTCAMP_EXERCISE1;


create table Regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(25)
);

create table Countries (
	country_id char(2) PRIMARY KEY,
    country_name varchar(40),
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES Regions(region_id)
);

create table Locations (
	location_id INT PRIMARY KEY,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12),
    country_id char(2),
    FOREIGN KEY (country_id) REFERENCES Countries(country_id)
);

create table Departments (
	department_id INT PRIMARY KEY,
    department_name varchar(30),
    manager_id INT,
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

create table Jobs (
	job_id varchar(10) PRIMARY KEY,
    job_title varchar(35),
    min_salary INT,
    max_salary INT
);

create table Job_History (
	employee_id INT,
    start_date date,
    end_date date,
    job_id varchar(10),
    department_id INT,
    PRIMARY KEY (employee_id, start_date),
    FOREIGN KEY (department_id ) REFERENCES Departments(department_id),
	FOREIGN KEY (job_id ) REFERENCES Jobs(job_id)
);

create table Employees (
	employee_id INT PRIMARY KEY,
    first_name varchar(20),
    last_name varchar(25),
    email varchar(25),
    phone_number varchar(20),
    hire_date date,
    job_id varchar(10),
    salary INT,
    commission_pct INT,
    manager_id INT,
    department_id INT,
    FOREIGN KEY (employee_id) REFERENCES Job_History (employee_id),
	FOREIGN KEY (job_id) REFERENCES Jobs (job_id),
	FOREIGN KEY (department_id ) REFERENCES Departments (department_id)
);




