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
	FOREIGN KEY (ID1) REFERENCES diagnostic_code(ID),
	FOREIGN KEY (ID2) REFERENCES diagnostic_code(ID)
--	CONSTRAINT fkey1  FOREIGN KEY (ID1) REFERENCES diagnostic_code(ID),
--	CONSTRAINT fkey2  FOREIGN KEY (ID2) REFERENCES diagnostic_code(ID)
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




INSERT INTO employee VALUES ('123400000','Jane Sweettooth','1985-02-07','Av almirante reis','Lisboa', '1000-001','DE89370400440532013000',4000);
INSERT INTO employee VALUES ('123400001','Steve Aoki','1985-02-07','Av almirante reis','Lisboa', '1000-001','DE89370400440532013020',4000);
INSERT INTO employee VALUES ('123400002','Peter','1985-02-07','Av almirante reis','Lisboa', '1000-001','DE89370400440532013021',4000);

INSERT INTO doctor VALUES ('123400000','Dentist','Is a good guy','jane@tecnico.ulisboa.pt');
INSERT INTO doctor VALUES ('123400001','Dentist','Is a good guy 2','steve@tecnico.ulisboa.pt');
INSERT INTO doctor VALUES ('123400002','Dentist','Is a good guy 3','peter@tecnico.ulisboa.pt');

INSERT INTO client VALUES ('123456789','John','1985-02-07','Av almirante reis','Lisboa', '1000-000','Male',40);
INSERT INTO client VALUES ('123456780','Robert','1985-03-07','Av almirante reis','Lisboa', '1000-048','Male',20);
INSERT INTO client VALUES ('123456781','Charles','1988-03-06','Av almirante reis','Lisboa', '1000-020','Male',25);

INSERT INTO appointment VALUES ('123400000','2008-01-01 00:00:15','Its a bad situation','123456789');
INSERT INTO appointment VALUES ('123400000','2008-01-02 00:00:01','Its a not bad situation','123456780');
INSERT INTO appointment VALUES ('123400000','2008-01-02 00:15:01','Its a not bad situation','123456780');
INSERT INTO appointment VALUES ('123400000','2008-01-03 00:15:01','Its a not bad situation','123456780');
INSERT INTO appointment VALUES ('123400000','2008-01-04 00:15:01','Its a not bad situation','123456780');
INSERT INTO appointment VALUES ('123400000','2008-01-05 00:15:01','Its a not bad situation','123456780');
INSERT INTO appointment VALUES ('123400000','2008-01-06 00:15:01','Its a not bad situation','123456780');
INSERT INTO appointment VALUES ('123400000','2008-01-07 00:15:01','Its a not bad situation','123456781');

INSERT INTO appointment VALUES ('123400002','2008-01-04 00:15:01','Its a not bad situation','123456789');
INSERT INTO appointment VALUES ('123400002','2008-01-05 00:15:01','Its a not bad situation','123456780');
INSERT INTO appointment VALUES ('123400002','2008-01-06 00:15:01','Its a not bad situation','123456780');
INSERT INTO appointment VALUES ('123400002','2008-01-07 00:15:01','Its a not bad situation','123456781');




INSERT INTO consultation VALUES ('123400000','2008-01-01 00:00:15','not ok','gingivitis','not ok','ok');
INSERT INTO consultation VALUES ('123400000','2008-01-02 00:00:01','ok','gingivitis','ok','ok');
INSERT INTO consultation VALUES ('123400000','2008-01-02 00:15:01','ok','rest','ok','ok');
INSERT INTO consultation VALUES ('123400000','2008-01-03 00:15:01','ok','rest','ok','ok');
INSERT INTO consultation VALUES ('123400000','2008-01-04 00:15:01','ok','rest','ok','ok');
INSERT INTO consultation VALUES ('123400000','2008-01-05 00:15:01','ok','rest','ok','ok');
INSERT INTO consultation VALUES ('123400000','2008-01-06 00:15:01','ok','rest','ok','ok');
INSERT INTO consultation VALUES ('123400000','2008-01-07 00:15:01','ok','rest','ok','ok');

INSERT INTO consultation VALUES ('123400002','2008-01-04 00:15:01','ok','rest','ok','ok');
INSERT INTO consultation VALUES ('123400002','2008-01-05 00:15:01','ok','ok','ok','ok');
INSERT INTO consultation VALUES ('123400002','2008-01-06 00:15:01','ok','ok','ok','ok');
INSERT INTO consultation VALUES ('123400002','2008-01-07 00:15:01','ok','ok','ok','ok');


