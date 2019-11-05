 DROP DATABASE IF EXISTS `dental_clinic`;
 CREATE DATABASE `dental_clinic`;
 USE `dental_clinic`;

 -- IBAN Other option is using bigint()
 -- SALARY Maybe earns millions

/*

 SHOW databases;
 USE dental_clinic;
 SHOW tables;
 DESCRIBE table_name;
 SELECT * from table_name;

SELECT 
  TABLE_NAME,COLUMN_NAME,CONSTRAINT_NAME, REFERENCED_TABLE_NAME,REFERENCED_COLUMN_NAME
FROM
  INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
  REFERENCED_TABLE_SCHEMA = 'database' AND
  REFERENCED_TABLE_NAME = 'table';

*/


CREATE TABLE employee (
	VAT varchar(14) NOT NULL,
	name varchar(50) NOT NULL,
	birth_date date NOT NULL,
	street varchar(50) NOT NULL, 
	city varchar(50) NOT NULL, 
	zip varchar(10) NOT NULL,
	IBAN varchar(30) NOT NULL UNIQUE, 
	salary decimal(9,2) NOT NULL CHECK (salary >= 0),  
	PRIMARY KEY (VAT)
);

CREATE TABLE phone_number_employee( 
	VAT varchar(14) NOT NULL,
	phone varchar(15) NOT NULL,
	PRIMARY KEY (VAT,phone),
	FOREIGN KEY (VAT) REFERENCES employee(VAT)
);

CREATE TABLE receptionist (
	VAT varchar(14) NOT NULL,
	PRIMARY KEY (VAT),
	FOREIGN KEY (VAT) REFERENCES employee(VAT)
);

CREATE TABLE doctor(
	VAT varchar(14) NOT NULL,
	specialization varchar(50) NOT NULL, 
	biography varchar(255), 
	email varchar(50) NOT NULL UNIQUE,
	PRIMARY KEY (VAT),
	FOREIGN KEY (VAT) REFERENCES employee(VAT)
);

CREATE TABLE nurse(
	VAT varchar(14) NOT NULL,
	PRIMARY KEY (VAT),
	FOREIGN KEY (VAT) REFERENCES employee(VAT)
);


CREATE TABLE client(
	VAT varchar(14) NOT NULL,
	name varchar(50) NOT NULL,
	birth_date date NOT NULL,
	street varchar(50) NOT NULL, 
	city varchar(50) NOT NULL, 
	zip varchar(10) NOT NULL,
	gender varchar(6) NOT NULL,
	age INT NOT NULL CHECK (age >=0),
	PRIMARY KEY (VAT)
	
);

CREATE TABLE phone_number_client(
	VAT varchar(14) NOT NULL,
	phone varchar(15) NOT NULL,
	PRIMARY KEY (VAT),
	FOREIGN KEY (VAT) REFERENCES client(VAT)
);


CREATE TABLE permanent_doctor(
	VAT varchar(14) NOT NULL,
	years SMALLINT NOT NULL,
	PRIMARY KEY (VAT),
	FOREIGN KEY (VAT) REFERENCES doctor(VAT)
);

CREATE TABLE trainee_doctor(
	VAT varchar(14) NOT NULL,
	supervisor varchar(14) NOT NULL,
	PRIMARY KEY (VAT),
	FOREIGN KEY (VAT) REFERENCES doctor(VAT),
--	KEY doctor_supervisor (supervisor),
--  CONSTRAINT doctor_supervisor FOREIGN KEY (supervisor) REFERENCES permanent_doctor(VAT)
	FOREIGN KEY (supervisor) REFERENCES doctor(VAT)

);


CREATE TABLE supervision_report(
	VAT varchar(14) NOT NULL,
	data_timestamp TIMESTAMP NOT NULL,
	description varchar(255) NOT NULL,
	evaluation SMALLINT NOT NULL CHECK (evaluation >=1 AND evaluation <=5 ),
	PRIMARY KEY (VAT,data_timestamp),
	FOREIGN KEY (VAT) REFERENCES trainee_doctor(VAT)
);


CREATE TABLE appointment(
	VAT_doctor varchar(14) NOT NULL,
	data_timestamp TIMESTAMP NOT NULL,
	description varchar(255) NOT NULL,
	VAT_client varchar(14) NOT NULL,
	PRIMARY KEY (VAT_doctor, data_timestamp),
	FOREIGN KEY (VAT_doctor) REFERENCES doctor(VAT),
	FOREIGN KEY (VAT_client) REFERENCES client(VAT)
);



CREATE TABLE consultation(
	VAT_doctor varchar(14) NOT NULL,
	data_timestamp TIMESTAMP NOT NULL,
	SOAP_S varchar(255) NOT NULL,
	SOAP_O varchar(255) NOT NULL,
	SOAP_A varchar(255) NOT NULL,
	SOAP_P varchar(255) NOT NULL,
	PRIMARY KEY (VAT_doctor,data_timestamp),
	FOREIGN KEY (VAT_doctor,data_timestamp) REFERENCES appointment(VAT_doctor,data_timestamp)
);



CREATE TABLE consultation_assistant(
	VAT_doctor varchar(14) NOT NULL,
	data_timestamp TIMESTAMP NOT NULL,
	VAT_nurse varchar(14) NOT NULL,
	PRIMARY KEY (VAT_doctor, data_timestamp),
	FOREIGN KEY (VAT_nurse) REFERENCES nurse(VAT),
	FOREIGN KEY (VAT_doctor,data_timestamp) REFERENCES consultation(VAT_doctor,data_timestamp)
);




























