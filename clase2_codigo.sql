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


--CTE: expresiones de tabla comunes
with cte as (
select salarios.* , 
case
when salario>500000 then 'A'
when salario<=500000 then  'B'
end as tipo,
case when nombre like 'l%' then 'SI' else 'NO' end as parte_L
 from salarios
)
SELECT tipo, avg(salario) from cte group by tipo 


-- objeto Similar: vistas

create view vista_salarios1 as
select salarios.* , 
case
when salario>500000 then 'A'
when salario<=500000 then  'B'
end as tipo,
case when nombre like 'l%' then 'SI' else 'NO' end as parte_L
 from salarios

select * from dbo.vista_salarios1