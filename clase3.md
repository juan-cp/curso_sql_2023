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

## Partitioning

Ejecute funciones de ventana sobre particiones de datos, utilizando el operador OVER

```
ROW_NUMBER() OVER (PARTITION BY _____ ORDER BY _____ )

```

## Comandos de Escritura : UPDATE/DELETE

Como parte de las operaciones de escritura (que deben estar debidamente autorizadas) se pueden borrar filas o actualizar filas según una condicion en particular. La sintaxis de estas operaciones es la siguiente:

```
--Borrar registro
DELETE FROM tabla WHERE condicion
-- Actualizar registro
UPDATE tabla SET campo1=..,campo2=..
WHERE condicion
```

Recomendación: trabaje con esta programación en ambientes de desarrollo, ya que puede perder datos irreversiblemente si lo hace en un ambiente de producción.

Nota: Cuando usamos comando DELETE en nuestras tablas es necesariamente un cambio irreversible. Mientras que algunas operaciones con UPDATE pueden ser reversibles (matemáticamente u operacionalmente); por ejemplo, duplicar una fila con un UPDATE puede ser deshecho con otro UPDATE que divida a la mitad.

## Transacciones, concurrencia y locking 

Supongamos que tenemos una tabla bank_accounts con los siguientes datos:
```
id	account_number	balance
1	123456	        1000
2	789012	        500

```
Ahora, supongamos que queremos realizar dos operaciones en la tabla: transferir $500 de la cuenta con account_number 1 a la cuenta con account_number 2, y luego retirar $100 de la cuenta con account_number 2.

Podemos escribir dos consultas SQL para realizar estas operaciones:

```
-- Transfer $500 from account 1 to account 2
UPDATE bank_accounts SET balance = balance - 500 WHERE account_number = 1;
UPDATE bank_accounts SET balance = balance + 500 WHERE account_number = 2;

-- Withdraw $100 from account 2
UPDATE bank_accounts SET balance = balance - 100 WHERE account_number = 2;
```

Sin embargo, ¿qué sucedería si una de estas consultas fallara? Por ejemplo, si la primera consulta se ejecutara correctamente pero la segunda no, la cuenta con account_number 1 perdería $500 sin que la cuenta con account_number 2 recibiera el dinero.

Para evitar este problema, podemos utilizar una transacción. Una transacción es un conjunto de consultas que se ejecutan como una sola operación. Si alguna de las consultas falla, todas las consultas se deshacen y la base de datos vuelve a su estado original.

Aquí hay un ejemplo de cómo utilizar una transacción en SQL para realizar las operaciones anteriores:

```
BEGIN TRANSACTION;

UPDATE bank_accounts SET balance = balance - 500 WHERE account_number = 1;
UPDATE bank_accounts SET balance = balance + 500 WHERE account_number = 2;
UPDATE bank_accounts SET balance = balance - 100 WHERE account_number = 2;

COMMIT;
```

En este ejemplo, las tres consultas se colocan dentro de una transacción utilizando la cláusula BEGIN TRANSACTION. Si todas las consultas se ejecutan correctamente, la transacción se confirma utilizando la cláusula COMMIT. Si alguna de las consultas falla, la transacción se deshace automáticamente y la base de datos vuelve a su estado original.

De esta manera, podemos asegurarnos de que todas las operaciones se realicen correctamente o que se deshagan por completo, lo que garantiza la integridad de los datos.

El **control de concurrencia** es el proceso de gestionar múltiples transacciones que acceden y modifican los mismos datos en una base de datos simultáneamente. Las dos técnicas principales utilizadas para el control de concurrencia son el bloqueo y los niveles de aislamiento.

El **bloqueo(locking)** es una técnica utilizada para evitar que dos transacciones accedan y modifiquen los mismos datos simultáneamente. Hay dos tipos de bloqueos: bloqueos compartidos y bloqueos exclusivos.

Los bloqueos compartidos permiten que múltiples transacciones lean los mismos datos al mismo tiempo, pero solo una transacción puede adquirir un bloqueo exclusivo y modificar los datos. En SQL, se puede utilizar la instrucción `SELECT ... FOR SHARE` para adquirir un bloqueo compartido, y la instrucción `SELECT ... FOR UPDATE` para adquirir un bloqueo exclusivo.

Por ejemplo, considere el siguiente código SQL:

```
-- Adquirir un bloqueo compartido en la tabla de productos
SELECT * FROM products WHERE product_category = 'electronics' FOR SHARE;

-- Adquirir un bloqueo exclusivo en un producto específico en la tabla de productos
SELECT * FROM products WHERE product_id = 1234 FOR UPDATE;
```

