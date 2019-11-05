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
	date_timestamp TIMESTAMP NOT NULL,
	description TEXT NOT NULL,
	evaluation SMALLINT NOT NULL CHECK (evaluation >=1 AND evaluation <=5 ),
	PRIMARY KEY (VAT,date_timestamp),
	FOREIGN KEY (VAT) REFERENCES trainee_doctor(VAT)
);


CREATE TABLE appointment(
	VAT_doctor varchar(14) NOT NULL,
	date_timestamp TIMESTAMP NOT NULL,
	description varchar(255) NOT NULL,
	VAT_client varchar(14) NOT NULL,
	PRIMARY KEY (VAT_doctor, date_timestamp),
	FOREIGN KEY (VAT_doctor) REFERENCES doctor(VAT),
	FOREIGN KEY (VAT_client) REFERENCES client(VAT)
);



CREATE TABLE consultation(
	VAT_doctor varchar(14) NOT NULL,
	date_timestamp TIMESTAMP NOT NULL,
	SOAP_S TEXT NOT NULL,
	SOAP_O TEXT NOT NULL,
	SOAP_A TEXT NOT NULL,
	SOAP_P TEXT NOT NULL,
	PRIMARY KEY (VAT_doctor,date_timestamp),
	FOREIGN KEY (VAT_doctor,date_timestamp) REFERENCES appointment(VAT_doctor,date_timestamp)
);



CREATE TABLE consultation_assistant(
	VAT_doctor varchar(14) NOT NULL,
	date_timestamp TIMESTAMP NOT NULL,
	VAT_nurse varchar(14) NOT NULL,
	PRIMARY KEY (VAT_doctor, date_timestamp),
	FOREIGN KEY (VAT_nurse) REFERENCES nurse(VAT),
	FOREIGN KEY (VAT_doctor,date_timestamp) REFERENCES consultation(VAT_doctor,date_timestamp)
);

CREATE TABLE diagnostic_code(
	ID varchar(14) NOT NULL,
	description varchar(255) NOT NULL,
	PRIMARY KEY (ID)
);

CREATE TABLE diagnostic_code_relation(
	ID1 varchar(14) NOT NULL,
	ID2 varchar(14) NOT NULL,
	type varchar(50) NOT NULL,
	PRIMARY KEY (ID1,ID2),
--	FOREIGN KEY (ID1,ID2) REFERENCES diagnostic_code(ID)	
	CONSTRAINT fkey1  FOREIGN KEY (ID1) REFERENCES diagnostic_code(ID),
	CONSTRAINT fkey2  FOREIGN KEY (ID2) REFERENCES diagnostic_code(ID)
);

CREATE TABLE consultation_diagnostic(
	VAT_doctor varchar(14) NOT NULL,
	date_timestamp TIMESTAMP  NOT NULL,
	ID varchar(14) NOT NULL,
	PRIMARY KEY (VAT_doctor,date_timestamp, ID),
	FOREIGN KEY (VAT_doctor,date_timestamp) REFERENCES consultation(VAT_doctor,date_timestamp),
	FOREIGN KEY (ID) REFERENCES diagnostic_code(ID)
);

CREATE TABLE medication(
	name varchar(50) NOT NULL,
	lab varchar(50) NOT NULL,
	PRIMARY KEY (name,lab)
);

CREATE TABLE prescription(
	name varchar(50) NOT NULL, 
	lab varchar(50) NOT NULL,
	VAT_doctor varchar(14) NOT NULL,
	date_timestamp TIMESTAMP NOT NULL,
	ID varchar(14) NOT NULL,
	dosage varchar(255),
	description varchar(255),
	PRIMARY KEY (name,lab,VAT_doctor,date_timestamp,ID),
	FOREIGN KEY (VAT_doctor,date_timestamp, ID) REFERENCES consultation_diagnostic(VAT_doctor,date_timestamp,ID),
	FOREIGN KEY (name,lab) REFERENCES medication(name,lab)
);

CREATE TABLE procedure_(
	name varchar(50) NOT NULL,
	type varchar(50) NOT NULL,
	PRIMARY KEY (name)
);

CREATE TABLE procedure_in_consultation(
	name varchar(50) NOT NULL,
	VAT_doctor varchar(14) NOT NULL,
	date_timestamp TIMESTAMP NOT NULL,
	description varchar(255) NOT NULL,
	PRIMARY KEY (name,VAT_doctor,date_timestamp),
	FOREIGN KEY (name) REFERENCES procedure_(name),
	FOREIGN KEY (VAT_doctor,date_timestamp) REFERENCES consultation(VAT_doctor,date_timestamp)
);

CREATE TABLE procedure_radiology(
	name varchar(50) NOT NULL,
	file varchar(50) NOT NULL,
	VAT_doctor varchar(14) NOT NULL,
	date_timestamp TIMESTAMP NOT NULL,
	PRIMARY KEY (name,file, VAT_doctor, date_timestamp),
	FOREIGN KEY (name,VAT_doctor, date_timestamp) REFERENCES procedure_in_consultation(name,VAT_doctor, date_timestamp)
);

CREATE TABLE teeth(
	quadrant INT NOT NULL,
	number INT NOT NULL,
	name varchar(20) NOT NULL,
	PRIMARY KEY (quadrant,number)
);

CREATE TABLE procedure_charting(
	name varchar(50) NOT NULL,
	VAT varchar(14) NOT NULL,
	date_timestamp TIMESTAMP NOT NULL,
	quadrant INT NOT NULL,
	number INT NOT NULL,
	descr varchar(255) NOT NULL, 
	measure decimal(4,2),
	PRIMARY KEY (name,VAT,date_timestamp,quadrant,number),
	FOREIGN KEY (name,VAT, date_timestamp) REFERENCES procedure_in_consultation(name,VAT_doctor, date_timestamp),
	FOREIGN KEY(quadrant,number) REFERENCES teeth(quadrant,number)
);























