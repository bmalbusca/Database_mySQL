USE dental_clinic;


UPDATE  employee 
SET salary = salary + (salary * 0.05)
WHERE employee.VAT IN (
	SELECT ap.VAT_doctor FROM appointment as ap
    GROUP by (ap.VAT_doctor)
    HAVING COUNT(DISTINCT ap.VAT_doctor, ap.date_timestamp) > 100

);