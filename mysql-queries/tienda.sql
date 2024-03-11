-- Query 1:
SELECT nombre FROM producto;
-- Query 2:
SELECT nombre, precio FROM producto;
-- Query 3:
SELECT * FROM producto;
-- Query 4:
SELECT nombre, precio, (precio * 1.09) AS 'USD' FROM producto;
-- Query 5:
SELECT nombre, precio AS 'euros', (precio * 1.09) AS 'dòlars nord-americans' FROM producto;
-- Query 6:
