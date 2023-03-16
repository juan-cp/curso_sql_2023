CREATE TABLE my_table (
  id INT NOT NULL,
  name VARCHAR(50) NOT NULL,
  age INT NOT NULL,
  revenue INT NOT NULL,
  PRIMARY KEY (id)
);

DROP table my_table
INSERT INTO my_table (id, name, age, revenue)
VALUES
  (FLOOR(RAND() * (20000000 - 10000000 + 1)) + 10000000
   , CHAR(FLOOR(RAND() * 26) + 65) + CHAR(FLOOR(RAND() * 26) + 65)
   , FLOOR(RAND() * (80 - 10 + 1)) + 10
   , FLOOR(RAND() * (2000000 - 200000 + 1)) + 200000),
   
     (FLOOR(RAND() * (20000000 - 10000000 + 1)) + 10000000
   , CHAR(FLOOR(RAND() * 26) + 65) + CHAR(FLOOR(RAND() * 26) + 65)
   , FLOOR(RAND() * (80 - 10 + 1)) + 10
   , FLOOR(RAND() * (2000000 - 200000 + 1)) + 200000),
   
     (FLOOR(RAND() * (20000000 - 10000000 + 1)) + 10000000
   , CHAR(FLOOR(RAND() * 26) + 65) + CHAR(FLOOR(RAND() * 26) + 65)
   , FLOOR(RAND() * (80 - 10 + 1)) + 10
   , FLOOR(RAND() * (2000000 - 200000 + 1)) + 200000),
   
     (FLOOR(RAND() * (20000000 - 10000000 + 1)) + 10000000
   , CHAR(FLOOR(RAND() * 26) + 65) + CHAR(FLOOR(RAND() * 26) + 65)
   , FLOOR(RAND() * (80 - 10 + 1)) + 10
   , FLOOR(RAND() * (2000000 - 200000 + 1)) + 200000),
   
     (FLOOR(RAND() * (20000000 - 10000000 + 1)) + 10000000
   , CHAR(FLOOR(RAND() * 26) + 65) + CHAR(FLOOR(RAND() * 26) + 65)
   , FLOOR(RAND() * (80 - 10 + 1)) + 10
   , FLOOR(RAND() * (2000000 - 200000 + 1)) + 200000),
   
     (FLOOR(RAND() * (20000000 - 10000000 + 1)) + 10000000
   , CHAR(FLOOR(RAND() * 26) + 65) + CHAR(FLOOR(RAND() * 26) + 65)
   , FLOOR(RAND() * (80 - 10 + 1)) + 10
   , FLOOR(RAND() * (2000000 - 200000 + 1)) + 200000),
   
     (FLOOR(RAND() * (20000000 - 10000000 + 1)) + 10000000
   , CHAR(FLOOR(RAND() * 26) + 65) + CHAR(FLOOR(RAND() * 26) + 65)
   , FLOOR(RAND() * (80 - 10 + 1)) + 10
   , FLOOR(RAND() * (2000000 - 200000 + 1)) + 200000),
   
     (FLOOR(RAND() * (20000000 - 10000000 + 1)) + 10000000
   , CHAR(FLOOR(RAND() * 26) + 65) + CHAR(FLOOR(RAND() * 26) + 65)
   , FLOOR(RAND() * (80 - 10 + 1)) + 10
   , FLOOR(RAND() * (2000000 - 200000 + 1)) + 200000),
   
     (FLOOR(RAND() * (20000000 - 10000000 + 1)) + 10000000
   , CHAR(FLOOR(RAND() * 26) + 65) + CHAR(FLOOR(RAND() * 26) + 65)
   , FLOOR(RAND() * (80 - 10 + 1)) + 10
   , FLOOR(RAND() * (2000000 - 200000 + 1)) + 200000),
   
     (FLOOR(RAND() * (20000000 - 10000000 + 1)) + 10000000
   , CHAR(FLOOR(RAND() * 26) + 65) + CHAR(FLOOR(RAND() * 26) + 65)
   , FLOOR(RAND() * (80 - 10 + 1)) + 10
   , FLOOR(RAND() * (2000000 - 200000 + 1)) + 200000)
   
   ;

select * from my_table 
