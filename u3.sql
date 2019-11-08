USE dental_clinic;

-- DELETE FROM  employee as e
-- WHERE e.name LIKE 'Jane Sweettooth';
/*
DELETE FROM `procedure`as p WHERE p.name NOT IN(
SELECT p.name FROM procedure_in_consultation as p, 
	(SELECT distincT(pc.name), pc.VAT_doctor FROM procedure_in_consultation as pc 
		WHERE pc.VAT_doctor =	(SELECT e.VAT FROM employee as e
			WHERE e.name LIKE 'Jane Sweettooth')) as pname
WHERE (p.VAT_doctor <> pname.VAT_doctor AND p.name = pname.name)
GROUP BY p.name) LIMIT 1;
*/
/*
SELECT * FROM procedure_in_consultation as p
	WHERE p.VAT_doctor != (SELECT e.VAT FROM employee as e
			WHERE e.name LIKE 'Jane Sweettooth')
;*/
/*
SELECT distinct(pc.name) FROM procedure_in_consultation as pc 
		WHERE pc.VAT_doctor =	(SELECT e.VAT FROM employee as e
			WHERE e.name LIKE 'Jane Sweettooth')
*/

DELETE FROM `procedure`as p WHERE p.name  IN(

SELECT t2.pname FROM (SELECT p.name, p.VAT_doctor FROM procedure_in_consultation as p
				WHERE p.VAT_doctor != (SELECT e.VAT FROM employee as e
				WHERE e.name LIKE 'Jane Sweettooth') )as t
             JOIN  (SELECT distinct(pc.name) AS pname FROM procedure_in_consultation as pc 
									WHERE pc.VAT_doctor =	(SELECT e.VAT FROM employee as e
										WHERE e.name LIKE 'Jane Sweettooth')) as t2
                                        ON t.name = t2.pname


) LIMIT 1;

                
		



