--employee(VAT,name,birth_date,street,city,zip,IBAN,salary)
INSERT INTO employee VALUES ('123400000','Jane Sweettooth','1985-02-07','Av almirante reis','Lisboa', '1000-001','DE89370400440532013000',4000);
INSERT INTO employee VALUES ('123400001','Steve Aoki','1985-02-07','Av almirante reis','Lisboa', '1000-001','DE89370400440532013020',4000);
INSERT INTO employee VALUES ('123400002','Peter','1985-02-07','Av almirante reis','Lisboa', '1000-001','DE89370400440532013021',4000);
INSERT INTO employee VALUES ('123419970','Manuela','1985-02-07','Av almirante reis','Lisboa', '1000-001','DE89370400440532013023',4000);
INSERT INTO employee VALUES ('123419971','Lyonce','1985-02-07','Av almirante reis','Lisboa', '1000-001','DE89370400440532013022',4000);
INSERT INTO employee VALUES ('123419972','Alberta','1985-02-07','Av almirante reis','Lisboa', '1000-001','DE89370400440532013024',4000);
INSERT INTO employee VALUES ('123419973','Albertina','1985-02-07','Av almirante reis','Lisboa', '1000-001','DE89370400440532013025',4000);
INSERT INTO employee VALUES ('123419974','Rita','1985-02-07','Av almirante reis','Lisboa', '1000-001','DE89370400440532013026',4000);

--doctor(VAT,specialization,biography,e-mail)
INSERT INTO doctor VALUES ('123400000','Dentist','Is a good guy','jane@tecnico.ulisboa.pt');
INSERT INTO doctor VALUES ('123400001','Dentist','Is a good guy 2','steve@tecnico.ulisboa.pt');
INSERT INTO doctor VALUES ('123400002','Dentist','Is a good guy 3','peter@tecnico.ulisboa.pt');

--client(VAT,name,birth_date,street,city,zip,gender,age)
INSERT INTO client VALUES ('123456789','John','1974-02-07','Av almirante reis','Lisboa', '1000-000','Male',45);
INSERT INTO client VALUES ('123456780','Robert','2001-03-07','Av almirante reis','Lisboa', '1000-048','Male',18);
INSERT INTO client VALUES ('123456781','Charles','2004-03-06','Av almirante reis','Lisboa', '1000-020','Male',15);
INSERT INTO client VALUES ('123456782','LeBron','2002-03-06','Av almirante reis','Lisboa', '1000-020','Male',17);
INSERT INTO client VALUES ('123456790','Wade','1984-02-07','Av almirante reis','Lisboa', '1000-000','Male',35);
INSERT INTO client VALUES ('123456791','Hamilton','1993-03-07','Av almirante reis','Lisboa', '1000-048','Male',26);
INSERT INTO client VALUES ('123456792','Lewis','1985-03-06','Av almirante reis','Lisboa', '1000-020','Male',34);
INSERT INTO client VALUES ('123456793','Vettel','2008-03-06','Av almirante reis','Lisboa', '1000-020','Male',11);

--appointment(VAT_doctor,date_timestamp,description,VAT_client)
INSERT INTO appointment VALUES ('123400000','2019-01-01 00:00:15','Its a bad situation','123456789');
INSERT INTO appointment VALUES ('123400000','2019-01-02 00:00:01','Its a not bad situation','123456780');
INSERT INTO appointment VALUES ('123400000','2019-01-02 00:15:01','Its a not bad situation','123456791');
INSERT INTO appointment VALUES ('123400000','2019-01-03 00:15:01','Its a not bad situation','123456792');
INSERT INTO appointment VALUES ('123400000','2019-01-04 00:15:01','Its a not bad situation','123456793');
INSERT INTO appointment VALUES ('123400000','2019-01-05 00:15:01','Its a not bad situation','123456780');
INSERT INTO appointment VALUES ('123400000','2019-01-06 00:15:01','Its a not bad situation','123456780');
INSERT INTO appointment VALUES ('123400000','2019-01-07 00:15:01','Its a not bad situation','123456792');
INSERT INTO appointment VALUES ('123400002','2019-01-04 00:15:01','Its a not bad situation','123456789');
INSERT INTO appointment VALUES ('123400002','2019-01-05 00:15:01','Its a not bad situation','123456780');
INSERT INTO appointment VALUES ('123400002','2019-01-06 00:15:01','Its a not bad situation','123456780');
INSERT INTO appointment VALUES ('123400002','2019-01-07 00:15:01','Its a not bad situation','123456781');
INSERT INTO appointment VALUES ('123400000','2019-01-08 00:15:01','Its a not bad situation','123456781');
INSERT INTO appointment VALUES ('123400000','2019-01-30 00:15:01','Its a not bad situation','123456782');

