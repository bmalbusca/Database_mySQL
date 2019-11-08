USE dental_clinic;


DELETE FROM `procedure`as p WHERE (p.name= (SELECT distinct(pc.name) AS pname FROM procedure_in_consultation as pc 
									WHERE pc.VAT_doctor =	(SELECT e.VAT FROM employee as e
										WHERE e.name LIKE 'Jane Sweettooth')) and  NOT EXISTS(

SELECT t2.pname FROM (SELECT p.name, p.VAT_doctor FROM procedure_in_consultation as p
				WHERE p.VAT_doctor != (SELECT e.VAT FROM employee as e
				WHERE e.name LIKE 'Jane Sweettooth') )as t
                INNER JOIN  (SELECT distinct(pc.name) AS pname FROM procedure_in_consultation as pc 
									WHERE pc.VAT_doctor =	(SELECT e.VAT FROM employee as e
										WHERE e.name LIKE 'Jane Sweettooth')) as t2
                                        ON t.name = t2.pname
                                        


));

DELETE FROM  employee as e
WHERE e.name LIKE 'Jane Sweettooth';                
		



