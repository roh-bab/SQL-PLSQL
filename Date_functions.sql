
/*
Author : Rohit Babu

 date and time functions
*/


create table student
	(	id number primary key, 
		firstname varchar(20) not null ,
		lastname varchar(20),
		dob date,
		marks number,
		city varchar(20) );

insert into student 
    Select 105, 'Lokesh', 'Lavya',to_date('1990-02-01','yyyy/mm/dd'),85,'Ahmedabad' from dual
    union all
    select 106, 'Peter', 'Mohato', to_date('1994-02-01','yyyy/mm/dd'),90,'Jamshedpur' from dual;	

select 	id as Student_ID, 
		dob as Birth_Date,
		current_date as Today
		from student; 

/* sysdate = current_date*/

/*Sun, Mon,.....*/
select to_char(sysdate,'day') as Day from dual;
 
/*display current time */
select to_char(sysdate,'hh24:mi:ss am') as Time from dual;
select to_char(sysdate,'hh12:mi:ss am') as Time from dual;
select to_char(sysdate,'hh24:mi am') as Time from dual;
select to_char(sysdate,'hh12:mi am') as Time from dual;

/*display current year */
select to_char(sysdate,'year') as Year from dual;
select to_char(sysdate,'yyyy') as Year from dual;
select to_char(sysdate,'yy') as Year from dual;


/*display current month */
select to_char(sysdate,'month') as Month from dual;
select to_char(sysdate,'mm') as Month from dual;

/*display current date */
select to_char(sysdate,'dd') as Dt from dual;

/* Date and Time */
select to_char(sysdate,'dd/mm/yyyy hh:mi:ss am day') as Dt from dual;
select systimestamp from dual;
/*convert string to date*/
select to_date('27042023','dd/mm/yyyy') from dual;--27-04-23
select to_date('270423','dd/mm/yy') from dual;--27-04-23
select to_date('20230427','yyyy/mm/dd') from dual;--27-04-23
select to_date('202304','yyyy/mm') from dual;--01-04-23 as no day provided

/* difference of the month between two dates*/
select months_between ('20-Aug-2010' , '25-Feb-2011') from dual;
select months_between (current_date,'20-Jan-2024') from dual;
select months_between (current_date,dob) from student;

/* display by adding number of month in date*/
select add_months ('5-Aug-2019',7) from dual;
select add_months (current_date,5) from dual;
select add_months (dob,2) from student;

/*extract year from date*/
select EXTRACT(year FROM current_date)  as Year from dual;
select EXTRACT(year FROM dob) as Year from student;

/*extract month from date*/
select EXTRACT(month FROM current_date) as Month  from dual;
select EXTRACT(month FROM dob) as Month  from student;

/*extract day from date*/
select EXTRACT(day FROM current_date) as Day  from dual;
select EXTRACT(day FROM dob)  as Day from student;

/* manually age calculate*/
select ((months_between (current_date,dob))/12) as Age from student;

delete from student;	/*delete all records from table*/

drop table student;