--consultation(VAT_doctor,date_timestamp,SOAP_S,SOAP_O,SOAP_A,SOAP_P)
INSERT INTO consultation VALUES ('123400000','2019-01-01 00:00:15','not ok','gingivitis','not ok','ok');
INSERT INTO consultation VALUES ('123400000','2019-01-02 00:00:01','ok','gingivitis','ok','ok');
INSERT INTO consultation VALUES ('123400000','2019-01-02 00:15:01','ok','rest','ok','ok');
INSERT INTO consultation VALUES ('123400000','2019-01-03 00:15:01','ok','rest','ok','ok');
INSERT INTO consultation VALUES ('123400000','2019-01-04 00:15:01','ok','rest','ok','ok');
INSERT INTO consultation VALUES ('123400000','2019-01-05 00:15:01','ok','rest','ok','ok');
INSERT INTO consultation VALUES ('123400000','2019-01-06 00:15:01','ok','rest','ok','ok');
INSERT INTO consultation VALUES ('123400000','2019-01-07 00:15:01','ok','gingivitis','ok','ok');
INSERT INTO consultation VALUES ('123400002','2019-01-04 00:15:01','ok','rest','ok','ok');
INSERT INTO consultation VALUES ('123400002','2019-01-05 00:15:01','ok','ok','ok','ok');
INSERT INTO consultation VALUES ('123400002','2019-01-06 00:15:01','ok','ok','ok','ok');
INSERT INTO consultation VALUES ('123400002','2019-01-07 00:15:01','ok','periodontitis','ok','ok');

--phone_number_client(VAT,phone)
INSERT INTO phone_number_client VALUES ('123456789', 910000000);
INSERT INTO phone_number_client VALUES ('123456780', 910000001);

--permanent_doctor(VAT,years)s
INSERT INTO permanent_doctor VALUES ('123400000',5);
INSERT INTO permanent_doctor VALUES ('123400002',5);

--trainee_doctor(VAT,supervisor)
INSERT INTO trainee_doctor VALUES ('123400001','123400000');

--supervision_report(VAT,date_timestamp,description,evaluation)
INSERT INTO supervision_report VALUES ('123400001','2019-01-02 00:00:01','insufficient', 4);

--trainee_doctor(VAT,supervisor)
INSERT INTO trainee_doctor VALUES ('123400002','123400000');

--supervision_report(VAT,date_timestamp,description,evaluation)
INSERT INTO supervision_report VALUES ('123400002','2019-01-02 00:00:03','lazy', 2);

--diagnostic_code(ID,description)
INSERT INTO diagnostic_code VALUES ('ICD-10-CM', 'He is a dead men');
INSERT INTO diagnostic_code VALUES ('ICD-00-CM', 'gingivitis');
INSERT INTO diagnostic_code VALUES ('ICD-2-CM', 'dental cavities');
INSERT INTO diagnostic_code VALUES ('ICD-1-CM', 'infectious disease');
INSERT INTO diagnostic_code VALUES ('ICD-4-CM', 'Really bad infectious disease');

--consultation_diagnostic(VAT_doctor,date_timestamp,ID)
INSERT INTO consultation_diagnostic VALUES('123400000','2019-01-02 00:00:01','ICD-10-CM');
INSERT INTO consultation_diagnostic VALUES('123400000','2019-01-02 00:15:01','ICD-10-CM');
INSERT INTO consultation_diagnostic VALUES('123400000','2019-01-03 00:15:01','ICD-10-CM');
INSERT INTO consultation_diagnostic VALUES('123400000','2019-01-04 00:15:01','ICD-10-CM');
INSERT INTO consultation_diagnostic VALUES('123400000','2019-01-01 00:00:15','ICD-00-CM');
INSERT INTO consultation_diagnostic VALUES('123400000','2019-01-05 00:15:01','ICD-00-CM');
INSERT INTO consultation_diagnostic VALUES('123400000','2019-01-06 00:15:01','ICD-00-CM');
INSERT INTO consultation_diagnostic VALUES('123400000','2019-01-07 00:15:01','ICD-00-CM');
INSERT INTO consultation_diagnostic VALUES('123400002','2019-01-04 00:15:01','ICD-2-CM');
INSERT INTO consultation_diagnostic VALUES('123400002','2019-01-05 00:15:01','ICD-2-CM');
INSERT INTO consultation_diagnostic VALUES('123400002','2019-01-06 00:15:01','ICD-2-CM');
INSERT INTO consultation_diagnostic VALUES('123400002','2019-01-07 00:15:01','ICD-1-CM');
INSERT INTO consultation_diagnostic VALUES('123400002','2019-01-07 00:15:01','ICD-2-CM');
INSERT INTO consultation_diagnostic VALUES('123400002','2019-01-07 00:15:01','ICD-00-CM');
INSERT INTO consultation_diagnostic VALUES('123400002','2019-01-07 00:15:01','ICD-10-CM');

--medication(name,lab)
INSERT INTO medication VALUES ('cacao' , 'choc');
INSERT INTO medication VALUES ('nutela' , 'choc');
INSERT INTO medication VALUES ('cacao' , 'kinder');

--prescription(name,lab,VAT_doctor,date_timestamp,ID,dosage,description)
INSERT INTO prescription VALUES ('cacao','choc','123400002','2019-01-04 00:15:01','ICD-2-CM','1L','All in your vein');
INSERT INTO prescription VALUES ('cacao','kinder','123400002','2019-01-05 00:15:01','ICD-2-CM','1L','All in your vein');
INSERT INTO prescription VALUES ('cacao','choc','123400002','2019-01-06 00:15:01','ICD-2-CM','1L','All in your vein');
INSERT INTO prescription VALUES ('nutela','choc','123400002','2019-01-07 00:15:01','ICD-1-CM','1L','All in your vein');
INSERT INTO prescription VALUES ('cacao','choc','123400000','2019-01-02 00:00:01','ICD-10-CM','100ml','All in your arm');
INSERT INTO prescription VALUES ('nutela','choc','123400000','2019-01-02 00:15:01','ICD-10-CM','1L','All in your vein');
INSERT INTO prescription VALUES ('nutela','choc','123400000','2019-01-03 00:15:01','ICD-10-CM','1L','All in your vein');
INSERT INTO prescription VALUES ('nutela','choc','123400000','2019-01-04 00:15:01','ICD-10-CM','1L','All in your vein');
INSERT INTO prescription VALUES ('cacao','choc','123400000','2019-01-01 00:00:15','ICD-00-CM','1L','All in your vein');
INSERT INTO prescription VALUES ('cacao','choc','123400000','2019-01-05 00:15:01','ICD-00-CM','1L','All in your vein');
INSERT INTO prescription VALUES ('cacao','choc','123400000','2019-01-06 00:15:01','ICD-00-CM','1L','All in your vein');
INSERT INTO prescription VALUES ('nutela','choc','123400000','2019-01-07 00:15:01','ICD-00-CM','1L','All in your vein');

--nurse(VAT)
INSERT INTO nurse VALUES ('123419970');
INSERT INTO nurse VALUES ('123419971');

--consultation_assistant(VAT_doctor,date_timestamp,VAT_nurse)
INSERT INTO consultation_assistant VALUES('123400000','2019-01-01 00:00:15','123419970');
INSERT INTO consultation_assistant VALUES('123400000','2019-01-02 00:15:01','123419971');

--procedure(name,type)
INSERT INTO `procedure` VALUES ('colonoscopia','TIPO1');
INSERT INTO `procedure` VALUES ('endoscopia','TIPO2');
INSERT INTO `procedure` VALUES ('raio-x','TIPO3');

--procedure_in_consultation(name,VAT_doctor,date_timestamp,description)
INSERT INTO procedure_in_consultation VALUES ('colonoscopia', '123400000', '2019-01-02 00:00:01', 'hard');
INSERT INTO procedure_in_consultation VALUES ('endoscopia', '123400000', '2019-01-07 00:15:01', 'hard');
INSERT INTO procedure_in_consultation VALUES ('raio-x', '123400000', '2019-01-04 00:15:01', 'hard');
INSERT INTO procedure_in_consultation VALUES ('endoscopia', '123400002', '2019-01-07 00:15:01', 'hard');

--teeth(quadrant,number,name)
INSERT INTO  teeth VALUES (4,20,'canino');

--procedure_charting(name,VAT,date_timestamp,quadrant,number,desc,measure)
INSERT INTO procedure_charting VALUES('endoscopia', '123400000', '2019-01-07 00:15:01',4,20,'bom', 5 );
