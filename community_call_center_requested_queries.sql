/**************************************
Author: Chantal Shirley
Community Call Center Requested Queries Script
Date: 4/8/20
Desc: This is a file containing the type
of sql queries the community call center
would like to use routinely. There were
three total queries requested by the community
call center.
***************************************/
-- The list for managers to see the 
-- calls based on average call length by counselor
USE ccc;

SELECT 
	CONCAT(counselors.counselor_first_name, ' ', counselors.counselor_last_name) AS "Counselor"
	, SEC_TO_TIME(AVG(TIMEDIFF(call_logs.end_time, call_logs.start_time))) AS "Average Call Length"
FROM
	call_logs
		INNER JOIN
			counselors
				ON
					call_logs.default_counselor_id =
						counselors.counselor_id
GROUP BY
	counselor WITH ROLLUP;

-- The number of calls on Tuesdays
SELECT
	DATE(call_logs.call_date) AS "Week"
	, COUNT(call_logs.call_log_id) AS "Total Tuesday Calls"
FROM
	call_logs
WHERE
	DAYOFWEEK(call_logs.call_date) = 2
GROUP BY
	week(call_date);

-- The number of calls that were referred 
-- by counselor last over a period of time

SELECT
	COUNT(call_logs.call_log_id) AS "Number of Referrals in March"
FROM
	call_logs
		JOIN
			intake_data
				ON
					call_logs.call_log_id = 
						intake_data.default_call_log_id
WHERE
	MONTH(call_logs.call_date) = 3 AND
    intake_data.referral_status = 'referred';
