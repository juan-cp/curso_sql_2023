# Clase 3: SQL nivel medio (1)

## Joins
Los joins se utilizan para combinar dos o más tablas en una sola consulta. Los tipos de joins más comunes son INNER JOIN, LEFT JOIN, RIGHT JOIN y FULL OUTER JOIN.

Ejemplo:

```
SELECT column1, column2, column3 
FROM table1 
INNER JOIN table2 
ON table1.column1 = table2.column1;
```

Esta consulta combina los datos de table1 y table2 en una sola consulta utilizando un INNER JOIN basado en la columna column1.

## Operadores de conjuntos: UNION, INTERSECT, EXCEPT
Los operadores de conjuntos se utilizan para combinar resultados de dos o más consultas en una sola consulta.

Ejemplo:
```
SELECT column1 
FROM table1 
UNION 
SELECT column1 
FROM table2;
```

Esta consulta combina los valores de column1 de table1 y table2 en una sola columna utilizando el operador de conjunto UNION.