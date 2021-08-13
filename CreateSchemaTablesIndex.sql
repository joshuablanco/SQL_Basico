USE DeliPizza;

GO
-------------------------SENTENCIAS DQL----------------------- 
SELECT * FROM Productos
SELECT TOP (2) tipo FROM Productos;
SELECT * FROM Clientes 
SELECT * FROM Descuentos;
SELECT * FROM Compras;

GO

----------------------- SENTENCIAS DML -----------------------
--- PRODUCTOS ---
INSERT INTO Productos VALUES ('Pizza','Pollo',5000);
INSERT INTO Productos VALUES ('Pizza','Vegetariana',5000);
INSERT INTO Productos VALUES ('Pizza','Napolitana',6000);
INSERT INTO Productos VALUES ('Lasagna','Pollo Lasagna',8000);
INSERT INTO Productos VALUES ('Lasagna','Carnes',8000);
INSERT INTO Productos VALUES ('Lasagna','Champignon pollo',8500);

--UPDATE Productos SET tipo = 'Risotto' WHERE id = 5;

--DELETE FROM Compras WHERE id = 3
--DELETE FROM Productos WHERE id=6 ;
--- TRAN ---
--BEGIN TRAN 
--UPDATE Clientes 
--SET    Apellido = 'Prueba', 
--       Nombre = 'Prueba' 
--WHERE  Id = 3 
--SELECT @@TRANCOUNT AS OpenTransactions
--COMMIT TRAN
--SELECT @@TRANCOUNT AS OpenTransactions
--- CLIENTES ---
INSERT INTO Clientes VALUES ('Leo','Messi','calle siempre viva 23-10');
INSERT INTO Clientes VALUES ('Marco','Verratti','calle L''a Femme 56');
INSERT INTO Clientes VALUES ('Andres','Rojas','calle Andrew 78');

--- DESCUENTOS ---
INSERT INTO Descuentos VALUES (10);
INSERT INTO Descuentos VALUES (20);
INSERT INTO Descuentos VALUES (30);
INSERT INTO Descuentos VALUES (40);
INSERT INTO Descuentos VALUES (50);

--- COMPRAS ---
INSERT INTO Compras VALUES(1,1,1);
INSERT INTO Compras VALUES(2,2,3);
INSERT INTO Compras VALUES(3,3,2);
INSERT INTO Compras VALUES(null,3,4);
INSERT INTO Compras VALUES(1,1,5);
INSERT INTO Compras VALUES(2,4,3);
INSERT INTO Compras VALUES(3,4,5);
INSERT INTO Compras VALUES(2,5,2);
INSERT INTO Compras VALUES(3,3,2);
INSERT INTO Compras VALUES(2,4,4);
INSERT INTO Compras VALUES(1,2,5);
INSERT INTO Compras VALUES(3,1,3);
INSERT INTO Compras VALUES(1,5,1);

Go

--- ------------------------- SENTENCIAS DQL Combinations ----------------------- 
SELECT DISTINCT cliente FROM Compras ORDER BY cliente ASC;
SELECT DISTINCT cliente FROM Compras;

-- WHERE

SELECT * FROM Productos WHERE precio > 5000
SELECT DISTINCT nombre FROM Clientes WHERE Nombre = 'Leo';
SELECT * FROM Compras WHERE descuento = 4
SELECT * FROM Clientes WHERE Nombre LIKE 'L%';
SELECT * FROM Clientes WHERE Nombre LIKE '%o';
SELECT * FROM Clientes WHERE Nombre LIKE '%r%';
SELECT * FROM Clientes WHERE Nombre LIKE 'm%o';
SELECT * FROM Compras WHERE producto BETWEEN 2 AND 4;

DELETE FROM Compras
DELETE FROM Productos
-- And Or Not ---
SELECT DISTINCT producto FROM Compras WHERE descuento > 1 AND descuento < 6;
SELECT * FROM Compras WHERE producto = 2  AND (descuento = 5 OR descuento = 1);
SELECT * FROM Compras WHERE (producto = 2 OR producto = 1) AND ( descuento = 3  OR descuento = 5 );
SELECT * FROM Compras WHERE (producto = 2 OR producto = 1) AND NOT ( descuento = 3  OR descuento = 5 );
SELECT * FROM Compras WHERE producto = 2 ;

