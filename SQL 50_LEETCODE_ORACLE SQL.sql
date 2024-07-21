
--1757. Recyclable and Low Fat Products

Select p.product_id from Products p where p.low_fats = 'Y' and p.recyclable = 'Y';

--584 Find Customer Referee

Select name from Customer C where C.referee_id <> 2 or C.referee_id is null;

--595 Big Countries

Select name,population,area from World W where W.area >= 3000000 or W.population >= 25000000;

--1148. Article Views I

Select distinct author_id as id from Views V where V.author_id = V.viewer_id order by id asc;

--1683. Invalid Tweets

Select T.tweet_id from Tweets T where length(T.content) > 15;

--1378. Replace Employee ID With The Unique Identifier

Select Eu.unique_id,E.name from Employees E left join EmployeeUni Eu on E.id = Eu.id;

--1068 Product Sales Analysis 1

Select product_name, year, price from Sales S, Product P where S.product_id = P.product_id;

--1581. Customer Who Visited but Did Not Make Any Transactions

Select V.customer_id,count(1) as count_no_trans from Visits V left join Transactions T on V.visit_id = T.visit_id
 where T.transaction_id is null group by V.customer_id;
 
--197. Rising Temperature

Select id from Weather W where W.temperature > (Select W1.temperature from Weather W1 where W.recordDate = (W1.recordDate+ 1));

--1661. Average Time of Process per Machine

with newtable as (Select machine_id,process_id ,(select sum(timestamp) from activity A2 where a1.machine_id = a2.machine_id and a1.process_id =a2.process_id
and a2.activity_type = 'start' and a1.activity_type=a2.activity_type) start_time
,(select sum(timestamp) from activity A2 where a1.machine_id = a2.machine_id and a1.process_id =a2.process_id
and a2.activity_type = 'end' and a1.activity_type=a2.activity_type) end_time
from activity A1 order by machine_id,process_id,start_time),
onlyStart as (select start_time,process_id,machine_id from newtable where start_time is not null),
onlyEnd as (select end_time,process_id,machine_id from newtable where end_time is not null)

Select onlyStart.machine_id,round(avg(onlyEnd.end_time-onlyStart.start_time),3) processing_time from onlyStart,onlyEnd where onlyStart.machine_id=onlyEnd.machine_id
group by onlyStart.machine_id;

--EXPLAINATION GIVEN IN ATTACHED DOC SQL 50 EXPLAINATION.docs--

--577 EMPLOYEE BONUS

Select name,bonus from (Select E.name,b.bonus from Employee E left join Bonus B on E.empId=B.empId) where bonus <1000 or bonus is null;

1280. Students and Examinations

Select st.student_id student_id,st.student_name student_name ,sub.subject_name subject_name ,count(ex.subject_name) attended_exams  from Students St cross join Subjects Sub left join examinations ex 
on ex.student_id = st.student_id
and sub.subject_name = ex.subject_name
 group by st.student_id,st.student_name,sub.subject_name   order by st.student_id ,sub.subject_name;

570. Managers with at Least 5 Direct Reports

Select name from employee where id in (Select e.id from Employee e ,Employee e1 where e1.managerId = e.Id
group by e.id having count(1)>4);

1934. Confirmation Rate

Select S.user_id,round((Select count(1)from Confirmations C where C.user_id = S.user_id and C.action = 'confirmed')/count(1),2) confirmation_rate from Signups S left join Confirmations C on S.user_id = C.user_id
group by S.user_id;

620. Not Boring Movies

Select * from Cinema C where C.description <> 'boring' and mod(C.id,2) <> 0 order by rating desc;

1075. Project Employees I

SELECT p.project_id, ROUND(AVG(e.experience_years),2) AS average_years FROM Project p LEFT JOIN Employee e ON p.employee_id = e.employee_id GROUP BY p.project_id;

1251. Average Selling Price

Select P.product_id , nvl(round(sum((P.price*U.units))/sum(U.units),2),0)average_price from Prices P left join UnitsSold U on P.product_id = U.product_id
and U.purchase_date between P.start_date and P.end_date
group by P.product_id;

