USE dental_clinic; 

SELECT * FROM client 
WHERE client.VAT NOT IN (
		SELECT a.VAT_client FROM appointment as a LEFT OUTER JOIN
			consultation as c
            ON c.VAT_doctor = a.VAT_doctor AND c.date_timestamp = a.date_timestamp) 
            ;
            
    
    
          
        
 
    
  
   

  


   