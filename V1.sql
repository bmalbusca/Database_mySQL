CREATE VIEW dim_date AS
SELECT date_timestamp, EXTRACT(DAY from date_timestamp) AS Day, EXTRACT(MONTH from date_timestamp) AS Month , Extract(YEAR from date_timestamp) AS Year
FROM consultation;