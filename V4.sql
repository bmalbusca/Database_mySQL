CREATE VIEW facts_consults AS
SELECT final.VAT_client, final.date_timestamp, final.zip, COALESCE(final.num_procedures,0) as 'num_procedures', COALESCE(final.num_medications,0) as 'num_medications', COALESCE(final.num_diagnostic_codes,0) as 'num_diagnostic_codes' FROM (
	SELECT a.VAT_client,a.date_timestamp,z4.zip, z1.num_procedures, z2.num_medications,z3.num_diagnostic_codes FROM consultation as c LEFT OUTER JOIN appointment as a ON c.date_timestamp = a.date_timestamp AND c.VAT_doctor = a.VAT_doctor
		LEFT OUTER JOIN(
		SELECT ap.VAT_client, ap.VAT_doctor, ap.date_timestamp, ct.cnt as 'num_procedures' FROM appointment as ap JOIN  (
			SELECT pc.VAT_doctor,pc.date_timestamp, COUNT(distinct pc.VAT_doctor,pc.date_timestamp) as cnt FROM procedure_in_consultation  as pc
					GROUP BY pc.VAT_doctor,pc.date_timestamp) as ct
					ON ct.VAT_doctor=ap.VAT_doctor AND ct.date_timestamp=ap.date_timestamp) as z1
				ON z1.date_timestamp = a.date_timestamp AND z1.VAT_doctor = a.VAT_doctor
		LEFT OUTER JOIN(			
		SELECT ap.VAT_client, ap.VAT_doctor, ap.date_timestamp, ct.cnt as 'num_medications' FROM appointment as ap JOIN  (
			SELECT pres.ID, pres.VAT_doctor, pres.date_timestamp, COUNT(distinct pres.ID, pres.VAT_doctor,pres.date_timestamp) as cnt FROM prescription  as pres
					GROUP BY pres.ID, pres.VAT_doctor, pres.date_timestamp) as ct
					ON ct.VAT_doctor=ap.VAT_doctor AND ct.date_timestamp=ap.date_timestamp) as z2
				ON 	z2.date_timestamp = a.date_timestamp AND z2.VAT_doctor = a.VAT_doctor
		LEFT OUTER JOIN(		
		SELECT ap.VAT_client, ap.VAT_doctor, ap.date_timestamp, ct.cnt as 'num_diagnostic_codes' FROM appointment as ap JOIN  (
			SELECT cd.VAT_doctor, cd.date_timestamp, COUNT(distinct cd.VAT_doctor,cd.date_timestamp) as cnt FROM consultation_diagnostic  as cd
					GROUP BY cd.VAT_doctor, cd.date_timestamp) as ct
					ON ct.VAT_doctor=ap.VAT_doctor AND ct.date_timestamp=ap.date_timestamp) as z3
				ON 	z3.date_timestamp = a.date_timestamp AND z3.VAT_doctor = a.VAT_doctor
		LEFT OUTER JOIN(
		SELECT zip, VAT FROM client) as z4
		ON z4.VAT = a.VAT_client)as final;