1211. Query Quality and Percentage

Select Q2.query_name,round(avg(Q2.rating/Q2.position),2) quality,round((Select count(Q1.rating)*100 from Queries Q1 where Q1.query_name =Q2.query_name and Q1.rating < 3)/count(1),2) poor_query_percentage  from Queries Q2 where Q2.query_name is not null group by Q2.Query_name order by quality;

1193. Monthly Transactions I

Select to_CHAR(trans_date,'YYYY-MM') month,country,count(amount) trans_count,sum(case when state = 'approved' then 1 else 0 end) approved_count,sum(amount) trans_total_amount,sum(case when state = 'approved' then amount else 0 end) approved_total_amount FROM TRANSACTIONS group by to_CHAR(trans_date,'YYYY-MM'),country;

550. Game Play Analysis IV

select round(((Select count(1) from Activity A1 , Activity A2 where A1.player_id = A2.player_id 
and A1.event_date + 1 = A2.event_date and A1.event_date = (Select min(A3.event_date) from Activity A3 where A3.player_id = A1.player_id))/(Select count(distinct player_id) from Activity A)),2) fraction from dual;

1174. Immediate Food Delivery II

Select round((Select count(1)*100 from Delivery D where D.order_date = (Select min(order_date) from Delivery D1 where D.customer_id = D1.customer_id)
and D.order_date = D.customer_pref_delivery_date)/(Select count(distinct customer_id) from Delivery D2),2) immediate_percentage from dual;

2356. Number of Unique Subjects Taught by Each Teacher

select distinct teacher_id,(Select count(distinct subject_id) from teacher T2 where T1.teacher_id = T2.teacher_id) cnt from Teacher T1;

1141. User Activity for the Past 30 days I

Select to_char(A1.activity_date,'YYYY-MM-DD') day,(Select count(distinct A2.user_id) from Activity A2 where A1.activity_date = A2.activity_date) active_users from Activity A1 where A1.activity_date <= to_date('2019-07-27','YYYY-MM-DD') AND A1.activity_date > to_date('2019-07-27','YYYY-MM-DD') - 30  group by activity_date;

1070. Product Sales Analysis III

Select S.product_id,S.year first_year,S.quantity,S.price from Sales S , Product P where S.product_id = P.product_id and S.year = (Select min(year) from Sales S1 where S1.product_id = S.product_id);

596. Classes More Than 5 Students

Select class from Courses group by class having count(1) >= 5;

1729. Find Followers Count

Select F.user_id,count(F.follower_id) followers_count from Followers F group by F.user_id order by F.user_id asc;

Select max(num) num from (Select num from MyNumbers group by num having count(1)<2);

1731. The Number of Employees Which Report to Each Employee

Select E1.employee_id,E1.name,(Select count(E3.employee_id)from Employees E3 where E3.reports_to = E1.employee_id ) reports_count,(Select round(avg(E3.age)) from Employees E3 where E3.reports_to = E1.employee_id ) average_age from Employees E1 , Employees E2 where E1.employee_id = E2.reports_to group by E1.employee_id,E1.name order by E1.employee_id;

1789. Primary Department for Each Employee

Select employee_id,department_id from (Select employee_id,department_id,primary_flag,(case when(Select count(1) from Employee E1 where E1.employee_id = E.employee_id)=1 then 'Y' else 'N' end) flag  from Employee E) where  primary_flag = 'Y' or flag = 'Y';


610. Triangle Judgement

Select T.*, (case when (x+y>z and y+z>x and z+x>y) then 'Yes' else 'No' end) triangle from Triangle T;

180. Consecutive Numbers
Select distinct num ConsecutiveNums from (SELECT 
        LAG(id) OVER (ORDER BY id) AS prev_id,
        id,
        LEAD(id) OVER (ORDER BY id) AS next_id,
        LAG(num) OVER (ORDER BY id) AS prev_num,
        num,
        LEAD(num) OVER (ORDER BY id) AS next_num
    FROM logs)
    where id = prev_id +1
    and id = next_id -1
    and num = prev_num
    and num = next_num;

