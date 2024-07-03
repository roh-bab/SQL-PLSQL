
/*

Author : Rohit Babu

Data Definition Language (DDL)
DDL commands: create, alter and drop 

Tables: student, student_marksheet, student, emp_dept and emp_sal

Create or delete database and table, add primary key, 
add or modify or delete attributes of table,

Datatype:
number,
char(n),varchar(n),varchar(2),
date,timestamp,
number(x,y)

*/


/*create table*/
create table student
	(	id number, 
		firstname varchar(20) not null,
		lastname varchar(20),
		dob date, 
		sex char(1), 
		marks number );

/*alter table to add primary key and colunm, modify attribute name and types,*/
alter table student add primary key(firstname,dob); /*define primary key */
alter table student add city number;	/*add column*/
alter table student modify city varchar(20);	/*modify attribute type*/
alter table student rename column sex to gender;
alter table student drop column gender;	/*drop column*/

desc student;	/* describe properties of table (in MySql)*/

/*insert records.*/

	insert into student values(101,'Rahul','Shah',to_date('1990-12-01','yyyy/mm/dd'),85,'Ahmedabad');
	insert into student values(102,'Amit','Verma',to_date('1992-09-03','yyyy/mm/dd'),90,'Delhi');
	insert into student values(103,'Hitesh','Sharma',to_date('1991-08-04','yyyy/mm/dd'),56, 'Mumbai');
	insert into student values(104,'Abc',NULL,to_date('1995-05-09','yyyy/mm/dd'),60, NULL);	
    
   -- inserting multiple records using Union all
    insert into student 
    Select 105, 'Lokesh', 'Lavya',to_date('1990-02-01','yyyy/mm/dd'),85,'Ahmedabad' from dual
    union all
    select 106, 'Peter', 'Mohato', to_date('1994-02-01','yyyy/mm/dd'),90,'Jamshedpur' from dual;
    
    --inserting multiple records using insert all
    INSERT ALL
    INTO student (id, firstname, lastname,dob,marks) VALUES (107, 'Opera', 'Lavya',to_date('1990-02-01','yyyy/mm/dd'),85)
    INTO student (id, firstname, lastname,dob,marks) VALUES (108, 'Minakshi', 'Mohato', to_date('1994-02-01','yyyy/mm/dd'),85)
    SELECT 1 FROM dual;
--insert selected attributes
insert into student(id,firstname,dob,city) 
		values(999,'xyz',to_date('1990-02-01','yyyy/mm/dd'),'Ahmedabad'); 

/* Show all value in table */
select * from student;	

/*create index and drop index of table*/
create index index_student_id_name on student(id,firstname);
drop index index_student_id_name;

/*create unique index and drop index of table*/
create unique index index_student_id_city on student(id,city); 
drop index index_student_id_city;

/* delete recored from table */
delete from student where firstname = 'Abc';	/*delete specific record from table*/
delete from student;	/*delete all records from table*/

/*drop table*/
drop table student;


