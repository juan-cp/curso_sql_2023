
# Clase 1: Introducción a SQL

## ¿Qué es SQL?

SQL significa Structured Query Language (Lenguaje de Consulta Estructurado) y es un lenguaje de programación utilizado para administrar bases de datos relacionales. SQL te permite realizar diversas operaciones en los datos almacenados en las bases de datos, como consultas, inserciones, actualizaciones y eliminaciones de datos.

## Bases de datos relacionales y tablas

Una base de datos relacional es un tipo de base de datos que almacena los datos en tablas. Una tabla está compuesta por filas y columnas, donde cada columna representa un tipo de datos diferente, y cada fila representa un solo registro. 

 Una BBDD puede contener varias tablas, y las tablas estar relacionadas entre sí por campos que comparten, llaves (un tipo de campo que revisaremos más adelante) y relaciones de cardinalidad entre sus registros (que también veremos más adelante). El conjunto de tablas y relaciones en una BBDD se conoce como el **Esquema de una BBDD** y se puede representar gráficamente en un diagrama que se conoce como **diagrama Entidad-Relación** 

Ejemplo de diagrama ER: https://docs.staruml.io/working-with-additional-diagrams/entity-relationship-diagram

## Tipos de Datos

Las bases de datos en las que se puede consultar con SQL se les conoce como bases de datos relacionales, mientras que los datos que se almacenan en ellas son datos estructurados; es decir, corresponden a un tipo bien específico de dato que caerá en las siguientes categorías:

Tipos Numéricos
- `INT`: Número enteros, en un rango de $[-2^{31},2^{31}]$
- `BIGINT`: Número entero entre  $[-2^{64},2^{64}]$ 
- `BIT`: Para un número entero que puede ser 0 ó 1.
- `FLOAT`: Números decimales

Tipos de Texto/Fecha
- `CHAR`: Este tipo es para cadenas de longitud fija. Su longitud va desde 1 a 255 caracteres. Siempre se ocupara el largo que hayamos dado (añadiendo espacios en el caso que faltasen caracteres).
- `VARCHAR`: Para una cadena de caracteres de longitud variable de hasta 8.060.
- `NVARCHAR`: texto de longitud variable que puede tener hasta 65.535 caracteres.
- `DATE`: Para almacenar fechas. El formato por defecto es yyyymmdd.
- `DATETIME`: Combinacion de fecha y hora.

## Data Definition Language

Las declaraciones DDL o Data Definition Language corresponden a aquellas que intervienen de alguna manera el esquema de la BBDD o manipulan nuevos objetos adyacentes a las tablas. Las declaraciones DDL suelen empezar con un comando `CREATE` en caso de que se crean objetos, `ALTER` para modificarlos y `DROP` para borrarlos.

Por ejemplo:
``
CREATE TABLE mitabla (campo1 tipo1, campo2 tipo2 ... )
DROP TABLE mitabla 
``
ALTER TABLE cambia la estructura de una tabla. Por ejemplo, puede agregar o eliminar columnas, crear o borrar índices, cambiar el tipo de columnas existentes o cambiar el nombre de las columnas o de la tabla en sí.

Ejemplo de agregar nueva columna:
``
    ALTER TABLE mitabla
    ADD camponuevo tipo
``
También puede ir acompañado de borrar columnas:
``
ALTER TABLE mitabla DROP COLUMN nombre_columna1, DROP COLUMN nombre_columna2...
``
Para borrar una tabla, usar comando DROP TABLE. Para vaciar usar TRUNCATE TABLE:
``
    DROP TABLE nombre-tabla 
    TRUNCATE TABLE nombre-tabla
``
Ojo: operaciones CREATE/ALTER/DROP requieren permisos de escritura

## Inserción de registros y populating

`INSERT` crea una fila con cada columna establecida en su valor predeterminado

``INSERT INTO tbl_name ( campos...) VALUES( valores...);``
    
Es decir, se cargan una lista de campos determinados (que pueden ser todos) y sus valores respectivos. Un valor de un campo también se le conoce como _Instancia_.

*   Las cadenas de texto siempre deben ir entre comillas.
*   Por ejemplo las fechas en SQL son en formato yyyy-mm-dd. Deben ir entre comillas como cadenas de texto.
*   Los números decimales separan el número con la parte decimal con un punto.
    
