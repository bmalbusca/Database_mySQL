DROP DATABASE IF EXISTS `dental_clinic`;
CREATE DATABASE `dental_clinic`;
USE `dental_clinic`;

 -- IBAN Other option is using bigint()
 -- SALARY Maybe earns millions

 -- SHOW databases;
 -- USE dental_clinic;
 -- SHOW tables;
 -- DESCRIBE table_name;
 -- SELECT * from table_name;

CREATE TABLE `employee` (
	`VAT` varchar(14) NOT NULL,
	`name` varchar(50) NOT NULL,
	`birth_date` varchar(12) NOT NULL,
	`street` varchar(50) NOT NULL, 
	`city` varchar(50) NOT NULL, 
	`zip` varchar(10) NOT NULL,
	`IBAN` varchar(15) NOT NULL UNIQUE, 
	`salary` decimal(9,2) NOT NULL CHECK (`salary` > 0),  
	PRIMARY KEY (`VAT`)
);
