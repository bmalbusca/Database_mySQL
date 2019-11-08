USE dental_clinic; 

SELECT client.name, client.VAT, client.street, client.city, client.zip 
FROM client, appointment 
WHERE appointment.VAT_client = client.VAT AND
	client.VAT NOT IN (
				SELECT a.VAT_client 
				FROM 	consultation as c 	LEFT OUTER JOIN appointment as a
											ON 	c.VAT_doctor = a.VAT_doctor AND
												c.date_timestamp = a.date_timestamp);
            
    
    
          
        
 
    
  
   

  


   