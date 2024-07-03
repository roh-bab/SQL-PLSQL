/*
Author : Rohit Babu

wild card - Like operator / Not Like operator / escape operator

What are wild cards?
SQL wildcards are special characters used in SQL queries to match patterns in the data. 
Following are the four wildcards used in conjunction with the LIKE operator ?

1. % :The percent sign represents zero, one or multiple characters.
2. _ : The underscore represents a single number or character.
3. [] : This matches any single character within the given range in the [].
4. [^] : This matches any single character excluding the given range in the [^].

Note ? In the LIKE operator, the above wildcard characters can be used 
individually as well as in combinations with each other. 
The two mainly used wildcard characters are ‘%’ and ‘_’.
The table given below has a few examples showing the WHERE clause 
having different LIKE operators with '%' , '_' , [] and [^] pattern ?

Escape characters with LIKE operator :

The escape character in SQL is used to exclude certain wildcard characters from 
the expression of the LIKE operator. 
By doing so, we can use these characters in their general sense.
Using escape, we can also avoid using the characters that are reserved in SQL 
syntax to denote specific commands, such as the single quote “ ' ”, “%” and “_”.
For example, if you need to search for “%” as a literal in the LIKE condition, 
then it is done using Escape character.


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
    SELECT 1 FROM dual;

/* 'Mumbai' select whose character exact match with 'Mumbai' */
select * from student where firstname like 'Opera';

/* 'B%' select whose first character starting with 'B' */
select * from student where firstname like 'O%';

/* '%i' select whose last character ending with 'i' */
select * from student where city like '%i';

/* '%ba%' select who have character is ba at any position*/
select * from student where city like '%ba%';

/* 'O%a' select whose first character is 'O' and last is 'a' */
select * from student where firstname like 'O%a';

/* '_____' select whose lenght is 5 as '_____' */
select * from student where firstname like '_____';

/* '_i______' select whose lenght is 8 and second character is 'a' as '_a___' */
select * from student where firstname like '_i______';

/* 'ba_%' select whose first character starting 'De_' and at least 3 lenght*/
select * from student where city like 'De_%';

/* '__m%' select whose third character starting '__m' and at least 3 lenght*/
select * from student where city like '__m%';

/* '%el_i' select whose last character ending with '%el_i' */
select * from student where city like '%el_i';

/* '%D__%' select record which has a 'D' in it and has atleast 3 characters*/
select * from student where city like '%D__%';

/*R____!%' where '!' is escape So it will select the records starting with R ,having 5 characters and ending with % */
select * from student where firstname like 'R____!%' escape '!' ;

/* 'R%!%' where '!' is escape so it will 'R%\%' select whose first char is 'R' and last is '%'  */
select * from student where firstname like 'R%!%' escape '!';

delete from student;	/*delete all records from table*/

drop table student; /*drop table*/


