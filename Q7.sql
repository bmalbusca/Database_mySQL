SELECT	DC.ID, (SELECT filter.nome 
				FROM 	(SELECT COUNT(P.name) as num, P.name as nome 
						FROM prescription as P 
						WHERE P.ID = DC.ID 
						GROUP BY P.name 
						ORDER BY num desc 
						LIMIT 1) as filter
					) as name 
FROM	diagnostic_code as DC;