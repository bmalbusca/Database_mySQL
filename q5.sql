USE dental_clinic; 

SELECT C.ID,C.description, COUNT(distinct C.name,C.lab) as cnt 
FROM	(SELECT dc.ID, dc.description, p.name , p.lab  
		FROM diagnostic_code dc LEFT OUTER JOIN  (SELECT * FROM prescription) as p
								ON 	dc.ID = p.ID) AS C
GROUP BY C.ID
ORDER BY cnt ASC;


