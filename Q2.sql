USE `dental_clinic`;

SELECT 	E1.name as Trainee, E1.VAT as Trainee_VAT, E2.name as Supervisor, rp.evaluation, rp.description
FROM 	employee as E2, employee as E1 NATURAL JOIN trainee_doctor	NATURAL JOIN supervision_report as rp
WHERE 	E2.VAT = trainee_doctor.supervisor AND
	(rp.evaluation <3 OR rp.description  LIKE '%insufficient%')
ORDER BY rp.evaluation DESC;