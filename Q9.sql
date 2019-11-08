SELECT 	client.name, client.street, client.city, client.zip 
FROM	client
WHERE 	client.VAT 	NOT IN 	(SELECT ref.VAT 
							FROM	(SELECT a.VAT_doctor, a.date_timestamp, a.VAT_client as VAT 
									FROM appointment as a
									WHERE EXTRACT(YEAR from a.date_timestamp) = '2019'
									HAVING (a.VAT_doctor, a.date_timestamp, a.VAT_client) 
										NOT IN	(SELECT a.VAT_doctor, a.date_timestamp, a.VAT_client 
												FROM consultation as c INNER JOIN appointment as a			
																		ON 	c.VAT_doctor = a.VAT_doctor AND
																			c.date_timestamp = a.date_timestamp)
									) as ref		
							);