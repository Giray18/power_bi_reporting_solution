-- Using CTE`s for easy code reading
WITH CTE_incoming_mails (caseid, sent, incoming,rank_email_time_by_case) 
AS 
-- Filtering incoming mails from mail table
( 
	SELECT caseid, 
	sent, incoming , RANK() OVER (PARTITION BY caseid ORDER BY sent ASC) as rank_email_time_by_case 
	FROM dbo.test_Emails WHERE incoming = 1 
)
,
-- Filtering first mails of caseid keys
CTE_first_mails_filtered (caseid, sent) 
AS 
( 
	SELECT caseid, sent FROM CTE_incoming_mails 
	WHERE rank_email_time_by_case = 1 
)
,
-- Inner join between mail, call and cases tables on caseid key
CTE_mail_call_cases_joined (caseid, email_sent_time, call_start_time ,owner_team) 
AS 
( 
	SELECT e.caseid, e.sent AS email_sent_time, c.started_time AS call_start_time, 
	ca.owner_team AS owner_team FROM CTE_first_mails_filtered e 
	JOIN dbo.test_cases ca ON ca.caseid = e.caseid 
	JOIN dbo.test_calls c ON c.caseid = e.caseid 
)
,
-- Ranking calls by email sent time to make available to filter for next call
CTE_ranked_calls (caseid, email_sent_time, call_start_time , rank_of_call, owner_team) 
AS 
( 
	SELECT caseid, email_sent_time, call_start_time, 
	RANK() OVER (PARTITION BY email_sent_time ORDER BY call_start_time ASC) as rank_call_start, 
	owner_team 
	FROM CTE_mail_call_cases_joined 
)
,
-- Filtering first (next calls) by email sent time as per caseid
CTE_first_calls_filtered (email_sent_time, call_start_time , rank_of_call, owner_team) 
AS 
( 
	SELECT email_sent_time, call_start_time , rank_of_call, owner_team 
	FROM CTE_ranked_calls 
	WHERE rank_of_call = 1 
)
, 
-- Aggregate to get average of response time by owner_team
CTE_aggregated_response (owner_team, response_time) 
AS 
( 
	SELECT owner_team, 
	AVG(DATEDIFF(second, email_sent_time, call_start_time)) AS response_time  
	FROM  CTE_first_calls_filtered 
	GROUP BY owner_team 
)
-- Selecting first value from ordered response time column
SELECT TOP(1) owner_team, response_time FROM CTE_aggregated_response 
ORDER BY response_time ASC 