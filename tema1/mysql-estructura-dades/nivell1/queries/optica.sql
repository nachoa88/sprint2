-- Llista el total de compres d’un client/a
SELECT count(g.bought_by_client_id) as 'compres del client' FROM client c INNER JOIN glasses g ON c.id = g.bought_by_client_id WHERE c.name = 'Client3';

-- Llista les diferents ulleres que ha venut un empleat durant un any.
SELECT g.* FROM glasses g INNER JOIN employee e ON g.sold_by_employee_id = e.id WHERE e.id = 1 AND YEAR(e.sold_date) = '2022';

-- Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.
 SELECT DISTINCT s.* FROM supplier s INNER JOIN brand b ON s.id = b.supplier_id INNER JOIN glasses g ON b.id = g.brand_id WHERE g.sold_by_employee_id IS NOT NULL;