-- Order by ---
SELECT * FROM Compras WHERE (producto = 2 OR producto = 1) AND ( descuento = 3  OR descuento = 5 );

SELECT * FROM Compras WHERE (producto = 2 OR producto = 1) AND ( descuento = 3  OR descuento = 5 )
ORDER BY cliente DESC;

SELECT * FROM Compras WHERE (producto = 2 OR producto = 1) AND ( descuento = 3  OR descuento = 5 )
ORDER BY descuento ASC;

GO
--- Group by ---
SELECT producto FROM Compras WHERE descuento > 2 ;
SELECT producto FROM Compras WHERE descuento > 2 GROUP BY producto;

SELECT cliente, producto, descuento FROM Compras WHERE (producto = 2 OR producto = 1) AND ( descuento = 3  OR descuento = 5 )
ORDER BY descuento ASC;

SELECT producto, descuento FROM Compras WHERE (producto = 2 OR producto = 1) AND ( descuento = 3  OR descuento = 5 )
GROUP BY producto, descuento
ORDER BY descuento ASC;

GO

-- Funciones de agregacion --
--Min
SELECT * FROM Productos
SELECT * FROM Compras;

SELECT MIN(precio) AS precio_min, MAX(precio) AS precio_max, AVG(precio) AS promedio_precio, COUNT(*) cuenta
FROM Productos;

SELECT COUNT(id) AS cantidad_repetida, precio FROM Productos GROUP BY precio;

SELECT COUNT(id) AS cantidad_repetida FROM Compras 
WHERE (producto = 2 OR producto = 1);

-- func agregada no group
SELECT MIN(descuento) AS descuento_minimo, cliente FROM Compras 
WHERE (producto = 2 OR producto = 1);

SELECT MIN(descuento) AS descuento_minimo, cliente, producto FROM Compras 
WHERE (producto = 2 OR producto = 1) 
GROUP BY cliente, producto;

SELECT MIN(descuento) AS descuento_minimo, cliente, producto FROM Compras 
WHERE (producto = 2 OR producto = 1) 
GROUP BY cliente, producto
ORDER BY descuento_minimo  ASC;

-- JOIN -- 
SELECT  * FROM Compras;
SELECT * FROM Compras
JOIN Productos
ON Compras.producto = Productos.id

SELECT Compras.producto, Productos.nombre FROM Compras
INNER JOIN Productos
ON Compras.producto = Productos.id


SELECT Compras.producto AS compra, Productos.nombre AS nombre, SUM(Productos.precio) AS precio FROM Compras
INNER JOIN Productos
ON Compras.producto = Productos.id
GROUP BY Compras.producto, Productos.nombre

SELECT  Compras.producto AS compra, Productos.nombre,  Clientes.Nombre, SUM(Productos.precio) AS precio , COUNT(*) AS cuenta
FROM ((Compras INNER JOIN Productos ON Compras.producto = Productos.id)
INNER JOIN Clientes ON Compras.cliente = Clientes.id)
GROUP BY Compras.producto, Productos.nombre, Clientes.Nombre

-- LEFT JOIN
SELECT * FROM COMPRAS ;
SELECT * FROM Productos; 

SELECT Compras.producto, Productos.nombre FROM Compras
LEFT JOIN Productos
ON Compras.producto = Productos.id;

SELECT Compras.producto, Productos.nombre FROM Productos
LEFT JOIN Compras
ON Productos.id = Compras.producto ;

SELECT * FROM Compras
LEFT JOIN Productos
ON Compras.producto = Productos.id;

SELECT * FROM Productos
LEFT JOIN Compras
ON Productos.id = Compras.producto;

GO

-- -- RIGHT JOIN

SELECT *  FROM Compras
RIGHT JOIN Productos
ON Compras.producto = Productos.id;

SELECT * FROM Productos
LEFT JOIN Compras
ON Compras.producto = Productos.id;

GO 

--- OUTER JOIN ---
SELECT * FROM Productos
FULL OUTER JOIN Compras
ON Compras.producto = Productos.id;

SELECT * FROM Clientes
FULL OUTER JOIN Compras
ON Compras.cliente = Clientes.id;

--- UNION ----

SELECT Clientes.Nombre FROM Clientes
UNION 
SELECT Productos.nombre FROM Productos


