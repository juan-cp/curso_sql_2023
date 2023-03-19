# Clase 5: SQL nivel medio (3)


##  Triggers
Un Trigger o desencadenador es un tipo de procedimiento almacenado que se ejecuta automáticamente cuando se produce un evento de Lenguaje de Manipulación de Datos (DML), o sea cuando se ejecuta un INSERT, UPDATE o DELETE en una tabla o un evento de Lenguaje de Definición de Datos (DDL) por ejemplo un DROP TABLE.

Un gatillo se activa cuando ocurre un evento, por ende es condicionado a que el evento ocurra. El gatillo se puede activarse antes o después de que el evento ocurra, aunque para nivel intermedio de SQL consideramos gatillos con activación posterior a la ocurrencia del evento.

Para crear un Trigger, usar la siguiente sintaxis:
```
CREATE TRIGGER nombre_trigger
ON tabla_inicial FOR tipo_evento
AS
BEGIN
...
END
```
En este caso el tipo de evento puede ser un DML o DDL, para los DML seria INSERT/UPDATE/DELETE. El evento que activa el gatillo entregará un objeto inserted/updated/deleted que corresponderá a una tabla resultante o que recibe la acción: por ejemplo, si quiero gatillar una acción a partir de una inserción realizada, puedo obtener sus características llamando al objeto inserted.

Los triggers pueden ser modificados con ALTER TRIGGER y eliminados con DROP TRIGGER.

## Ejecución y Programación en SQL
Una ventaja importante de SQL es que no sólo es un lenguaje de consulta, sino también un lenguaje de programación: podemos crear programas que se ejecutan línea por línea, pueden iterar, agregar condicionales, etc.

En SQL Server podemos imponer condiciones sobre la ejecución de una instrucción SQL. La instrucción SQL que sigue a una palabra clave IF y su condición se ejecuta si se cumple la condición. La palabra clave ELSE opcional introduce otra instrucción SQL que se ejecuta cuando no se cumple la condición IF:
```
IF <condicion>
    BEGIN
        Ejecucion ...
    END
ELSE
    BEGIN
        Ejecucion ...
    END
```
Así mismo podemos almacenar conjuntos de instrucciones y ejecutarlas cuando queramos. Esto se puede hacer por medio de un Procedimiento Almacenado: si tiene una consulta SQL que escribe una y otra vez o tareas de DML, guárdela como un procedimiento almacenado y luego llámela para ejecutarla.

También se pueden pasar parámetros a un procedimiento almacenado, como una función (y recalcamos "como", ya que un procedimiento no exige retornar valores):
```
--sintaxis
CREATE PROCEDURE nombre_procedimiento (@param1 tipo1 ,
@param2 tipo2 ...)
AS
BEGIN
...
END
--ejecute el procedimiento 
EXEC nombre_procedimiento
```

## Comandos de conversión e IIF
La función CONVERT () convierte un valor (de cualquier tipo) en un tipo de datos específico.
```
CONVERT(tipodato, dato)
-- sintaxis alternativa
CAST(valor AS tipo_datos)
```
Además de los comandos case-when, existe una sintaxis simple para un if dentro de un campo determinado, para esto se usa el comando IIF
```
IIF(condicion, valor_if_true, valor_if_false)
```
Una forma astuta de reemplazar el siguiente case-when
```
case when var=x then 'a'
when var=y then 'b' 
else 'c'
end
```
es:
```
iif(var=x,'a',iif(var=y,'b','c'))
```
Es decir podemos anidar para aprovechar la sintaxis resumida de la instruccion iif.

## Funciones de Texto/Fecha
Existen una gran cantidad de funciones para operar con texto en SQL, que están ampliamente documentadas. Aquí mencionaremos las más importantes:

CHARINDEX(): La función CHARINDEX() busca una subcadena en una cadena y devuelve la posición CHARINDEX(substring, string, start)

CONCAT: La función CONCAT() agrega dos o más cadenas juntas. CONCAT(string1, string2, ...., string_n)

LEFT/RIGHT: La función LEFT ()/RIGHT () extrae varios caracteres de una cadena (empezando por la izquierda/derecha). LEFT/RIGHT(string, no_caracteres)

LTRIM/RTRIM elimina los espacios iniciales de una cadena.
LTRIM/RTRIM(string)

REPLACE: reemplaza todas las apariciones de una subcadena dentro de una cadena, con una nueva subcadena. REPLACE(string, vieja_subcadena, nueva_subcadena)

STUFF: elimina una parte de una cadena y luego inserta otra parte en la cadena, comenzando en una posición especificada.
STUFF(string, partida, largo, nuevo_string)

LOWER/UPPER : lleva todo a minúsculas o mayúsculas respectivamente

SUBSTRING: La función extrae algunos caracteres de una cadena. SUBSTRING(string, partida, largo)

Análogamente, entre las funciones de fecha a destacar tenemos:

CURRENT_TIMESTAMP entrega la fecha y hora actual

DATEDIFF(unidad, fecha1, fecha2) entrega la diferencia entre 2 fechas en la unidad especificada (por ejemplo 'd' días, 'm' meses, 'yy' años, 'ww' semanas, etc.)

DATEADD(unidad, cantidad, fecha) agrega a la fecha una cantidad de unidades de fecha (análogo a anterior)

EOMONTH(fecha,meses_agregar), entrega la fecha de fin de mes para una cantidad de meses atras (-) o adelante (+); si quiere el fin del mes actual, meses_agregar=0

DAY(),MONTH(),YEAR() obtiene día, mes, y año de una fecha en particular.

ISDATE() permite verificar si un texto es fecha o no.

@@DATEFIRST es una constante del sistema que define cual es el primer día de la semana.

DATEPART(unidad,fecha) entrega una parte de la fecha según definición. Por ejemplo para saber qué día de la semana es, colocar 'dw'