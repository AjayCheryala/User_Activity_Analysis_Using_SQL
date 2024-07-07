# User_Activity_Analysis_Using_SQL
### Project Title: User Activity Analysis Using SQL

#### Project Overview

This project focuses on analyzing user activity data from two tables, `users_id` and `logins`. 
The goal is to provide valuable insights into user engagement, activity patterns, and overall usage trends over time. 
By performing various SQL queries, we aim to answer specific business questions that can help the management make informed decisions.

#### Key Tasks

1. **Identifying Inactive Users:**
   - **Objective:** Find users who have not logged in during the past five months.
   - **Query:** Extract user IDs that have no login records in the last five months.

2. **Quarterly User and Session Analysis:**
   - **Objective:** Calculate the number of users and sessions for each quarter, ordered from the newest to the oldest.
   - **Query:** Determine the first day of each quarter, user count, and session count.

3. **User Activity in Specific Months:**
   - **Objective:** Identify users who logged in during January 2024 but did not log in during November 2023.
   - **Query:** Extract user IDs meeting the specified login criteria.

4. **Quarterly Session Growth Analysis:**
   - **Objective:** Calculate the percentage change in sessions from the previous quarter.
   - **Query:** Extend the quarterly analysis to include session count from the previous quarter and the percentage change in sessions.

5. **Daily Top User Sessions:**
   - **Objective:** Determine the user with the highest session score for each day.
   - **Query:** Identify the date, username, and session score of the top user each day.

6. **Consistent Daily Users:**
   - **Objective:** Find users who have logged in every single day since their first login.
   - **Query:** Extract user IDs that meet the criteria for consistent daily activity.

7. **Dates with No Logins:**
   - **Objective:** Identify dates with no login activity.
   - **Query:** List dates on which no logins were recorded.

#### Analytical Questions

1. Which users did not log in during the past 5 months?
2. How many users and sessions were there in each quarter, ordered from newest to oldest?
3. Which users logged in during January 2024 but did not log in during November 2023?
4. What is the percentage change in sessions from the last quarter?
5. Which user had the highest session score each day?
6. Which users had a session on every single day since their first login?
7. On what dates were there no logins at all?

#### Techniques and Skills Used

- **SQL Aggregate Functions:** SUM, COUNT, MAX
- **Date Functions:** DATEPART, DATEDIFF
- **Joins and Subqueries:** Combining data from multiple tables and nested queries
- **Window Functions:** ROW_NUMBER() for ranking user sessions
- **Conditional Logic:** CASE statements for handling various conditions
- **Data Transformation:** Using SQL to transform and analyze data for business insights

---

This project provides a comprehensive analysis of user activity, 
offering insights into user engagement and behavior patterns, 
which are critical for strategic planning and decision-making by the management.