Los **niveles de aislamiento** se utilizan para controlar la visibilidad y consistencia de los datos a los que acceden las transacciones. Hay cuatro niveles de aislamiento definidos en SQL: lectura sin confirmación, lectura confirmada, lectura repetible y serializable.

Los **niveles de aislamiento** se utilizan para controlar la visibilidad y consistencia de los datos a los que acceden las transacciones. Hay cuatro niveles de aislamiento definidos en SQL: sin confirmar, confirmado, repetible y serializable.

**Sin confirmar** permite que una transacción lea cambios sin confirmar realizados por otras transacciones, lo que puede provocar lecturas sucias (lectura de datos no confirmados). Se puede utilizar la declaración SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED para establecer el nivel de aislamiento.

**Confirmado** solo permite que una transacción lea datos confirmados, lo que evita las lecturas sucias. Sin embargo, puede provocar lecturas no repetibles (lectura de datos confirmados que han sido modificados por otra transacción antes de que la transacción actual se complete). Se puede utilizar la declaración SET TRANSACTION ISOLATION LEVEL READ COMMITTED para establecer el nivel de aislamiento.

**Repetible** garantiza que una transacción lee los mismos datos durante toda su duración, incluso si los datos son modificados por otras transacciones. Sin embargo, puede provocar lecturas fantasma (lectura de nuevas filas que no estaban presentes antes de que la transacción comenzara). Se puede utilizar la declaración SET TRANSACTION ISOLATION LEVEL REPEATABLE READ para establecer el nivel de aislamiento.

**Serializable** garantiza que los efectos de todas las transacciones concurrentes son los mismos que si se ejecutaran en serie (una tras otra). Este nivel evita las lecturas sucias, las lecturas no repetibles y las lecturas fantasma. Se puede utilizar la declaración SET TRANSACTION ISOLATION LEVEL SERIALIZABLE para establecer el nivel de aislamiento.

Por ejemplo, considere el siguiente código SQL:

```
-- Establecer el nivel de aislamiento en confirmado
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Comenzar una transacción
BEGIN TRANSACTION;

-- Leer datos de la tabla de productos
SELECT * FROM products WHERE product_category = 'electronics';

-- Actualizar datos en la tabla de productos
UPDATE products SET product_price = 100 WHERE product_id = 1234;

-- Confirmar la transacción
COMMIT;
```

## Llave primaria y campo autoincremental
Una llave primaria (o primary key, PK) es un campo (o combinación de campos) que identifica de manera única a cada fila en una tabla
```
CREATE TABLE nombre(f1 t1, f2 t2, PRIMARY KEY(campo_llave))
--alternativa
CREATE TABLE nombre(f1 t1 PRIMARY KEY, f2 t2...
```
La forma general de crear una tabla con un campo autoincremental es la siguiente:
```
CREATE TABLE nombre(f1 int IDENTITY, f2 t2,...)
```
En el caso anterior, el campo f1 es autoincremental, y siempre es un tipo de dato int.

## Llaves Foráneas
Una clave foránea es una columna o grupo de columnas de una tabla que contiene valores que coinciden con la clave primaria de otra tabla. Las claves foráneas se utilizan para unir tablas.

Generalmente las llaves foráneas se utilizan para construir referencias en tablas de paso (es decir, tablas que consolidan registros que relacionan 2 o más tablas).
```
create table tabla2 (campo1 tipo1, campo2 tipo2, ...campollave REFERENCES tabla1(campollave))
```

## Declaración de Variables y Funciones
Podemos usar la instrucción DECLARE para indicar o declarar una o más variables. A partir de ahí, podemos utilizar el comando SET para inicializar o asignar un valor a la variable.
```
DECLARE @variable tipo
SET @variable=valor
```
Una función definida por el usuario es una rutina que acepta parámetros, realiza una acción, como un cálculo complejo, y devuelve el resultado de esa acción como un valor.El valor de retorno puede ser un valor escalar (único) o una tabla. Una sintaxis para una función escalar es la siguiente:
```
CREATE FUNCTION nombre_funcion(par1 t1,par2 t2...)
RETURNS tipo_variable_salida 
BEGIN
....
returns @variable_salida
END

```
Nota sobre el código anterior: en resumen, creamos una variable de salida dentro del código de la función, que va a recibir el resultado del procedimiento que ejecute la función.



