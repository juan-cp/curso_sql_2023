# Clase 2: SQL nivel medio

## Alias de columna y tabla

Los alias de columna y tabla se utilizan para cambiar el nombre de las columnas o tablas en una consulta. Los alias se definen utilizando la palabra clave AS o simplemente un espacio en blanco.

Ejemplo:
```
SELECT column1 AS 'Nombre de columna 1', column2 AS 'Nombre de columna 2' FROM table1 AS t1;
```

##  Uso de funciones agregadas: SUM, AVG, MAX, MIN, COUNT

Las funciones agregadas se utilizan para realizar cálculos en conjuntos de datos. Incluyen funciones como SUM, AVG, MAX, MIN y COUNT. Estas funciones se pueden utilizar para calcular totales, promedios, valores máximos y mínimos y recuentos de filas.

Ejemplo:
```
SELECT SUM(columna1) FROM tabla1;
```

Esta instrucción calcula la suma de la columna 1 de la tabla 1.

## Agrupar resultados con la cláusula GROUP BY y uso de HAVING

La cláusula `GROUP BY` se utiliza para agrupar filas que tienen el mismo valor en una o más columnas. La cláusula `HAVING` se utiliza para filtrar grupos basados en una condición.

Ejemplo:
```
SELECT column1, COUNT(column2) 
FROM table1 
GROUP BY column1 
HAVING COUNT(column2) > 1;
```

Esta consulta agrupa los valores de column1 en table1 y cuenta el número de valores de column2 para cada grupo. Luego, la cláusula `HAVING` filtra los grupos que tienen más de un valor de column2.


## Subconsultas y consultas anidadas

Las subconsultas se utilizan para realizar consultas dentro de una consulta. Las subconsultas pueden ser utilizadas en cláusulas WHERE, SELECT, FROM y HAVING.

Ejemplo:
```
SELECT column1, column2 
FROM table1 
WHERE column1 IN (SELECT column1 FROM table2 WHERE column2 = 'value');
```

Esta consulta devuelve los valores de column1 y column2 de table1 donde column1 está presente en la subconsulta, que selecciona los valores de column1 de table2 donde column2 es igual a 'value'.

## Expresiones CASE
Las expresiones CASE se utilizan para realizar evaluaciones condicionales en una consulta.

Ejemplo:
```
SELECT column1, column2, column3 
CASE 
  WHEN column3 > 0 THEN 'Positive' 
  WHEN column3 < 0 THEN 'Negative'
  ELSE 'Zero' 
END AS 'Column4' 
FROM table1;
```
Esta consulta selecciona los valores de column1, column2 y una nueva columna Column4 que se calcula utilizando una expresión CASE que evalúa los valores de column3.

## Expresiones de tabla comunes (CTE)
Las expresiones de tabla comunes se utilizan para definir subconsultas que pueden ser referenciadas varias veces en un script.

Ejemplo:
```
WITH cte AS (SELECT column1, column2 FROM table1 WHERE column3 > 0)
SELECT column1, COUNT(column2) 
FROM cte 
GROUP BY column1;
```
Esta consulta define una expresión de tabla común (cte) y realiza un conteo sobre ella.