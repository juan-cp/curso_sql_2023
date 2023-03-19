--TRIGGERS
select * from salarios
select * from registro_cargos

--crear un gatillo que agrega un cargo a registro_cargos desde una insercion en salarios
create trigger agrega_cargo
on --sobre què tabla ocurre el evento
salarios
for insert --tipo de evento (delete si es borrado) 
as 
begin
	--fila insertada se transforma en un objeto llamado INSERTED (DELETED si es fila borrada)
	insert into registro_cargos select cargo from inserted

end

select * from registro_cargos
insert into salarios values(1979,'carrasco','juan','santiago','ingeniería','Ayudante Lab',500000,'2019-01-02','1988-03-23')


--ej2 gatillo de borrado
--trigger que borre en salarios si elimino un cargo de registro_cargos

create trigger eliminar_cargo
on registro_cargos
for delete 
as
begin
	delete from salarios where cargo=(select cargo_reg from deleted)	
end

--drop trigger ..... para borrar o desactivar


delete from registro_cargos where cargo_reg='Ayudante Lab'

select * from salarios
where cargo='Ayudante Lab'

--SQL como lenguaje procedural 
--IF /ELSE
--Hola mundo
print('Hola Mundo')

--programa se conoce coloquialmente como "jalisco nunca pierde"
-- recibe un input
-- entrega como resultado input+1



--declarar las variable
declare @x int
set @x=2
print('Jalisco dice ' + str(@x+1))

--Comparador
--imprimir 'Mayor, Menor o Igual' dependiendo el caso
declare @x int
declare @y int
set @x=4
set @y=3
if @x < @y
begin
	print('X es menor a Y')
end
else
begin
	if @x=@y 
	begin
		print('X es igual a Y')
	end
	else
	begin
		print('X es mayor que Y')
	end
end
--procedimiento almacenado
--a partir del programa anterior, crear un procedimiento almacenado
create procedure comparador(@x int, @y int)
as 
begin

if @x < @y
begin
	print('X es menor a Y')
end
else
begin
	if @x=@y 
	begin
		print('X es igual a Y')
	end
	else
	begin
		print('X es mayor que Y')
	end
end

end

exec [dbo].[comparador] 3,2
--nota : si el proceso tiene parametros de entrada, escribirlos sin parentesis separados por comas
 
--CONVERT/IIF

SELECT 25.65+25.75
SELECT CONVERT(varchar,25.65)+CONVERT(varchar,25.75)
select CONVERT(date,'2019-01-02 14:50:00')

--ejemplo: entregar fecha desde texto formato latinoamericano
select '28-07-2020' --texto
select right('28-07-2020',4)
select left('28-07-2020',2)
select substring('28-07-2020',charindex('-','28-07-2020')+1,2)

select concat(right('28-07-2020',4),'-', substring('28-07-2020',charindex('-','28-07-2020')+1,2),'-',left('28-07-2020',2))

--creando una funcion

alter function conversion_fecha(@fecha varchar(max))
returns date 
AS
BEGIN
    declare @fecha_salida DATE
    set @fecha_salida = (select convert(date,concat(right(@fecha,4),'-', substring(@fecha,charindex('-',@fecha)+1,2),'-',left(@fecha,2))))
    
    return @fecha_salida
END

select dbo.conversion_fecha('31-07-2022')



 '2020-07-28' --date7


SELECT 25.65+25.75+CONVERT(varchar,21.55)
SELECT IIF(500<1000,'Y','N')
----Funciones de texto
SELECT CHARINDEX('te','cliente')
SELECT CHARINDEX('te','cliente',0)
SELECT CONCAT(25.65,25.75,21.55)
SELECT LEFT('program bi',3)
SELECT RIGHT('program bi',3)
SELECT LEN('programbi')
SELECT '   hola  '
SELECT LTRIM('   hola  ')
SELECT LEN(LTRIM('   hola  '))
SELECT RTRIM('   hola  ')
SELECT LEN(RTRIM('   hola  '))
SELECT TRIM('    hola     ')
SELECT LEN(TRIM('    hola     '))
SELECT REPLACE('Tutorial','T','S')
SELECT UPPER('sql')
SELECT SUBSTRING('Tutorial SQL',1,3)
SELECT REPLACE('Tutorial de SQL','SQL','HTML')

--Funciones de fecha

SELECT CURRENT_TIMESTAMP  --especificamente un datetime
SELECT CONVERT(date,CURRENT_TIMESTAMP)
--diferencia de fechas en dias (d), meses (m) semanas (ww)
SELECT DATEDIFF(d,'2022-01-01',CONVERT(date,CURRENT_TIMESTAMP))
SELECT DATEDIFF(m,'2022-01-01',CONVERT(date,CURRENT_TIMESTAMP))
SELECT DATEDIFF(ww,'2022-01-01',CONVERT(date,CURRENT_TIMESTAMP))
--agregar a fecha de hoy 3 meses / 1 año más
--(d,m,ww,yy)
SELECT DATEADD(m,3,CONVERT(date,CURRENT_TIMESTAMP))
SELECT DATEADD(yy,1,CONVERT(date,CURRENT_TIMESTAMP))
SELECT DATEADD(m,-3,CONVERT(date,CURRENT_TIMESTAMP))
--fin de mes actual
SELECT EOMONTH(CONVERT(date,CURRENT_TIMESTAMP),0)
--fin de mes anterior
SELECT EOMONTH(CONVERT(date,CURRENT_TIMESTAMP),-1)
--fin del próximo mes
SELECT EOMONTH(CONVERT(date,CURRENT_TIMESTAMP),+1)

select day(CONVERT(date,CURRENT_TIMESTAMP))
select month(CONVERT(date,CURRENT_TIMESTAMP))
select year(CONVERT(date,CURRENT_TIMESTAMP))

--que dia de la semana es hoy?
--DATEPART(d,...) <=> day()
--DATEPART(m,...) <=> month()
--DATEPART(yy,...) <=> year()
--datepart(ww,...) <=> semana del año que esta una fecha
--datepart(dw,...) <=> dia de la semana para una fecha 

SELECT DATEPART(dw,CONVERT(date,CURRENT_TIMESTAMP))