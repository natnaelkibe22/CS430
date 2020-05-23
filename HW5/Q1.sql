--Natnael Kibe
--date


CREATE OR REPLACE FUNCTION thirdnearest(price2 IN Parts.price%type)
RETURN integer
IS
  pid3 integer;
BEGIN
  DECLARE
  --basic local variables
  pricecalc1 integer;
  pricecalc2 integer;
  minprice integer := 0;
  maxprice integer := 0;
  tempprice Parts.price%type;
  --looping declarations
  counter integer:= 0;
  counter1 integer;
  counter2 integer;
  pricedemo Parts.price%type;
  pricedemo1 Parts.price%type;
  CURSOR priceloop IS
  SELECT p.price
  FROM Parts p;
  CURSOR priceloop1 IS
  SELECT p.price
  FROM Parts p;
  BEGIN
    tempprice := price2;
    select count(p.price) into counter1 from parts p where p.price > price2;
    select count(p.price) into counter2 from parts p where p.price < price2;
    open priceloop;
    maxprice:= price2;
    LOOP
      -- FETCH priceloop INTO pricedemo;
      -- EXIT WHEN (priceloop%notfound OR counter = 3);
       EXIT WHEN (counter = 3);
      -- select min(p.price) from parts p where p.price > 400;
      select min(p.price) INTO maxprice from parts p where p.price > tempprice;
       --IF (maxprice != tempprice) then
       counter := counter + 1;
       --END IF;
       tempprice := maxprice;
   END LOOP;
   CLOSE priceloop;
   counter := 0;

   tempprice := price2;
   minprice:= price2;
   open priceloop1;
   LOOP
      EXIT WHEN (counter = 3);
      --select max(p.price) from parts p where p.price < 400;
      select max(p.price) INTO minprice from parts p where p.price < tempprice;
      --IF (minprice != tempprice) then
      counter := counter + 1;
      --END IF;
      tempprice := minprice;
  END LOOP;
 CLOSE priceloop1;
  IF (counter1 < 3 and counter2 >= 3) THEN
     select max(p.pid) INTO pid3 from Parts p where p.price = minprice and p.year = (SELECT
      max(p1.year) from Parts p1 where p1.price = minprice);
  ELSIF(counter2 < 3 and counter1 >= 3) THEN
       select max(p.pid) INTO pid3 from Parts p where p.price = maxprice and p.year = (SELECT
       max(p1.year) from Parts p1 where p1.price = maxprice);
  ELSIF(counter2 < 3 and counter2 < 3) then pid3:= 0;
  ELSE
    --calculating the nearness of maxprice (thirdnearest from max)
    pricecalc1 := ABS(maxprice - price2);
    --calculating the nearness of minprice (thirdnearest from min)
    pricecalc2 :=  ABS(price2 - minprice);
    --condition to check which is closer max price or min price
    --if third max is nearer than third min
    IF (pricecalc1 <= pricecalc2) THEN
    select max(p.pid) INTO pid3 from Parts p where p.price = maxprice and p.year = (SELECT
    max(p1.year) from Parts p1 where p1.price = maxprice);
    --if third min is nearer than third max
    ELSIF (pricecalc2 <= pricecalc1) THEN
  select max(p.pid) INTO pid3 from Parts p where p.price = minprice and p.year = (
    select max(p1.year) from Parts p1 where p1.price = minprice);
     END IF;
  END IF;
--  dbms_output.put_line(pid3);
  END;
  RETURN pid3;
EXCEPTION
   	WHEN TOO_MANY_ROWS THEN
   	RETURN -1;
END;
/
