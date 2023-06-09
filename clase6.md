# Clase 6 : Tópicos avanzados de SQL e Introducción a bases NoSQL

## Pivot Tables 

Como sabemos, el instrumento de excelencia para operar con tablas dinámicas es MsExcel. Sin embargo, cuando los volumenes de datos superan el orden de 10 millones de registros, una tabla dinámica en excel comenzará a ponerse lenta e inmanejable. Para esto existe la función PIVOT que emula las funciones de excel mencionadas:
```
SELECT  <columna_no_pivote>,
        <lista_columnas_a_pivotear>
FROM
(<SELECT query que produce datos>)
AS <nombre_alias>
PIVOT
(
<funcion de agregado>(<columna agregado>)
FOR
[<campo desde el cual sale lista_columnas_a_pivotear>]
IN ( [ <lista_columnas_a_pivotear> ] )
) AS <alias_pivot>
```
Por ejemplo:

```
-- Creating a pivot table
SELECT category, [2019], [2020], [2021]
FROM mytable
PIVOT (SUM(sales) FOR year IN ([2019], [2020], [2021])) AS pvt

```

## Introducción a los formatos de data XML y JSON

JSON y XML son dos formatos de datos utilizados para intercambiar información entre diferentes aplicaciones y sistemas.

JSON (JavaScript Object Notation) es un formato de texto ligero que se utiliza comúnmente para enviar y recibir datos en aplicaciones web. Es fácil de leer y escribir, y se utiliza ampliamente en aplicaciones web modernas. Los datos se almacenan en pares clave-valor y se pueden anidar para representar estructuras más complejas.

XML (Extensible Markup Language) es un lenguaje de marcado que se utiliza para almacenar y transportar datos. Es un formato más antiguo que JSON y se utiliza en una amplia variedad de aplicaciones. Los datos se almacenan en etiquetas que describen la estructura y el contenido de los datos. XML también permite definir etiquetas personalizadas y crear documentos bien formados que pueden ser validados para asegurarse de que cumplen con un conjunto de reglas específicas.

En resumen, JSON y XML son formatos de datos utilizados para intercambiar información entre diferentes aplicaciones y sistemas. JSON es un formato más ligero y fácil de leer y escribir, mientras que XML es un lenguaje de marcado más antiguo que permite una mayor flexibilidad en la definición de etiquetas personalizadas y la validación de documentos.

Ejemplo de objeto JSON:

```
{
   "firstName": "John",
   "lastName": "Doe",
   "age": 30,
   "address": {
       "street": "123 Main St",
       "city": "Anytown",
       "state": "CA",
       "zip": "12345"
   },
   "phoneNumbers": [
       {
           "type": "home",
           "number": "555-1234"
       },
       {
           "type": "work",
           "number": "555-5678"
       }
   ]
}

```

Este objeto JSON representa información de una persona, incluyendo su nombre, edad, dirección y números de teléfono. Los valores se almacenan en pares clave-valor, y algunos valores, como la dirección y los números de teléfono, se almacenan como objetos anidados.

Ejemplo de documento XML:

```
<person>
   <firstName>John</firstName>
   <lastName>Doe</lastName>
   <age>30</age>
   <address>
      <street>123 Main St</street>
      <city>Anytown</city>
      <state>CA</state>
      <zip>12345</zip>
   </address>
   <phoneNumbers>
      <phoneNumber type="home">555-1234</phoneNumber>
      <phoneNumber type="work">555-5678</phoneNumber>
   </phoneNumbers>
</person>
```
Este documento XML también representa información de una persona, con valores almacenados en etiquetas que describen su contenido. Los valores anidados se representan como etiquetas anidadas, y los atributos, como el tipo de número de teléfono, se almacenan como atributos en las etiquetas correspondientes.

Es importante tener en cuenta que los objetos JSON y los documentos XML pueden variar en complejidad y estructura, y que estas son solo representaciones simples.

## Trabajando en SQL con data JSON y XML

```
-- Working with JSON data
DECLARE @json NVARCHAR(MAX) = '{"name": "John", "age": 30}'
SELECT JSON_VALUE(@json, '$.name') AS name, JSON_VALUE(@json, '$.age') AS age

-- Working with XML data
DECLARE @xml XML = '<person><name>John</name><age>30</age></person>'
SELECT @xml.value('(/person/name)[1]', 'nvarchar(100)') AS name, @xml.value('(/person/age)[1]', 'int') AS age


```

## 