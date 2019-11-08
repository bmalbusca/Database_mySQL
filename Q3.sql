SELECT Cl.name, Cl.city, Cl.VAT FROM client as Cl, 
	(SELECT con.SOAP_O, res.VAT_client FROM consultation as con 
		JOIN
		(SELECT * FROM appointment as A
			INNER JOIN(
					SELECT MAX(A.date_timestamp) MAX_ts, A.VAT_client VAT
					FROM 	appointment as A NATURAL JOIN consultation as C
					GROUP BY A.VAT_client) as Filter
			ON 	A.VAT_client = Filter.VAT AND A.date_timestamp = Filter.MAX_ts ) as res
		ON 	con.VAT_doctor =res.VAT_doctor AND con.date_timestamp = res.date_timestamp) as t
WHERE 	Cl.VAT = t.VAT_client AND (t.SOAP_O LIKE '%gingivitis%' OR t.SOAP_O LIKE '%periodontitis%');