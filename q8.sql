USE `dental_clinic`;

SELECT 	res.name, res.lab 
FROM 	(SELECT t.name, t.lab, t.description 
		FROM	(SELECT pc.ID, pc.name, pc.lab, dc.description 
				FROM 	diagnostic_code as dc JOIN (
												SELECT p.name, p.lab, p.ID 
												FROM prescription as p
												WHERE EXTRACT(YEAR from p.date_timestamp) = '2019'
													) as pc ON dc.ID=pc.ID 
				GROUP BY  pc.ID,pc.name,pc.lab ) as t
		WHERE  t.description LIKE '%dental cavities%' ) as res
HAVING 	(res.name , res.lab) not IN (
		SELECT t.name, t.lab 
		FROM  	(SELECT pc.ID, pc.name, pc.lab, dc.description 
				FROM diagnostic_code as dc JOIN (
											SELECT p.name, p.lab, p.ID 
											FROM prescription as p
											WHERE EXTRACT(YEAR from p.date_timestamp) = '2019'
												) as pc ON dc.ID=pc.ID 
				GROUP BY  pc.ID,pc.name,pc.lab ) as t
		WHERE  t.description  LIKE '%infectious disease%')
ORDER BY res.name, res.lab ASC;