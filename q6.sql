SELECT * FROM client



SELECT count (ca.date_timestamp)/count(c.date_timestamp) AS Avg_Assistants
       count (proc.date_timestamp)/count(c.date_timestamp) AS Avg_Procedures
       count (codes.date_timestamp)/count(c.date_timestamp) AS Avg_Diagonostic
       count (presc.date_timestamp)/count(c.date_timestamp) AS Avg_Prescriptions

FROM consultation AS c
        LEFT OUTER JOIN consultation_assistant AS ca
        ON c.VAT_doctor = ca.VAT_doctor AND c.date_timestamp = ca.date_timestamp
        LEFT OUTER JOIN procedure_in_consultation AS proc
        ON c.VAT_doctor = proc.VAT_doctor AND  c.date_timestamp = proc.date_timestamp
        LEFT OUTER JOIN consultation_diagnostic AS cd
        ON c.VAT_doctor =  cd.VAT_doctor AND c.date_timestamp = cd.date_timestamp
        LEFT OUTER JOIN prescription AS presc
        ON c.VAT_doctor= presc.VAT_doctor AND c.date_timestamp = presc.date_timestamp
WHERE year(c.date_timestamp) = 2019
