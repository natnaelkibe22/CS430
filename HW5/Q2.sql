CREATE OR REPLACE PROCEDURE porder(pid1 IN Orders.pid%type,
	sid1 IN Orders.sid%type, quantity1 IN Orders.quantity%type)
IS
  averageamount Parts.price%type;
BEGIN
DECLARE

  averageamount2 Parts.price%type;
  tempprice Parts.price%type;
  --copying the whole parts
  pname2 Parts.pname%type;
  year2 Parts.year%type;
  --copying the whole suppliers
  sname2 Suppliers.sname%type;
  state2 Suppliers.state%type;
  zipcode2 Suppliers.zipcode%type;
  computedprice Parts.price%type;
  computedpid integer;
  computedifference Parts.price%type;
  newordersamount Parts.price%type;
  quantityamount Orders.quantity%type;
  rowcounter integer;
  id2 Parts.pid%type;
  CURSOR id IS
		SELECT p.pid
		FROM Parts p order by p.pid desc;
  CURSOR partscopy IS
    select p.pname, p.year from Parts p where p.pid = pid1;
  CURSOR supplierscopy IS
      select s.sname, s.state, s.zipcode from Suppliers s where s.sid = sid1;
  --average calcultor
  CURSOR averagecalc IS
      select o.quantity from orders o where o.pid = pid1;
  quantitycalc Orders.quantity%type:= 0;
  counter integer:= 0;
  sumaverage integer:= 0;
  counter1 integer:= 0;
  nullor boolean:= true;
  BEGIN
  --calculating the average amount previous order from all supplliers
    select count(o.quantity) into counter1 from orders o where o.pid = pid1;
    --if we have a previous order then start the program
    IF (counter1 >= 1) then
    select avg(o.quantity) into quantityamount from orders o where o.pid = pid1;
     select p.price into tempprice from Parts p where pid1 = p.pid;
     averageamount := quantityamount * tempprice;
     averageamount2 := averageamount * 0.75;
     newordersamount:= quantity1 * tempprice;

     --checking if the prospective order is greater or lower than 75% of the average order amount
     --if yes insert it into the table

     IF (newordersamount <= averageamount2) THEN
     INSERT INTO Orders (pid, sid, quantity)
      VALUES (pid1, sid1, quantity1);
      --this part tries to compute the price that would make prospective order value be exactly at the
       --75% limit above, and then insert a NEW part with that price,
    ELSE
       computedifference:= newordersamount - averageamount2;
       computedprice:= (newordersamount - computedifference) / quantity1;
       --no loop needed
       open id;
      FETCH id INTO id2;
      close id;
      computedpid:= id2 + 1;
      open partscopy;
      FETCH partscopy INTO pname2, year2;
      close partscopy;
    --  open supplierscopy;
    -- FETCH supplierscopy INTO sname2, state2, zipcode2;
  --    close supplierscopy;
      --insert the computed pid and parts into the parts table
    INSERT INTO Parts (pid, pname, year, price)
       VALUES (computedpid, pname2, year2, computedprice);
    --insert the new order now
    INSERT INTO Orders (pid, sid, quantity)
     VALUES (computedpid, sid1, quantity1);
     END IF;
  END IF;
  END;
END;
/
