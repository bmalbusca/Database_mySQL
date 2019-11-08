USE dental_clinic;

INSERT into diagnostic_code values('135599D', 'Periodontitis');

/*UPDATE consultation_diagnostic as diagnosis
set ID = (select dc.ID from diagnostic_code as dc where description = 'Periodontitis')
where diagnosis.ID in (select cd2.ID from diagnostic_code as dc2 where description like '%gingivitis%')
and exists(select diagnosis.VAT_doctor from
procedure_charting as chart
where diagnosis.VAT_doctor = chart.VAT and diagnosis.date_timestamp = chart.date_timestamp
group by diagnosis.VAT_doctor, diagnosis.date_timestamp
having avg(measure) > 4);
*/

UPDATE  consultation as c
SET c.SOAP_A = 'Periodontitis'
WHERE (c.VAT_doctor, c.date_timestamp) in (
SELECT d.VAT_doctor,d.date_timestamp FROM (
SELECT  c.VAT_doctor,c.date_timestamp ,c.SOAP_A FROM consultation as c, (SELECT pc.VAT, pc.date_timestamp	FROM procedure_charting  as pc 
WHERE  pc.measure > 4) as pc4
WHERE c.VAT_doctor = pc4.VAT and c.date_timestamp = pc4.date_timestamp) as d
WHERE d.SOAP_A  LIKE 'Periodontitis') 
;





