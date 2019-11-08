USE dental_clinic;

INSERT into diagnostic_code values('135599D', 'Periodontitis');
UPDATE  consultation_diagnostic  
SET ID = (SELECT p.ID FROM diagnostic_code as p WHERE  p.description LIKE 'Periodontitis')
WHERE consultation_diagnostic.ID IN(
	SELECT cl_code.ID FROM (
		SELECT  distinct cd.ID FROM consultation_diagnostic as cd 
		WHERE (cd.VAT_doctor, cd.date_timestamp) in (
			SELECT distinct pc.VAT, pc.date_timestamp	
			FROM procedure_charting  as pc WHERE  pc.measure > 4
		)) as cl_code
		WHERE cl_code.ID = (
			 SELECT dc.ID FROM diagnostic_code as dc
			 WHERE dc.description LIKE 'gingivitis' ));