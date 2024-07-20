/*SAMPLE DATA
TRX
Term_no	Trx_no	amount	Trx_date
10	1	10	2/10/2024 12:05
10	2	11	2/10/2024 12:10
10	3	12	2/12/2024 12:30
10	4	20	2/12/2024 14:22
11	1	13	2/10/2024 12:05
11	2	14	2/11/2024 12:10
11	3	15	2/12/2024 12:30
12	1	16	2/10/2024 12:05
12	2	17	2/11/2024 12:10
12	3	18	2/12/2024 12:33
12	4	20	2/12/2024 12:55
12	6	30	2/12/2024 13:12
12	7	60	2/12/2024 13:13
12	8	18	2/12/2024 13:18

Ticket
Term_no	Trx_no	amount	coupon
10	1	10	1
10	2	11	1
10	3	12	1
10	3	4	2
11	1	13	1
11	2	14	1
11	3	15	1
12	1	16	1
12	3	18	1
12	4	25	1
12	6	30	1
12	7	60	1
12	8	18	1*/
 
-- Create and insert script
create table trx (Term_no number,	Trx_no number,	amount number,	Trx_date date);
create table ticket (Term_no number,	Trx_no number,	amount number,	coupon number);

Insert into TRX (TERM_NO,TRX_NO,AMOUNT,TRX_DATE) values (10,1,10,to_date('02/10/2024','DD/MM/YYYY'));
Insert into TRX (TERM_NO,TRX_NO,AMOUNT,TRX_DATE) values (10,2,11,to_date('02/10/2024','DD/MM/YYYY'));
Insert into TRX (TERM_NO,TRX_NO,AMOUNT,TRX_DATE) values (10,3,12,to_date('02/12/2024','DD/MM/YYYY'));
Insert into TRX (TERM_NO,TRX_NO,AMOUNT,TRX_DATE) values (10,4,20,to_date('02/12/2024','DD/MM/YYYY'));
Insert into TRX (TERM_NO,TRX_NO,AMOUNT,TRX_DATE) values (11,1,13,to_date('02/10/2024','DD/MM/YYYY'));
Insert into TRX (TERM_NO,TRX_NO,AMOUNT,TRX_DATE) values (11,2,14,to_date('02/11/2024','DD/MM/YYYY'));
Insert into TRX (TERM_NO,TRX_NO,AMOUNT,TRX_DATE) values (11,3,15,to_date('02/12/2024','DD/MM/YYYY'));
Insert into TRX (TERM_NO,TRX_NO,AMOUNT,TRX_DATE) values (12,1,16,to_date('02/10/2024','DD/MM/YYYY'));
Insert into TRX (TERM_NO,TRX_NO,AMOUNT,TRX_DATE) values (12,2,17,to_date('02/11/2024','DD/MM/YYYY'));
Insert into TRX (TERM_NO,TRX_NO,AMOUNT,TRX_DATE) values (12,3,18,to_date('02/12/2024','DD/MM/YYYY'));
Insert into TRX (TERM_NO,TRX_NO,AMOUNT,TRX_DATE) values (12,4,20,to_date('02/12/2024','DD/MM/YYYY'));
Insert into TRX (TERM_NO,TRX_NO,AMOUNT,TRX_DATE) values (12,6,30,to_date('02/12/2024','DD/MM/YYYY'));
Insert into TRX (TERM_NO,TRX_NO,AMOUNT,TRX_DATE) values (12,7,60,to_date('02/12/2024','DD/MM/YYYY'));
Insert into TRX (TERM_NO,TRX_NO,AMOUNT,TRX_DATE) values (12,8,18,to_date('02/12/2024','DD/MM/YYYY'));
commit;

