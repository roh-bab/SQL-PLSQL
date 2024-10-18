--Print your name 5 times
select 'rohit' from dual connect by level<5;
--print the following pattern
/*
r
ro
roh
rohi
rohit*/
select substr('rohit',1,level) from dual connect by level<length('rohit')+1;
--print the following pattern
/*
rohit
rohi
roh
ro
r*/
select substr('rohit',1,length('rohit')+1-level) from dual connect by level<length('rohit')+1;
--print the following pattern
/*
*
**
***
****
*****
*/
select lpad('*',level,'*') from dual connect by level<=5;
--print the following pattern
/*
*****
****
***
**
*
*/
select lpad('*',6-level,'*') from dual connect by level<=5;
--print the following pattern (with spaces)
/*
* * * * *
* * * *
* * *
* *
*
*/
Select pat from(
select row_number() over( order by level) rw ,rpad('* ',11-level,'* ') pat from dual connect by level<=5*2)
where mod(rw,2) =0;
--print the following pattern (with spaces)
/*
* 
* * 
* * * 
* * * * 
* * * * * 
*/
Select pat from(
select row_number() over( order by level) rw ,rpad('* ',level,'* ') pat from dual connect by level<=5*2)
where mod(rw,2) =0;