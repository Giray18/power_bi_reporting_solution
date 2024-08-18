# PowerBI reporting solution
This repo has scripts, PowerBI files, excel files related to a task solution and data profiling operations, IPYNB notebooks related to SQL task.
Overall, task solution has seperated into 4 section as defined below,

## Data Profiling;
First, shared scripts used on SSMS to create tables that will be used as source database for solution. After running shared scripts It is seen that there are 4 tables loaded with data.

For to showcase python capabilities, data profiling made by custom made python modules (by myself dat and sql_profiler module). Source code related to modules can be found on https://github.com/Giray18/power_bi_reporting_solution/tree/main/src . 
These modules has run python data profiling methods and saves output of profiled data into a date partitioned auto created folder that can be reached by location https://github.com/Giray18/power_bi_reporting_solution/tree/main/data_profiling_results/2024-08-16 . 

As a result for 4 database table 4 data profiling output xlsx files created and based on the initial check It has been understood that there is 1 dim (test_cases) and 3 fact tables (test_Emails, test_LiveChatTranscript, test_calls) being used on database. 


## SQL Task Solution;
As per requirements of task, queries written to get data asked by below 2 inquiries. Solution created in 2 different methods first by using python method used on Data Profiling section (sql_profier module), second as native SQL queries.

* Which teams had the shortest and the longest average duration of chats?
* Which team had the lowest average response time between first incoming email and the next call. What was the average for this team?

First solution is shown on jupyter notebook attachment can be found on https://github.com/Giray18/power_bi_reporting_solution/tree/main/jupyter_notebooks.

Second solution`s output files can be found on https://github.com/Giray18/power_bi_reporting_solution/tree/main/t-sql_queries.

## Excel Task Solution;
As per task requirements there is a pivot table creation task based on source data. Since I created my source files on SSMS database, I used Excel`s native SSMS connector to gather data into excel. After ingestion applied pivot table steps to gather solution`s required data which can be found on https://github.com/Giray18/power_bi_reporting_solution/tree/main/excel_task .

## Power BI Task Solution;
2 reports created based on requirements defined on PowerBI section of the task document. 
On first report named as Team Activities; Visualitions created to reflect below inquiries answers.
Weekday Slicer and Percent % Slicer bringing required data into visuals

* What teams were in top 20% by number of daily taken calls 1) on weekdays and 2) on weekends?
* What teams were in bottom 20% of total activities (emails, chats and calls), for all closed cases?


