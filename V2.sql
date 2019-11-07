CREATE VIEW dim_client AS
SELECT c.VAT, c.gender, c.age
FROM client as c;