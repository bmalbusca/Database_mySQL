USE `dental_clinic`;

SELECT	DISTINCT client.name, client.VAT, phone_number_client.phone 
FROM 	client, phone_number_client ,employee, consultation NATURAL JOIN appointment 
WHERE 	appointment.VAT_client =  client.VAT   AND
		employee.VAT = appointment.VAT_doctor AND
		employee.name = 'Jane Sweettooth' AND  
		client.VAT = phone_number_client.VAT
ORDER BY client.name ASC;