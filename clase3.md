# Clase 3: SQL nivel medio (2)

## Funciones de ventana: ROW_NUMBER, RANK, DENSE_RANK, LEAD, LAG
Las funciones de ventana se utilizan para realizar cálculos en un conjunto de filas que están relacionadas entre sí.

Ejemplo:
```
SELECT column1, column2, column3, 
ROW_NUMBER() OVER (ORDER BY column3 DESC) AS 'RowNumber' 
FROM table1;
```
Esta consulta selecciona los valores de column1, column2 y column3 de table1, y utiliza la función de ventana ROW_NUMBER para asignar un número de fila a cada fila basado en el orden descendente de los valores de column3.