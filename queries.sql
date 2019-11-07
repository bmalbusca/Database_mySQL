USE `dental_clinic`;

SELECT client.name, client.VAT, phone_number_client.phone from client, phone_number_client ,employee, consultation 
NATURAL JOIN appointment 
WHERE appointment.VAT_client =  client.VAT   AND   employee.VAT = appointment.VAT_doctor AND employee.name = 'Jane Sweettooth' AND  client.VAT = phone_number_client.VAT
ORDER BY  client.name ASC ;


SELECT E1.name, E1.VAT, E2.name, rp.evaluation, rp.description FROM employee as E2, employee as E1 NATURAL JOIN trainee_doctor 
			NATURAL JOIN supervision_report as rp
			WHERE E2.VAT = trainee_doctor.supervisor AND  (rp.evaluation <3 OR rp.description  LIKE '%insufficient%')
			ORDER BY  rp.evaluation DESC;

SELECT Cl.name, Cl.city, Cl.VAT
FROM client as Cl
INNER JOIN(
		SELECT MAX(A.date_timestamp), A.VAT_client VAT
		FROM appointment as A NATURAL JOIN consultation as C
		WHERE C.SOAP_O LIKE '%gingivitis%' OR C.SOAP_O LIKE '%periodontitis%' 
		GROUP BY A.VAT_client) as Filter
ON Cl.VAT = Filter.VAT;