insert into ticket values(10,1,10,1);
insert into ticket values(10,2,11,1);
insert into ticket values(10,3,12,1);
insert into ticket values(10,3,4,2);
insert into ticket values(11,1,13,1);
insert into ticket values(11,2,14,1);
insert into ticket values(11,3,15,1);
insert into ticket values(12,1,16,1);
insert into ticket values(12,3,18,1);
insert into ticket values(12,4,25,1);
insert into ticket values(12,6,30,1);
insert into ticket values(12,7,60,1);
insert into ticket values(12,8,18,1);
commit;

/*1.	Select minim and maximum trx date per day per terminal from TRX table (see below) Format of output
Terminal number (term_no) Date (trx_date)
Minimum date Maximum date*/

SELECT
    term_no,
    TO_DATE(trx_date, 'DD/MM/YYYY'),
    MIN(trx_date),
    MAX(trx_date)
FROM
    trx
GROUP BY
    term_no,
    TO_DATE(trx_date, 'DD/MM/YYYY');

/*2.	Select minimum/maximum trx number per day per terminal Format.
Terminal number (term_no) Date (trx_date)
Minimum trx number (trx_no) Maximum trx number (trx_no)*/

SELECT
    term_no,
    TO_DATE(trx_date, 'DD/MM/YYYY'),
    MIN(trx_no),
    MAX(trx_no)
FROM
    trx
GROUP BY
    term_no,
    TO_DATE(trx_date, 'DD/MM/YYYY');




/*3.	Select all transactions from yesterday 00:00:00 till now. Report will be running every day at 7am and have to return always data from yesterday till time when it run.
Format
Date - month/day/year Terminal number Count or records*/

SELECT
    to_char(trunc(trx_date),
            'MM/DD/YYYY'),
    term_no,
    COUNT(*)
FROM
    trx t
WHERE
        trunc(t.trx_date) = trunc(sysdate - 1)
    AND trunc(t.trx_date) < trunc(sysdate)
GROUP BY
    trunc(t.trx_date),
    t.term_no; 
/*4.	Select all records from TRX table which don’t have records in TICKET table.*/

with tab1 as (Select term_no,trx_no from trx
minus
Select term_no,trx_no from ticket)
Select * from trx t,tab1 where t.term_no = tab1.term_no and t.trx_no = tab1.trx_no;

/*5.	TRX_NO should be in sequence for each terminal number. Find a missing trx_no per terminal. Format output
Term_no
prev_trx_no – last trx number before gap next_trx_no – next trx number after gap gap_count*/

	SELECT t1.term_no,t1.trx_no ,t1.trx_no + 1 AS "last",
       	MIN(t2.trx_no)  AS "next"
FROM trx t1, trx t2 where t1.trx_no < t2.trx_no
and t1.term_no = t2.term_no
GROUP BY t1.term_no,t1.trx_no
HAVING t1.trx_no + 1 < MIN(t2.trx_no);

/*6.	The transaction amount should match between TRX and TICKET table for each transaction. 
Write query which will show you records with mismatch in amounts.*/

	Select trx.term_no,trx.trx_no,trx.amount trx_amount , ticket.amount ticket_amount from trx ,ticket 
where trx.term_no = ticket.term_no and trx.trx_no = ticket.trx_no
and trx.amount <> ticket.amount; 
/*7.	Validate if transaction amount is this same between TRX and TICKET table per term/trx number.
Find records which doesn’t match.
Format
Term number Trx_no
Trx amount Ticket amount
Difference trx amount-ticket amount*/

Select trx.term_no,trx.trx_no,trx.amount trx_amount , ticket.amount ticket_amount , trx.amount-ticket.amount from trx ,ticket 
where trx.term_no = ticket.term_no and trx.trx_no = ticket.trx_no
and trx.amount <> ticket.amount;


/*8.	In TRX table we need to increase trx_no for terminal number 10 for + 150.write query which will increase trx_no for terminal 10 for
    + 150 – trx_no 1 will became 151.*/
		
	 Update trx set trx_no = trx_no + 150 where term_no = 10;
