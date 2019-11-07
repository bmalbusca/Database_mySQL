USE dental_clinic; 

/*
SELECT  med.name, med.lab, result.description , result.ID  FROM medication as med JOIN (
	SELECT pc.ID, pc.name, pc.lab, dc.description FROM diagnostic_code as dc JOIN (
		SELECT p.name, p.lab, p.ID FROM prescription as p
	) as pc ON dc.ID=pc.ID 
	WHERE dc.description LIKE '%dental cavities%' AND dc.description NOT LIKE '%infectious disease%') as result
ON med.name = result.name AND med.lab = result.lab
;
*/

SELECT res.name, res.lab, res.description FROM (
		SELECT t.name, t.lab, t.description FROM  
			(SELECT pc.ID, pc.name, pc.lab, dc.description FROM diagnostic_code as dc JOIN (
				SELECT p.name, p.lab, p.ID FROM prescription as p
				WHERE EXTRACT(YEAR from p.date_timestamp) = '2019'
			) as pc ON dc.ID=pc.ID 
			GROUP BY  pc.ID,pc.name,pc.lab ) as t
		WHERE  t.description LIKE '%dental cavities%' ) as res
    HAVING (res.name , res.lab) not IN (
		SELECT t.name, t.lab FROM  
				(SELECT pc.ID, pc.name, pc.lab, dc.description FROM diagnostic_code as dc JOIN (
					SELECT p.name, p.lab, p.ID FROM prescription as p
					WHERE EXTRACT(YEAR from p.date_timestamp) = '2019'
				) as pc ON dc.ID=pc.ID 
				GROUP BY  pc.ID,pc.name,pc.lab ) as t
			WHERE  t.description  LIKE '%infectious disease%'
    )
ORDER BY res.name ASC;
   
	
   





