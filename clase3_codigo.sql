
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
