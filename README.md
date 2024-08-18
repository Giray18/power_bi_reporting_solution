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
As per task requirements there is a pivot table creation task based on source data. Since I created my source files on SSMS database, I used Excel native SSMS connector to gather data into excel. After ingestion applied pivot table steps to gather solution`s required data which can be found on https://github.com/Giray18/power_bi_reporting_solution/tree/main/excel_task .

## Power BI Task Solution;
2 reports created based on requirements defined on PowerBI section of the task document. <br>

**On first report:** Named as Team Activities; Visualitions created to reflect below inquiries answers.
Weekday Slicer and Percent % Slicer bringing required data into tree map visuals.
Additional, matrix view and card visuals put on report to give more detailed descriptive analysis of team performance.

* What teams were in top 20% by number of daily taken calls 1) on weekdays and 2) on weekends?
* What teams were in bottom 20% of total activities (emails, chats and calls), for all closed cases?

**On second report:** Named as Case Details Report; Visualizations created as requested by below items.
Slicers on left panel working in cascade fashion.

* Case summary (matrix) visualization filters for team and case create date (Cascading). 
* The case summary visualization will have the following columns: case IDs, and case details (created date, closed date, owner ID, and team). 
* Case detail visualization filter for “create date”. For calls this is the start date, for email it is the sent date, for chat it is the create date.
* The case detail visualization will display case activity details for the cases displayed in the case summary. This means the case detail visualization will respect the team and date filter for the summary visualization. Furthermore if the report user selects a case (or cases) in the case summary visualization only these case activities will appear in the detail visualization.
* The activity details to display are:
	• Case ID
	• Type of Activity (email, chat or call)
	• For calls  - start date/time, end date/time and duration
	• For email – send date/time and incoming flag (as Yes/No)
	• For chat – create date/time, end date/time and duration.


