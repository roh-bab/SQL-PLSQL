SET SERVEROUTPUT ON;
DECLARE
  v_CaseOrDecode number := &1_for_Case_Or_2_for_Decode; -- Prompts the user for Case or Decode

  num1 number := 1;
  num2 number := 2;
  num3 number := 3;
  v_result number;

  v_decode_one number := 1;
  v_decode_result varchar(20);

BEGIN
if(v_CaseOrDecode != 1 and v_CaseOrDecode != 2) then
DBMS_OUTPUT.PUT_LINE('Please enter Case or Decode');
end if;
  if (Initcap(v_CaseOrDecode) = 1) then
    /* if num1 is equal to 1 then num1 , if num2 =1 then num2 else num3 */
    Begin
    v_result := CASE
      WHEN num1 = 1 THEN num1
      WHEN num2 = 1 THEN num2
      ELSE num3
    END;--case end
    DBMS_OUTPUT.PUT_LINE('Output from Case->RESULT: ' || v_result);
    End;
  elsif (Initcap(v_CaseOrDecode) = 2) then
  Begin
  /*if v_decode_one =1 then 'one' ,v_decode_one =2 then 'two' ,else other*/
    Select decode(v_decode_one,1,'one',2,'two','other') into v_decode_result from dual;
    DBMS_OUTPUT.PUT_LINE('Output from Decode->RESULT: '||v_decode_result);
    END;
  END IF;

END;