INSERT INTO phone_number_client VALUES ('123456789', 910000000);
INSERT INTO phone_number_client VALUES ('123456780', 910000001);


INSERT INTO permanent_doctor VALUES ('123400000',5);
INSERT INTO permanent_doctor VALUES ('123400002',5);
INSERT INTO trainee_doctor VALUES ('123400001','123400000');
INSERT INTO supervision_report VALUES ('123400001','2008-01-02 00:00:01','insufficient', 4);


INSERT INTO trainee_doctor VALUES ('123400002','123400000');
INSERT INTO supervision_report VALUES ('123400002','2008-01-02 00:00:03','good', 3);


INSERT INTO diagnostic_code VALUES ('ICD-10-CM', 'He is a dead men'); 
INSERT INTO diagnostic_code VALUES ('ICD-00-CM', 'He is  a zombie'); 
INSERT INTO diagnostic_code VALUES ('ICD-2-CM', 'dental cavities'); 
INSERT INTO diagnostic_code VALUES ('ICD-1-CM', 'infectious disease'); 


INSERT INTO consultation_diagnostic VALUES('123400000','2008-01-02 00:00:01','ICD-10-CM');
INSERT INTO consultation_diagnostic VALUES('123400000','2008-01-02 00:15:01','ICD-10-CM');
INSERT INTO consultation_diagnostic VALUES('123400000','2008-01-03 00:15:01','ICD-10-CM'); 
INSERT INTO consultation_diagnostic VALUES('123400000','2008-01-04 00:15:01','ICD-10-CM');  
INSERT INTO consultation_diagnostic VALUES('123400000','2008-01-01 00:00:15','ICD-00-CM');
INSERT INTO consultation_diagnostic VALUES('123400000','2008-01-05 00:15:01','ICD-00-CM');
INSERT INTO consultation_diagnostic VALUES('123400000','2008-01-06 00:15:01','ICD-00-CM');
INSERT INTO consultation_diagnostic VALUES('123400000','2008-01-07 00:15:01','ICD-00-CM');

INSERT INTO consultation_diagnostic VALUES('123400002','2008-01-04 00:15:01','ICD-2-CM');
INSERT INTO consultation_diagnostic VALUES('123400002','2008-01-05 00:15:01','ICD-2-CM');
INSERT INTO consultation_diagnostic VALUES('123400002','2008-01-06 00:15:01','ICD-2-CM');
INSERT INTO consultation_diagnostic VALUES('123400002','2008-01-07 00:15:01','ICD-1-CM');

 

INSERT INTO medication VALUES ('cacao' , 'choc');
INSERT INTO medication VALUES ('nutela' , 'choc');
INSERT INTO medication VALUES ('cacao' , 'kinder');

INSERT INTO prescription VALUES ('cacao','choc','123400000','2008-01-02 00:00:01','ICD-10-CM','100ml','All in your ass');
INSERT INTO prescription VALUES ('nutela','choc','123400000','2008-01-02 00:15:01','ICD-10-CM','1L','All in your vein');
INSERT INTO prescription VALUES ('nutela','choc','123400000','2008-01-03 00:15:01','ICD-10-CM','1L','All in your vein');
INSERT INTO prescription VALUES ('nutela','choc','123400000','2008-01-04 00:15:01','ICD-10-CM','1L','All in your vein');
INSERT INTO prescription VALUES ('cacao','choc','123400000','2008-01-01 00:00:15','ICD-00-CM','1L','All in your vein');
INSERT INTO prescription VALUES ('cacao','choc','123400000','2008-01-05 00:15:01','ICD-00-CM','1L','All in your vein');
INSERT INTO prescription VALUES ('cacao','choc','123400000','2008-01-06 00:15:01','ICD-00-CM','1L','All in your vein');
INSERT INTO prescription VALUES ('nutela','choc','123400000','2008-01-07 00:15:01','ICD-00-CM','1L','All in your vein');

INSERT INTO prescription VALUES ('cacao','choc','123400002','2008-01-04 00:15:01','ICD-2-CM','1L','All in your vein');
INSERT INTO prescription VALUES ('cacao','kinder','123400002','2008-01-05 00:15:01','ICD-2-CM','1L','All in your vein');
INSERT INTO prescription VALUES ('cacao','choc','123400002','2008-01-06 00:15:01','ICD-2-CM','1L','All in your vein');
INSERT INTO prescription VALUES ('nutela','choc','123400002','2008-01-07 00:15:01','ICD-1-CM','1L','All in your vein');















