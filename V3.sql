CREATE VIEW dim_location_client AS
SELECT c.zip, c.city
FROM client as c;