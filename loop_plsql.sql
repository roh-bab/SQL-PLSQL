/*
Author : Rohit Babu
loop : when , While, for
*/
SET SERVEROUTPUT ON;
DECLARE
	I NUMBER;

BEGIN

/* simple loop */
	I := 0;
	loop
		I := I + 1;
		DBMS_OUTPUT.PUT_LINE('Simple: '||I);
		exit when I >= 10;
	end loop;


/* while loop*/
	I := 0;
	while(I<10)
	loop
		I := I + 1;
		DBMS_OUTPUT.PUT_LINE('while: '||(I+10));
	end loop;

/*for loop*/
	I := 0;
	for I in 1..10
	loop
		DBMS_OUTPUT.PUT_LINE('for: '||(I+100));
	end loop;

END;
/
