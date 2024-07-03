/*

Author : Rohit Babu

Identity key:
When a table column is defined with an identity 
property, its value will be auto-generated incremental 
value. This value is created by the Oracle automatically. 
Therefore, we can't manually enter a value into an identity 
column as a user. Hence, if we mark a column as identity, 
SQL Server will populate it in an auto-increment manner.

syntax:   GENERATED ALWAYS AS IDENTITY 


*/

create table student
	(	
		id int GENERATED ALWAYS AS IDENTITY primary key, 
		firstname varchar(20) not null,
		lastname varchar(20),
		dob date,
		result int,
		city varchar(20),
		gender varchar(8) 
	);


/*insert multiple records.*/
insert into student(firstname,lastname,dob,result,city,gender) values('Rahul','Shah','01-dec-1990',85,'Ahmedabad','M');
insert into student(firstname,lastname,dob,result,city,gender) values('Riya','Shah','09-may-1995',70, 'Ahmedabad','F');
insert into student(firstname,lastname,dob,result,city,gender) values('Rekha','Kapoor',NULL,40,'Ahmedabad','F');
insert into student(firstname,lastname,dob,result,city,gender) values('Amit','Verma','03-oct-1992',90,'Delhi','M');
insert into student(firstname,lastname,dob,result,city,gender) values('Khushi','Patel','15-apr-1993',NULL,'Bangalore','F');
insert into student(firstname,lastname,dob,result,city,gender) values('Hitesh','Sharma','04-aug-1980',56, NULL,'M');
insert into student(firstname,lastname,dob,result,city,gender) values('Mital','Kumawat','22-jul-1970',95, 'Mumbai','F');
insert into student(firstname,lastname,dob,result,city,gender) values('Jay',NULL,'16-feb-1975',60,'Mumbai','M');
insert into student(firstname,lastname,dob,result,city,gender) values('Tanvi','Dave','18-sep-1977',70, 'Chennai','F');
insert into student(firstname,lastname,dob,result,city,gender) values('xyz',NULL,'12-jun-1994',NULL,'Mumbai',NULL);

select * from student;

drop table student;