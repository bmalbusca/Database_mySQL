SELECT count (n.date_timestamp)/count(c.date_timestamp) as Avg_Assistants
       count (n.date_timestamp)/count(c.date_timestamp) as Avg_Nurses
       count (n.date_timestamp)/count(c.date_timestamp) as Avg_Procedures
       count (n.date_timestamp)/count(c.date_timestamp) as Avg_Diagonostic_codes
       count (n.date_timestamp)/count(c.date_timestamp) as Avg_Prescriptions



SELECT AVG(nurses, consultation_assistant, procedures, diagnostic codes, prescriptions) FROM consultations
FROM table_name
WHERE ;
