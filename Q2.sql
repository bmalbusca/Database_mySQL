USE `dental_clinic`;

SELECT 	E1.name, E1.VAT, E2.name, rp.evaluation, rp.description
FROM 	employee as E2, employee as E1 NATURAL JOIN trainee_doctor	NATURAL JOIN supervision_report as rp
WHERE 	E2.VAT = trainee_doctor.supervisor AND
		(rp.evaluation <3 OR rp.description  LIKE '%insufficient%')
ORDER BY rp.evaluation DESC;