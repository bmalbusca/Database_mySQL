USE dental_clinic;

select 	(count_n_over_18/count_consultation_o_18) as avg_nurse_over_18,
		(count_n_under_18/count_consultation_u_18) as avg_nurse_under_18,
		(count_p_over_18/count_consultation_o_18) as avg_proc_over_18,
		(count_p_under_18/count_consultation_u_18) as avg_proc_under_18,
        (count_cd_over_18/count_consultation_o_18) as avg_codes_over_18,
		(count_cd_under_18/count_consultation_u_18) as avg_codes_under_18,
		(count_presc_over_18/count_consultation_o_18) as avg_presc_over_18,
		(count_presc_under_18/count_consultation_u_18) as avg_presc_under_18

FROM
(SELECT COUNT(c.date_timestamp)as count_consultation_o_18
FROM consultation as c, appointment as apt, client as cl
WHERE c.VAT_doctor = apt.VAT_doctor
AND c.date_timestamp = apt.date_timestamp
AND apt.VAT_client = cl.VAT
AND cl.age>18 and EXTRACT(year FROM c.date_timestamp)=2019) as consult_cl_over_18,

(SELECT COUNT(c.date_timestamp)as count_consultation_u_18
FROM consultation as c, appointment as apt, client as cl
WHERE c.VAT_doctor = apt.VAT_doctor
AND c.date_timestamp = apt.date_timestamp
AND apt.VAT_client = cl.VAT
AND cl.age<=18 and EXTRACT(year FROM c.date_timestamp)=2019) as consult_cl_under_18,


(SELECT COUNT(ca.VAT_nurse)as count_n_over_18
FROM consultation_assistant as ca, consultation as c, appointment as apt, client as cl
WHERE ca.VAT_doctor = c.VAT_doctor
AND ca.date_timestamp = c.date_timestamp
AND c.VAT_doctor = apt.VAT_doctor
AND c.date_timestamp = apt.date_timestamp
AND apt.VAT_client = cl.VAT
AND cl.age>18 and EXTRACT(year FROM c.date_timestamp)=2019) as nurses_cl_over_18,

(SELECT COUNT(ca.VAT_nurse)as count_n_under_18
FROM consultation_assistant as ca, consultation as c, appointment as apt, client as cl
WHERE ca.VAT_doctor = c.VAT_doctor
AND ca.date_timestamp = c.date_timestamp
AND c.VAT_doctor = apt.VAT_doctor
AND c.date_timestamp = apt.date_timestamp
AND apt.VAT_client = cl.VAT
AND cl.age<=18 and EXTRACT(year FROM c.date_timestamp)=2019) as nurses_cl_under_18,


(SELECT COUNT(p.name) as count_p_under_18
FROM procedure_in_consultation as p, consultation as c, appointment as apt, client as cl
WHERE p.VAT_doctor = c.VAT_doctor
AND p.date_timestamp = c.date_timestamp
AND c.VAT_doctor = apt.VAT_doctor
AND c.date_timestamp = apt.date_timestamp
AND apt.VAT_client = cl.VAT
AND cl.age<=18 and EXTRACT(year FROM c.date_timestamp)=2019) as proc_under_18,


(SELECT COUNT(p.name)as count_p_over_18
FROM procedure_in_consultation as p, consultation as c, appointment as apt, client as cl
WHERE p.VAT_doctor = c.VAT_doctor
AND p.date_timestamp = c.date_timestamp
AND c.VAT_doctor = apt.VAT_doctor
AND c.date_timestamp = apt.date_timestamp
AND apt.VAT_client = cl.VAT
AND cl.age>18 and EXTRACT(year FROM c.date_timestamp)=2019) as proc_over_18,

(SELECT COUNT(cd.ID) as count_cd_under_18
FROM consultation_diagnostic as cd, consultation as c, appointment as apt, client as cl
WHERE cd.VAT_doctor = c.VAT_doctor
AND cd.date_timestamp = c.date_timestamp
AND c.VAT_doctor = apt.VAT_doctor
AND c.date_timestamp = apt.date_timestamp
AND apt.VAT_client = cl.VAT
AND cl.age<=18 and EXTRACT(year FROM c.date_timestamp)=2019) as code_under_18,


(SELECT COUNT(cd.ID) as count_cd_over_18
FROM consultation_diagnostic as cd, consultation as c, appointment as apt, client as cl
WHERE cd.VAT_doctor = c.VAT_doctor
AND cd.date_timestamp = c.date_timestamp
AND c.VAT_doctor = apt.VAT_doctor
AND c.date_timestamp = apt.date_timestamp
AND apt.VAT_client = cl.VAT
AND cl.age>18 and EXTRACT(year FROM c.date_timestamp)=2019) as code_over_18,

(SELECT COUNT(pres.name) as count_presc_under_18
FROM prescription as pres, consultation as c, appointment as apt, client as cl
WHERE pres.VAT_doctor = c.VAT_doctor
AND pres.date_timestamp = c.date_timestamp
AND c.VAT_doctor = apt.VAT_doctor
AND c.date_timestamp = apt.date_timestamp
AND apt.VAT_client = cl.VAT
AND cl.age<=18 and EXTRACT(year FROM c.date_timestamp)=2019) as presc_under_18,

(SELECT COUNT(pres.name) as count_presc_over_18
FROM prescription as pres, consultation as c, appointment as apt, client as cl
WHERE pres.VAT_doctor = c.VAT_doctor
AND pres.date_timestamp = c.date_timestamp
AND c.VAT_doctor = apt.VAT_doctor
AND c.date_timestamp = apt.date_timestamp
AND apt.VAT_client = cl.VAT
AND cl.age>18 and EXTRACT(year FROM c.date_timestamp)=2019) as presc_over_18;
