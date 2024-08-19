

declare
type typ_lq is table of varchar(2000);  
lv_name_list typ_lq := typ_lq();
begin
select lastname
  bulk collect into lv_name_list
  from persons;

dbms_output.put_line(lv_name_list(2)); -- we can access last element first
dbms_output.put_line(lv_name_list(1));
dbms_output.put_line(lv_name_list(2));
--dbms_output.put_line(lv_name_list(3));ORA-06533: Subscript beyond count ORA-06512
--we can loop also
dbms_output.put_line('-- from for loop--');
for i in lv_name_list.first..lv_name_list.last loop
    dbms_output.put_line(lv_name_list(i));
end loop;
end;