1204. Last Person to Fit in the Bus

Select person_name from (Select person_name , sum(weight)  over(order by turn) Sum_weight from Queue order by sum_weight desc ) where sum_weight <= 1000 and rownum = 1;

1907. Count Salary Categories

with big_table as (Select account_id,(case when income < 20000 then 'Low Salary' 
when income >= 20000 and income <= 50000 then 'Average Salary'
else 'High Salary' end) sal_cat from Accounts),
cat_table as (SELECT 'High Salary' sal_cat from dual 
Union all
SELECT 'Low Salary' sal_cat from dual 
Union all
SELECT 'Average Salary' sal_cat from dual ) 

Select cat_table.sal_cat category,nvl(count(account_id),0) accounts_count from cat_table left join big_table
on big_table.sal_cat=cat_table.sal_cat group by cat_table.sal_cat;

1978. Employees Whose Manager Left the Company

Select E.employee_id from Employees E where E.manager_id is not null and E.manager_id not in (Select E1.employee_id from Employees E1 where E1.employee_id = E.manager_id) and E.salary < 30000 order by employee_id;

626. Exchange Seats

with oddtab as (Select nvl(decode(mod(B.id,2),1,A.id-1,0,A.id+1),A.id)
 id,A.student from Seat A left join Seat B on A.id+1 = B.id 
 where mod((Select count(1) from Seat S2 ),2)<> 0 order by id),
 eventab as (Select decode(mod(A.id,2),1,A.id+1,0,A.id-1)
 id,A.student from Seat A where mod((Select count(1) from Seat S2 ),2)= 0 order by id)

 Select * from oddtab
 union all
 Select * from eventab;
 
 1341. Movie Rating

Select name results from (Select U.name ,count(U.name) from Users U,MovieRating M where U.user_id = M.user_id
group by U.name  order by count(U.name) desc, U.name asc) where rownum =1
union all
Select title results from (Select M.title,avg(Mr.rating) from Movies M , Movierating MR where M.movie_id = Mr.movie_id and Mr.created_at >= to_date('01/02/2020','DD/MM/YYYY') and Mr.created_at <= to_date('29/02/2020','DD/MM/YYYY') group by M.title order by avg(Mr.rating) desc,M.title asc) where rownum = 1;

1321. Restaurant Growth

WITH week_table AS (   
    SELECT 
        DISTINCT a.visited_on AS start_date,
        b.visited_on AS end_date
    FROM customer a
    JOIN customer b ON b.visited_on - a.visited_on = 6;
)

SELECT 
    to_char(w.start_date + 6, 'YYYY-MM-DD') AS visited_on,
    SUM(c.amount) AS amount,
    ROUND(SUM(c.amount)/7 ,2) AS average_amount
FROM week_table w, customer c
WHERE c.visited_on BETWEEN w.start_date AND w.end_date
GROUP BY w.start_date
ORDER BY visited_on;

1667. Fix Names in a Table

Select user_id,Upper(substr(name,1,1))||lower(substr(name,2)) name from Users order by user_id;

1527. Patients With a Condition

Select patient_id,patient_name,conditions from Patients where conditions like 'DIAB1%' or conditions like '% DIAB1%';

196. Delete Duplicate Emails

delete from person P where P.id  not in (Select min(P1.id) from person P1 where P1.email= P.email);

176. Second Highest Salary

with ranktab as (select id,
    salary, dense_rank() OVER (ORDER BY salary desc) rn
  from Employee)

  Select case when (Select count(1) from Employee E) > 1 then (Select ranktab.salary  from ranktab where rn = 2 and rownum =1)
  else (Select null from dual) end SecondHighestSalary from dual ;
  
1484. Group Sold Products By The Date

Select to_char(sell_date,'YYYY-MM-DD') sell_date,count(distinct product) num_sold,LISTAGG(product,',') WITHIN GROUP (ORDER BY product) products from (Select distinct sell_date, product from Activities A ) group by sell_date;
