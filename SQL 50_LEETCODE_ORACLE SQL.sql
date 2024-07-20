
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
