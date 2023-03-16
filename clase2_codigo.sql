--GROUP BY
select * from salarios
--total de sueldos por cargo y facultad

--as al lado de una columna: nombrar columna
select cargo, facultad, sum(salario) as suma_sueldos
from salarios
group by cargo, facultad

--Filtrar cargo facultad con suma de sueldos mayor a 5mm
select cargo, facultad, sum(salario) as suma_sueldos
from salarios
group by cargo, facultad
HAVING sum(salario) > 5000000

--buscar maximo salario por cargo en la escuela de ingeniería
select cargo, max(salario) as max_salario
from salarios
where facultad = 'Ingeniería'
group by cargo

--contar cuantas facultades hay 

select count(facultad) from salarios
--operadores de agregación pueden usar un distinct dentro 
-- y con ello agregar sin duplicados
select count(distinct facultad) from salarios
select distinct facultad from salarios

---CONSULTAS DE CRUCE

create table T1 (ID INT, NAME VARCHAR (10), PRIMARY KEY (ID))

INSERT into T1 select 1, 'A'
INSERT into T1 select 2, 'B'
INSERT into T1 select 4, 'D'
INSERT into T1 select 5, 'E'
INSERT into T1 select 9, 'I'

create table T2 (ID INT,NAME VARCHAR (10),PRIMARY KEY (ID))

INSERT into T2 select 1, 'a'
INSERT into T2 select 3, 'c'
INSERT into T2 select 4, 'd'
INSERT into T2 select 5, 'e'
INSERT into T2 select 7, 'h'

create table T3 (ID INT,NAME VARCHAR (10))

INSERT into T3 select 1, 'a'
INSERT into T3 select 3, 'c'
INSERT into T3 select 4, 'd'
INSERT into T3 select 4, 'd2'
INSERT into T3 select 5, 'e'
INSERT into T3 select 7, 'h'

create table T4 (ID INT, NAME VARCHAR (10))

INSERT into T4 select 1, 'A'
INSERT into T4 select 2, 'B'
INSERT into T4 select 4, 'D'
INSERT into T4 select 4, 'D2'
INSERT into T4 select 5, 'E'
INSERT into T4 select 9, 'I'


select * from T1
select * from T2
select * from T3
select * from T4

--sintaxis : FROM tabla1 <comando de cruce> tabla2 <ON> tabla1.pivote = tabla2.pivote

Select T1.id, T2.id, T2.NAME
FROM T1 INNER JOIN T2 on t1.id=t2.id

SELECT *
FROM T1 LEFT JOIN T2 ON T1.id=T2.ID

SELECT *
FROM T1 LEFT JOIN T2 ON T1.id=T2.ID
UNION ALL
SELECT *
FROM T1 RIGHT JOIN T2 ON T1.id=T2.ID

--full join--left join unido al rightjoin
Select *
From T1 full join T2
on T1.ID = T2.ID

--Union de queries : ambas tablas deben tener los mismos campos!
Select * from T1 
UNION ALL
select * from T2

--SUBCONSULTAS

select * from ventas

--ejemplo:
-- construir una consulta que nos entregue un campo mes_a�o y otro que sea utilidad (ganancia)
-- finalmente agregar (group by) la ganancia total por mes y a�o

--funcion month y year
select month(fecha) from ventas 
select year(fecha) from ventas

select month(fecha)+year(fecha) from ventas

--concat: une dos cadenas de caracteres
select concat(month(fecha),year(fecha)) as mes_yr, cantidad, ventas, costos from ventas

select subconsulta.mes_yr, sum(subconsulta.cantidad) as total_cant, sum(subconsulta.ventas) as total_monto,
sum(subconsulta.costos) as total_costos
from ( 

    select concat(month(fecha),'-',year(fecha)) as mes_yr, cantidad, ventas, costos from ventas
) as subconsulta
group by subconsulta.mes_yr


-- INSTRUCCION CASE - WHEN
select * from salarios
-- nueva columna que diga A si salario > 500000, B si salario <=500000
-- cuando queremos seleccionar todos los campos => *
-- cuando queremos seleccionar todos los campos, y agregar uno adicional => TABLA.*

select salarios.* , 
case
when salario>500000 then 'A'
when salario<=500000 then  'B'
end as tipo,
case when nombre like 'l%' then 'SI' else 'NO' end as parte_L
 from salarios

-- mostrar nombre, apellido y nueva columna si es que nombre parte con 'L'
