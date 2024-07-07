CREATE TABLE users (
    USER_ID INT PRIMARY KEY,
    USER_NAME VARCHAR(20) NOT NULL,
    USER_STATUS VARCHAR(20) NOT NULL
);

CREATE TABLE logins (
    USER_ID INT,
    LOGIN_TIMESTAMP DATETIME NOT NULL,
    SESSION_ID INT PRIMARY KEY,
    SESSION_SCORE INT,
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID)
);

-- Users Table
INSERT INTO USERS VALUES (1, 'Alice', 'Active');
INSERT INTO USERS VALUES (2, 'Bob', 'Inactive');
INSERT INTO USERS VALUES (3, 'Charlie', 'Active');
INSERT INTO USERS  VALUES (4, 'David', 'Active');
INSERT INTO USERS  VALUES (5, 'Eve', 'Inactive');
INSERT INTO USERS  VALUES (6, 'Frank', 'Active');
INSERT INTO USERS  VALUES (7, 'Grace', 'Inactive');
INSERT INTO USERS  VALUES (8, 'Heidi', 'Active');
INSERT INTO USERS VALUES (9, 'Ivan', 'Inactive');
INSERT INTO USERS VALUES (10, 'Judy', 'Active');

-- Logins Table 

INSERT INTO LOGINS  VALUES (1, '2023-07-15 09:30:00', 1001, 85);
INSERT INTO LOGINS VALUES (2, '2023-07-22 10:00:00', 1002, 90);
INSERT INTO LOGINS VALUES (3, '2023-08-10 11:15:00', 1003, 75);
INSERT INTO LOGINS VALUES (4, '2023-08-20 14:00:00', 1004, 88);
INSERT INTO LOGINS  VALUES (5, '2023-09-05 16:45:00', 1005, 82);

INSERT INTO LOGINS  VALUES (6, '2023-10-12 08:30:00', 1006, 77);
INSERT INTO LOGINS  VALUES (7, '2023-11-18 09:00:00', 1007, 81);
INSERT INTO LOGINS VALUES (8, '2023-12-01 10:30:00', 1008, 84);
INSERT INTO LOGINS  VALUES (9, '2023-12-15 13:15:00', 1009, 79);


-- 2024 Q1
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (1, '2024-01-10 07:45:00', 1011, 86);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (2, '2024-01-25 09:30:00', 1012, 89);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (3, '2024-02-05 11:00:00', 1013, 78);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (4, '2024-03-01 14:30:00', 1014, 91);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (5, '2024-03-15 16:00:00', 1015, 83);

INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (6, '2024-04-12 08:00:00', 1016, 80);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (7, '2024-05-18 09:15:00', 1017, 82);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (8, '2024-05-28 10:45:00', 1018, 87);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (9, '2024-06-15 13:30:00', 1019, 76);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-25 15:00:00', 1010, 92);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-26 15:45:00', 1020, 93);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-27 15:00:00', 1021, 92);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-28 15:45:00', 1022, 93);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (1, '2024-01-10 07:45:00', 1101, 86);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (3, '2024-01-25 09:30:00', 1102, 89);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (5, '2024-01-15 11:00:00', 1103, 78);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (2, '2023-11-10 07:45:00', 1201, 82);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (4, '2023-11-25 09:30:00', 1202, 84);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (6, '2023-11-15 11:00:00', 1203, 80);




---1. Management wants to see all the users that did not login in the past 5 months.

---Method-1

select USER_ID  from logins
group by user_id
having max(LOGIN_TIMESTAMP) < DATEADD(MONTH,-5, getdate());

---Method-2

select distinct USER_ID from logins
where USER_ID not in( select USER_ID from logins
					  where LOGIN_TIMESTAMP > DATEADD(MONTH,-5, getdate())
					)


---2. For the business units' quarterly analysis, calculate how many users and how many sessions were at each quarter?
---order by quarter from newest to oldest.
---Return: first day of the quarter, user_cnt, session_cnt

select 
	 DATETRUNC(QUARTER,min(CAST(LOGIN_TIMESTAMP as date))) first_day_quarter
	,count(USER_ID)										   user_cnt
	,count(SESSION_ID)									   session_cnt
from logins
group by DATEPART(QUARTER, LOGIN_TIMESTAMP)
order by first_day_quarter


---3. Display user_id's that log_in in January 2024 and did not log in November 2023
---Return User_id


select distinct USER_ID from logins where LOGIN_TIMESTAMP between '2024-01-01' and '2024-01-31'
and USER_ID not in
(select distinct USER_ID from logins where LOGIN_TIMESTAMP between '2023-11-01' and '2023-11-30')


---4. Add to the query from 2 the percentage change in sessions from last quarter.
--- Return: First day of teh quarter, session_cnt, Session_cnt_prev, session_percent_change

with cte as (
select 
	 DATETRUNC(QUARTER,min(CAST(LOGIN_TIMESTAMP as date))) first_day_quarter
	,count(SESSION_ID)									   session_cnt
from logins
group by DATEPART(QUARTER, LOGIN_TIMESTAMP)
			)

select *
	, lag(session_cnt) over(order by session_cnt) Session_cnt_prev 
	, 100.0*(session_cnt-(lag(session_cnt) over(order by session_cnt)))/(lag(session_cnt) over(order by session_cnt)) session_percent_change
from cte




---5. Display the user that had the higest session score(max) for each day.
--- Return: Date, username, score

with cte as (
select cast(l.LOGIN_TIMESTAMP as date) login_date
	   , u.USER_NAME				   username
	   , sum(l.SESSION_SCORE )         score 
from logins l 
join users u 
on l.USER_ID = u.USER_ID
group by cast(l.LOGIN_TIMESTAMP as date), u.USER_NAME
			)

select login_date, username, score 
from ( 
select *, row_number() over(partition by login_date order by score) rn from cte ) a
where rn =1



---6. To identify our best users - Return the users that had a session on every single day since their first login 
--- (make assumptions if needed)
--- Return: user_id


select USER_ID
from logins
group by USER_ID
having  DATEDIFF(day,min(CAST(LOGIN_TIMESTAMP as date)), cast(GETDATE() as date)) = count(SESSION_ID)



---7. On what dates there were no log_in at all?
---Return: login_dates
---2023-07-15 and 2024-06-28

with cte as (
select CAST(min(LOGIN_TIMESTAMP) as date) first_date from logins
union all
select DATEADD(DAY,1,first_date) from cte
where first_date<'2024-06-28')

select * from cte
where first_date not in (select distinct CAST(login_timestamp as date) from logins)
option(maxrecursion 500)


