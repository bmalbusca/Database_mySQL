USE dental_clinic;

-- DELETE FROM  employee as e
-- WHERE e.name LIKE 'Jane Sweettooth';

SELECT COUNT(p.name) FROM procedure_in_consultation as p, 
	(SELECT pc.name, pc.VAT_doctor FROM procedure_in_consultation as pc 
		WHERE pc.VAT_doctor =	(SELECT e.VAT FROM employee as e
			WHERE e.name LIKE 'Jane Sweettooth')) as pname
WHERE (p.VAT_doctor <> pname.VAT_doctor AND p.name = pname.name)
GROUP BY p.name;





