create table productos (
  id INTEGER, 
  producto VARCHAR(2),
  tienda INTEGER,
  fecha DATE,
  inventario INTEGER
  )

INSERT INTO productos VALUES 
(1,'A',1,'2022-01-01',100),
(2,'A',1,'2022-02-01',200),
(3,'A',2,'2022-01-01',150),
(4,'A',2,'2022-02-01',250),
(5,'B',1,'2022-01-01',75),
(6,'B',1,'2022-02-01',125),
(7,'B',2,'2022-01-01',100),
(8,'B',2,'2022-02-01',200)

select * from productos

SELECT id, producto, tienda, fecha , inventario,  ROW_NUMBER() OVER (ORDER BY inventario DESC) as row_number FROM productos;
SELECT id, producto, tienda, fecha , inventario,  ROW_NUMBER() OVER (PARTITION BY producto ORDER BY inventario DESC) as row_number FROM productos;

SELECT id, producto, tienda, fecha , inventario,  RANK() OVER (ORDER BY inventario DESC) as ranking FROM productos;
SELECT id, producto, tienda, fecha , inventario,  DENSE_RANK() OVER (ORDER BY inventario DESC) as rank_denso FROM productos;
SELECT id, producto, tienda, fecha , inventario,  LAG(inventario,1,0) OVER (ORDER BY inventario DESC) as columna_lag FROM productos;

--- DELETE / UPDATE

-- DELETE / UPDATE

select * from productos
--borrar todo
DELETE FROM productos
TRUNCATE TABLE productos
--borrar con cantidad menor a 50
DELETE FROM productos WHERE cantidad < 50

select * from salarios

-- UPDATE : duplicar el salario de todos 
UPDATE salarios set salario=2*salario
--este cambio es reversible
UPDATE salarios set salario=salario/2

select * from salarios

--Update de cambiar nombre de cargo "Docente" a "Profesor"
update salarios set cargo='Profesor' where cargo='Docente'

--es reversible?
update salarios set cargo='Docente' where cargo='Profesor'

--Ej: desvincular al empleado 1011
delete from salarios where id_empleado=1011


-- TRANSACCIONES

CREATE TABLE banco (
id INTEGER,
account_number INTEGER,
balance INTEGER
)
INSERT INTO banco VALUES 
(1,123456,1000),
(2,789012,500)


BEGIN TRANSACTION;

UPDATE banco SET balance = balance - 500 WHERE account_number = 1;
UPDATE banco SET balance = balance + 500 WHERE account_number = 2;
UPDATE banco SET balance = balance - 100 WHERE account_number = 2;

COMMIT;

-- LLAVE PRIMARIA

create table monedas_2(fecha date, 
moneda_num varchar(3), 
moneda_den varchar(3), 
valor float, 
primary key (fecha, moneda_num, moneda_den))

insert into monedas_2(fecha, moneda_num, moneda_den, valor) values('2019-01-02','USD','CLP',729)
insert into monedas_2(fecha, moneda_num, moneda_den, valor) values('2019-01-02','USD','CLP',830)
insert into monedas_2(moneda_num, moneda_den, valor) values('USD','CLP',830)

select * from monedas_2
--campo autoincremental

create table monedas_3(fecha date, 
moneda_num varchar(3), 
moneda_den varchar(3), 
valor float,
contador int identity) 

insert into monedas_3(fecha, moneda_num, moneda_den, valor) values('2019-01-02','USD','CLP',830)

select * from monedas_3

--LLave Foranea (FK)
--para el caso salarios$

select * from salarios
select distinct cargo from salarios
--crear un modelo hipotetico que tenga una tabla
--que posea todos los cargos posibles
--y una nueva tabla salarios que referencia a esa tabla cargos

create table registro_cargos(cargo_reg varchar(20) primary key)
--insercion rapida
insert into registro_cargos select distinct cargo from salarios
select * from registro_cargos

create table salarios_2(
id_empleado int,
apellido varchar(25),
nombre varchar(25),
seccional varchar(25),
facultad varchar(25),
cargo varchar(20) references registro_cargos(cargo_reg),
salario float,
fch_com date,
fch_nac date)

insert into salarios_2 values(1979,'perez','juan','santiago','Ingeniería','Profesor',
324234234,'1980-05-01','1967-10-18')
insert into salarios_2 values(1979,'perez','juan','santiago','Ingeniería','Ay. Laboratorio',
324234234,'1980-05-01','1967-10-18')
--solucionarlo
insert into registro_cargos values('Profesor')
select * from salarios_2
select * from registro_cargos


--Tabla salarios
-- agrupación de salarios más altos por cargo en una facultad determinada

select * from salarios

select cargo, max(salario) as max_salario
from salarios
where facultad = 'Ingeniería'
group by cargo 

select cargo, max(salario) as max_salario
from salarios
where facultad = 'Medicina'
group by cargo 

--parametrizar
--declarar una variable 

declare @facultad varchar(20)
set @facultad = 'Ingeniería'

select cargo, max(salario) as max_salario
from salarios
where facultad = @facultad
group by cargo 

--declaracion de funciones 
--crear una funcion que entregue el salario promedio de una facultad 
-- hacer querytest: crear la query que me entrega ese resultado

select AVG(salario) from salarios where facultad='Medicina'


-- INPUT(entrada) : facultad (VARCHAR)
-- OUTPUT(salida): promedio de salarios (FLOAT)

CREATE FUNCTION retorna_promedio(@facultad varchar(20))
RETURNS FLOAT
BEGIN
	--crear (declarar) una variable de salida
	declare @resultado float
	set @resultado= (select avg(salario) from salarios where facultad=@facultad)
	--funcion escalar: por que sale 1 valor unidimensional 
	return @resultado 
END

--como llamar a la funcion
select dbo.retorna_promedio('Medicina')
select dbo.retorna_promedio('Ingeniería')
select dbo.retorna_promedio('Arquitectura')

