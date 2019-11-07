select
  DC.ID, 
  (select filter.nome from (select count(P.name) as num, P.name as nome from prescription as P where P.ID = DC.ID GROUP BY P.name ORDER BY num desc LIMIT 1) as filter) as name 
from
  diagnostic_code as DC
;