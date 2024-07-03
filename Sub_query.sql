
/*

Author : Rohit Babu
sub-query

*/

/*create table*/
create table student
	(	id int primary key, 
		firstname varchar(20) not null,
		lastname varchar(20),
		dob date,
		result int,
		city varchar(20),
		gender varchar(8));

create table student_backup
	(	id int primary key, 
		firstname varchar(20) not null,
		lastname varchar(20),
		dob date,
		result int,
		city varchar(20),
		gender varchar(8),
		check (result>=0 or result <=100) );
        
/*Another way to create backup table*/
Create table student_backup_04_07 as Select * from student where 1=2;

/*insert multiple records.*/
insert into student(id,firstname,lastname,dob,result,city,gender) values(101,'Rahul','Shah',to_date('1990-12-01','yyyy-mm-dd'),85,'Ahmedabad','M');
insert into student(id,firstname,lastname,dob,result,city,gender) values(102,'Riya','Shah',to_date(''1995-05-09','yyyy-mm-dd'),70, 'Ahmedabad','F');
insert into student(id,firstname,lastname,dob,result,city,gender) values(103,'Rekha','Kapoor',NULL,40,'Ahmedabad','F');
insert into student(id,firstname,lastname,dob,result,city,gender) values(104,'Amit','Verma',to_date(''1992-09-03','yyyy-mm-dd'),90,'Delhi','M');
insert into student(id,firstname,lastname,dob,result,city,gender) values(105,'Khushi','Patel',to_date('1993-04-15','yyyy-mm-dd'),NULL,'Bangalore','F');
insert into student(id,firstname,lastname,dob,result,city,gender) values(106,'Hitesh','Sharma',to_date('1980-08-04','yyyy-mm-dd'),56, NULL,'M');
insert into student(id,firstname,lastname,dob,result,city,gender) values(107,'Mital','Kumawat',to_date('1970-07-22','yyyy-mm-dd'),95, 'Mumbai','F');
insert into student(id,firstname,lastname,dob,result,city,gender) values(108,'Jay',NULL,to_date('1975-02-16','yyyy-mm-dd'),60,'Mumbai','M');
insert into student(id,firstname,lastname,dob,result,city,gender) values(109,'Tanvi','Dave',to_date('1977-05-18','yyyy-mm-dd'),70, 'Chennai','F');
insert into student(id,firstname,lastname,dob,result,city,gender) values(110,'xyz',NULL,to_date('1994-06-12','yyyy-mm-dd'),NULL,'Mumbai',NULL);



/* sub-query with where */
select id, firstname, result, city from student
	where result = (select max(result) from student);

 select id, firstname, result, city from student
    where result in (select result from student where result >= 85)
    	order by result desc;


/* sub-query with insert */
insert into student_backup
  select * from  student 
   	where id in (select id from student where id < 105);

/*sub-query with update*/
update student set result = result + 2 
	where result in (select result from student where result < 70);

/*sub-query with delete*/
delete from student_backup
   where id in (select id from student_backup 
   		where city = 'Ahmedabad' and id > 102 );


/* sub-query with from */
select result from
	(select result,id from student 
	where result >= 70) Temp_Table;

select result, count(id) as "No of Student"from
	(select result,id from student 
	where result >= 70) Temp_Table 
	group by result;

 /* sub-query with select */
select id, firstname,
	(select sum(id + result) from student) 
		as I_R from student;

delete from student;	/*delete all records from table*/

drop table student; /*drop table*/


