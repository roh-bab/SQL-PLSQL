
/*

Author : Rohit Babu

Data Definition Language (DDL)
DDL commands: create, alter and drop 

Tables: student, student_result, student, emp_dept and emp_sal

Create or delete table, add primary key, 
add or modify or delete attributes of table,

Data Manipulation Language (DML)
DML commands: insert, select, delete and update.

Insert values into student table with field names using insert
command,
Display the table student using select command,
Update student address in student table using update command,
Delete a row from student table.
*/


/*create table*/
create table student
	(	id int primary key, 
		firstname varchar(20) not null,
		lastname varchar(20),
		dob date,
		city varchar(20),
        marks number);


/*insert multiple records.*/
  INSERT ALL
     INTO student (id, firstname, lastname,dob,city,marks) VALUES (107, 'Opera', 'Lavya',to_date('1990-02-01','yyyy/mm/dd'),'Mumbai',85)
     INTO student (id, firstname, lastname,dob,city,marks) VALUES (108, 'Minakshi', 'Mohato', to_date('1994-02-01','yyyy/mm/dd'),'Delhi',85)
     INTO student (id, firstname, lastname,dob,city,marks) VALUES (110, 'Ridhi%', 'Sharma', to_date('1994-12-09','yyyy/mm/dd'),'Delhi',85)
     INTO student (id, firstname, lastname,dob,city,marks) VALUES (111, 'Ridhi', 'Sharma', to_date('1994-12-09','yyyy/mm/dd'),'',85)
     INTO student (id, firstname, lastname,dob,city,marks) VALUES (112, 'Ridhi', 'Sharma', to_date('1994-12-09','yyyy/mm/dd'),null,85)
    SELECT 1 FROM dual;

/* Show all value in table */
select * from student;	

/* distinct to view without duplication */
select distinct city from student; 

/* Update value */
update student 
	set firstname = 'Neha', lastname = 'Dixit'
	where id = 107; 

/* count records */
select 	count(*) as Total_Record,	/*count all records*/
		count(distinct city) as Total_City/*count all filled city records ignoring duplicate*/
	from student; 


/* Maximum from mark or char*/
select max(marks) from student; 
select max(city) from student;
select id, firstname from student where city = (Select max(city) from student);

/* Minimum from mark or char */
select  min(marks) from student; 
select min(city) from student;
select id, firstname from student where city = (Select min(city) from student);

 /* Sum all mark value */
select sum(marks) as Sum from student;

/* Average of mark all value */
select avg(marks) as Average from student; 

/* display null or not */
select * from student 
	where (lastname is NULL) or (marks is NULL)
		or (city is null); 

/* or with where */
select * from student 
	where ((marks <=85) or (marks > 90)); 

/*not between with where */
select * from student 
	where marks not between 55 and 80; 

/*and with where*/
select id, firstname, city from student 
	where (id >= 102) and (city != 'Mumbai');

/*and Not with where*/
select id, firstname,city from student 
	where (id >= 105) and not (city = 'Delhi'); 


/* order by column ascending or decending*/
select * from student 
	order by firstname asc; /* order by column */
select * from student 
	order by id; /*default ascending*/
select * from student 
	order by marks desc; /*order by column accending (asc) decending (dsc)*/
select * from student 
	order by 5 asc ; /* select column number 5 to sort (which is city)*/ 


/* limit record to view*/
select * from student fetch first 3 rows only; /*display the first 3 records*/
select * from student 
	order by marks desc fetch first 4 rows only; /*display the first 4 records*/

/* to dispaly data with specific column name and concatination*/
select 	id as Student_ID, 
		(firstname || ' ' || lastname) as Name, /* concate(firstname ||' '||lastname)*/
		dob as Birth_Date,
		city as Location,
		current_date as Today
		from student;

--to_char for convert into string
select id, firstname, to_char(marks) from student; 
select to_char(avg(marks),'99999.99')from student;


/* to get sub string from string*/
select substr('oracle',2,4) from dual; 
select substr(firstname,2,4) from student; 

/* replace character */
select translate ('Student','nt','AB') from dual;
select translate (firstname,'a','Q') from student;

/*initcap to captital every first character */
select initcap('i like to pl sql') from dual; 
select initcap(firstname) from student;

/*all upper capital*/
select upper ('I like sql') from dual; 
select upper (firstname) from student;

/*all lower capital*/ 
select lower ('I Like Sql') from dual;	
select lower (firstname) from student;

/*total length of character and space filled by '*' in left */
select lpad ('CODL',8,'*') from dual;
select lpad (firstname,10,'*') from student;

/*total length of character and space filled by '*' in right */
select rpad ('CODL',8,'*') from dual;
select rpad (firstname,10,'*') from student;

/*remove space from left side*/
select ltrim ('          abc') from dual;
select ltrim (firstname) from student;

/*remove space from right side*/
select rtrim ('abc          ') from dual;
select rtrim (firstname) from student;

/* delete recored from table */
delete from student where city = "Ahmedabad";	/*delete specific record from table*/
delete from student;	/*delete all records from table*/

/*drop table*/
drop table student;