## Sintaxis básica de SQL
SQL utiliza una sintaxis similar a otros lenguajes de programación, compuesta por palabras clave, operadores y expresiones. Las sentencias SQL suelen estar compuestas por cláusulas como SELECT, FROM, WHERE, ORDER BY y GROUP BY, y se terminan con un punto y coma (;).

``
    --Sintaxis consulta
    SELECT campo1, campo2, ...
    FROM tabla
    WHERE condicion
    ORDER BY campo1 ASC/DESC
    --Seleccionar toda una tabla
    SELECT * FROM tabla
``  

## Sentencia SELECT
La sentencia SELECT se utiliza para recuperar datos de una o más tablas. Suele estar compuesta por la palabra clave SELECT, seguida de una lista de columnas a recuperar, y la cláusula FROM, que especifica la tabla o tablas de las que recuperar los datos.

Ejemplo:

``SELECT columna1, columna2, columna3 FROM tabla1;``

Esta sentencia recupera los valores de columna1, columna2 y columna3 de tabla1.

## Filtrado de datos con la cláusula WHERE

La cláusula WHERE se utiliza para filtrar datos en función de ciertas condiciones. Suele utilizarse en conjunción con la sentencia SELECT y permite recuperar solo las filas que coinciden con una condición específica.


``SELECT columna1, columna2 FROM tabla1 WHERE columna3 = 'valor'``

Esta sentencia recupera los valores de columna1 y columna2 de tabla1 donde columna3 es igual a 'valor'.


La cláusula `WHERE` involucra condiciones. En general una condicion es una proposición lógica, es decir un enunciado cuyo valor es verdadero o falso. Siendo `WHERE` una instrucción en bloque (como `SELECT` también), evaluará qué registros de un campo cumplen con la condición, y los filtrará del bloque final.
```
    --CONDICIONALES
    --operadores
    WHERE campo > valor -- mayor que
    WHERE campo < valor --menor que
    WHERE campo >= valor --mayor o igual
    WHERE campo <= valor --menor o igual
    WHERE campo <> valor -- distinto
    WHERE campo = valor --igual
    WHERE campo LIKE patron (veremos en Seccion 2)
    WHERE campo IN (valor1, valor2...)--si el campo esta en un conjunto de valores
    WHERE campo BETWEEN rangomin AND rangomax --si el campo esta entre rangomin y rango max
    WHERE campo IS NULL -- filas en donde el campo seleccionado es null
    WHERE campo IS NOT NULL --filas donde el campo no es null (vacio)
``` 

Respecto a lo anterior, entenderemos los valores `NULL`, como un dato vacío que posee algún campo para un registro específico en un tabla. Es decir, una celda donde no hay nada (ni siquiera espacios en blanco, por lo que una celda en blanco podría no ser `NULL`; en general las celdas vacías mostrarán un `NULL` para evitar confusiones).

Como `WHERE` evalúa proposiciones lógicas, sus valores de verdad pueden ser sujeto a los operadores tradicionales lógicos (de conjunción, disyunción, negación).
```
    -Operadores Logicos
    --operador AND
    SELECT campo1, campo2, ...
    FROM tabla
    WHERE condicion1 AND condicion2 AND condicion3...
    --operador OR
    SELECT campo1, campo2, ...
    FROM tabla
    WHERE condicion1 OR condicion2 OR condicion3...
    --operador NOT
    SELECT campo1, campo2, ...
    FROM tabla
    WHERE NOT condicion;
``` 

## Ordenación de datos con la cláusula ORDER BY

La cláusula ORDER BY se utiliza para ordenar los resultados de una consulta en orden ascendente o descendente. Suele utilizarse en conjunción con la sentencia SELECT y permite especificar la columna o columnas por las que ordenar.

``SELECT columna1, columna2 FROM tabla1 ORDER BY columna1 ASC;``

Esta sentencia recupera los valores de columna1 y columna2 de tabla1 ordenados por columna1 en orden ascendente.

## Limitación de resultados con la cláusula LIMIT
La cláusula LIMIT se utiliza para limitar el número de filas devueltas por una consulta. Suele utilizarse en conjunción con la sentencia SELECT y permite especificar el número máximo de filas a devolver.

Ejemplo:
``SELECT columna1, columna2 FROM tabla1 LIMIT 10;``

Esta sentencia recupera las primeras 10 filas de columna1