-- Query 1:
SELECT nombre FROM producto;

-- Query 2:
SELECT nombre, precio FROM producto;

-- Query 3:
SELECT * FROM producto;

-- Query 4:
SELECT nombre, precio, (precio * 1.09) AS 'USD' FROM producto;

-- Query 5: AS
SELECT nombre, precio AS 'euros', (precio * 1.09) AS 'dòlars nord-americans' FROM producto;

-- Query 6: UPPER()
SELECT UPPER(nombre), precio FROM producto;

-- Query 7: LOWER()
SELECT LOWER(nombre), precio FROM producto;

-- Query 8: LEFT() -> Select X chars from a string.
SELECT nombre, LEFT(UPPER(nombre), 2) FROM fabricante;

-- Query 9: ROUND() -> Leaving 2 decimal places.
SELECT nombre, ROUND(precio, 2) FROM producto;

-- Query 10: ROUND() -> No decimal places.
SELECT nombre, ROUND(precio, 0) FROM producto;

-- Query 11: INNER JOIN
SELECT fabricante.codigo FROM fabricante INNER JOIN producto ON fabricante.codigo = producto.codigo_fabricante;

-- Query 12: DISTINCT (No repetition)
SELECT DISTINCT f.codigo FROM fabricante f INNER JOIN producto p ON f.codigo = p.codigo_fabricante;

-- Query 13: ORDER BY
SELECT nombre FROM fabricante ORDER BY nombre;

-- Query 14: ORDER BY -> DESC
SELECT nombre FROM fabricante ORDER BY nombre DESC;

-- Query 15: ORDER BY -> With two parameters
SELECT nombre FROM producto ORDER BY nombre, precio DESC;

-- Query 16: LIMIT
SELECT * FROM fabricante LIMIT 5;

-- Query 17: LIMIT + OFFSET
SELECT * FROM fabricante LIMIT 2 OFFSET 3;

-- Query 18:
SELECT nombre, precio FROM producto ORDER BY precio LIMIT 1;

-- Query 19:
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

-- Query 20: WHERE
SELECT p.nombre FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.codigo = 2;

-- Query 21: 
SELECT p.nombre, p.precio, f.nombre as 'nombre fabricante' FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo;

-- Query 22:
SELECT p.nombre, p.precio, f.nombre as 'nombre fabricante' FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY f.nombre;

-- Query 23:
SELECT p.codigo, p.nombre, f.codigo as 'codigo fabricante', f.nombre as 'nombre fabricante' FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY f.nombre;

-- Query 24:
SELECT p.nombre, p.precio, f.nombre as 'nombre fabricante' FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY p.precio LIMIT 1;
-- Query 24 - Option 2: using a subquery.
SELECT p.nombre, p.precio, f.nombre as 'nombre fabricante' FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio IN (SELECT MIN(precio) FROM producto);

-- Query 25:
SELECT p.nombre, p.precio, f.nombre as 'nombre fabricante' FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY p.precio DESC LIMIT 1;
-- Query 25 - Option 2: using a subquery.
SELECT p.nombre, p.precio, f.nombre as 'nombre fabricante' FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio IN (SELECT MAX(precio) FROM producto);

-- Query 26:
SELECT * FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo';

-- Query 27: AND
SELECT * FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Crucial' AND p.precio > 200;

-- Query 28: OR
SELECT * FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate';

-- Query 29: IN()
SELECT * FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre IN('Asus', 'Hewlett-Packard', 'Seagate');

-- Query 30: LIKE()
SELECT p.nombre, p.precio FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE('%e');

-- Query 31:
