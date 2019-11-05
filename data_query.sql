
USE `dental_clinic`;

INSERT INTO employee VALUES ('123400000','Jane Sweettooth','1985-02-07','Av almirante reis','Lisboa', '1000-001','DE89370400440532013000',4000);
INSERT INTO employee VALUES ('123400001','Steve Aoki','1985-02-07','Av almirante reis','Lisboa', '1000-001','DE89370400440532013020',4000);

INSERT INTO doctor VALUES ('123400000','Dentist','Is a good guy','jane@tecnico.ulisboa.pt');
INSERT INTO doctor VALUES ('123400001','Dentist','Is a good guy 2','steve@tecnico.ulisboa.pt');

INSERT INTO client VALUES ('123456789','John','1985-02-07','Av almirante reis','Lisboa', '1000-000','Male',40);
INSERT INTO client VALUES ('123456780','Robert','1985-03-07','Av almirante reis','Lisboa', '1000-048','Male',20);
INSERT INTO client VALUES ('123456781','Charles','1988-03-06','Av almirante reis','Lisboa', '1000-020','Male',25);

INSERT INTO appointment VALUES ('123400000','2008-01-01 00:00:01','Its a bad situation','123456789');
INSERT INTO appointment VALUES ('123400001','2008-01-01 00:00:01','Its a not bad situation','123456780');

INSERT INTO consultation VALUES ('123400000','2008-01-01 00:00:01','not ok','ok','not ok','ok');
INSERT INTO consultation VALUES ('123400001','2008-01-01 00:00:01','ok','ok','ok','ok');


