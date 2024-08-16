-- Using CTE`s for easy code reading
WITH CTE_duration (case_id, createddate, enddate, duration) 
AS 
-- Calculating duration on LiveChat table by seconds
( 
	SELECT case_id, 
	createddate, enddate, 
	DATEDIFF(second, createddate, enddate) AS duration 
	FROM dbo.test_LiveChatTranscript 
)
, 
-- Group by and average duration by team_number
CTE_chat_group_team_duration (owner_team, average_chat_duration) 
AS 
( 
	SELECT owner_team , AVG(duration) as average_chat_duration  
	FROM CTE_duration 
	JOIN dbo.test_cases cases 
	ON CTE_duration.case_id = cases.caseid 
	GROUP BY owner_team 
)
,
-- Ranking average duration in ascending order
CTE_chat_ranks (owner_team, average_chat_duration, rank_chat_dur) 
AS 
( 
	SELECT owner_team, average_chat_duration, RANK() OVER (ORDER BY average_chat_duration) as rank_chat_dur 
	FROM CTE_chat_group_team_duration 
)
-- Filtering shortest and longest teams by average duration ranking
SELECT owner_team FROM CTE_chat_ranks WHERE rank_chat_dur = 1 OR rank_chat_dur IN (SELECT  MAX(rank_chat_dur) FROM CTE_chat_ranks)
                         