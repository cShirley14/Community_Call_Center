/**************************************
Author: Chantal Shirley
Community Call Center Database Script
Date: 4/8/20
Desc: This is a file containing the sql
script needed to generate the Community
Call Center Database.
***************************************/

/**************************************
Part 1 - The establishment of tables for
the community call center database
***************************************/

-- create the database
DROP DATABASE IF EXISTS ccc;
-- ccc stands for the name of the organization requesting
-- the database, "Community Call Center," thus ccc
CREATE DATABASE ccc;

-- select the database
USE ccc;

-- create the tables
CREATE TABLE counselors
(
    counselor_id INT(11) PRIMARY KEY AUTO_INCREMENT
		COMMENT "The counselor's unique assigned id number",
    counselor_first_name VARCHAR(50) NOT NULL
		COMMENT "The counselor's first name",
    counselor_last_name VARCHAR(50) NOT NULL
		COMMENT "The counselor's last name",
    counselor_status ENUM('volunteer', 'employee') NOT NULL
		COMMENT "The counselors status with the Community Call Center"
) COMMENT "The table that houses all the counselors employment information";

CREATE TABLE callers
(
    caller_id INT(11) PRIMARY KEY AUTO_INCREMENT
		COMMENT "An id assigned to each caller of the Community Call Center's services",
    caller_gender ENUM('Male', 'Female', 'Gender Queer', 'Intersex', 'N/A', 'Other', 'Unknown') 
        NOT NULL DEFAULT 'Unknown' COMMENT "A value indicating the identified gender of the caller",
    caller_first_name VARCHAR(50) NOT NULL COMMENT "The first name of the caller",
    caller_last_name VARCHAR(50) NOT NULL COMMENT "The last name of the caller"
) COMMENT "The table that houses the personal data of all the callers";

CREATE TABLE call_logs
(
    call_log_id INT(11) PRIMARY KEY AUTO_INCREMENT
		COMMENT "The unique id assigned to each call 
			logged in the Community Call Center by the counselors",
	default_caller_id INT(11) NOT NULL
		COMMENT "A foreign key from the caller's table",
    default_counselor_id INT(11) NOT NULL
		COMMENT "A foreign key from the counselors table",
    caller_phone_number VARCHAR(50) NOT NULL
		COMMENT "The phone number of the caller to the Community Call Center",
    start_time TIME NOT NULL
		COMMENT "The start time of the call",
    end_time TIME NOT NULL
		COMMENT "The end time of the call",
    call_date DATE NOT NULL
		COMMENT "The date of the call",
    CONSTRAINT fk_counselor_id
        FOREIGN KEY (default_counselor_id)
        REFERENCES counselors (counselor_id), -- Foreign key constraint for the counselors table
	CONSTRAINT fk_default_caller_id
		FOREIGN KEY (default_caller_id)
        REFERENCES callers (caller_id) -- Foreign key constraint for the caller's table
) COMMENT "The table that houses all the call log time and date data";

CREATE TABLE intake_data
(
    intake_id INT(11) PRIMARY KEY AUTO_INCREMENT
		COMMENT "An id assigned to each unit of intake data",
    default_call_log_id INT(11) NOT NULL UNIQUE
		COMMENT "A foreign key from the call_logs table",
    referral_status ENUM('referred', 'not-referred', 'N/A') NOT NULL DEFAULT 'N/A'
		COMMENT "A value indicating whether or not a referral was made.",
    referral_follow_up ENUM('yes', 'no') NOT NULL
		COMMENT "A value indicating whether or not the counselor assigned to the 
			call log followed up on the referral",
    police_called ENUM('yes', 'no') NOT NULL
		COMMENT "A value indicating whether the police were called",
    ambulance_called ENUM('yes', 'no') NOT NULL
		COMMENT "A value indicating whether ambulatory services were called",
    CONSTRAINT fk_default_call_log_id
        FOREIGN KEY (default_call_log_id)
        REFERENCES call_logs (call_log_id) -- foreign key constraint for the call_logs table
) COMMENT "The table that houses the descriptive intake data of each call log";

/**************************************
Part 2 - Insertion of Sample Data
***************************************/
USE ccc;

-- Adds data to the counselor's table
INSERT INTO counselors
(
	counselors.counselor_id
    , counselors.counselor_first_name
    , counselors.counselor_last_name
    , counselors.counselor_status
)
VALUES
(
	NULL
    , 'Takesha'
    , 'Smith'
    , 'employee'
),
(
	NULL
    , 'Jennifer'
    , 'Scott'
    , 'volunteer'
),
(
	NULL
    , 'Matthew'
    , 'Durant'
    , 'employee'
),
(
	NULL
    , 'Jacob'
    , 'Smiles'
    , 'volunteer'
),
(
	NULL
    , 'Henry'
    , 'Serif'
    , 'volunteer'
),
(
	NULL
    , 'Cindy'
    , 'Jackson'
    , 'volunteer'
);
-- statement to confirm successful insertion
USE ccc;
SELECT *
FROM counselors;

-- Adds data to the call_log's table
INSERT INTO callers
(
	callers.caller_id
    , callers.caller_gender
    , callers.caller_first_name
    , callers.caller_last_name
)
VALUES
(
	857342
    , 'Intersex'
    , 'Sharon'
    , 'Patterson'
),
(
	NULL
    , 'N/A'
    , 'Duke'
    , 'Walker'
),
(
	96834234
    , 'Male'
    , 'Dana'
    , 'Scott'
),
(
	NULL
    , DEFAULT
    , 'Jetson'
    , 'Stevens'
),
(
	NULL
    , 'Gender Queer'
    , 'Simon'
    , 'Franks'
),
(
	99834234
    , 'Other'
    , 'Samantha'
    , 'Leo'
),
(
	NULL
    , 'Female'
    , 'Jasmine'
    , 'Walker'
);

-- statement to confirm successful insertion
USE ccc;
SELECT *
FROM callers;

-- Adds data to the call_log's table
INSERT INTO call_logs
(
	call_logs.call_log_id
    , call_logs.default_caller_id
    , call_logs.default_counselor_id
    , call_logs.caller_phone_number
    , call_logs.start_time
    , call_logs.end_time
    , call_logs.call_date
)
VALUES
(
	DEFAULT
    , 96834234
	, 3
    , '555-239-9023'
    , '08:33:03'
    , '09:35:34'
    , '2020-02-25'
),
(
	DEFAULT
    , 99834234
	, 2
    , '453-323-8932'
    , '02:34:34'
    , '05:32:12'
    , '2020-02-24'
),
(
	DEFAULT
    , 857342
	, 1
    , '343-234-1831'
    , '13:17:54'
    , '18:56:23'
    , '2020-03-16'
),
(
	DEFAULT
    , 99834235
	, 5
    , '254-839-4893'
    , '23:56:23'
    , '24:46:21'
    , '2020-03-16'
),
(
	DEFAULT
    , 857343
	, 6
    , '564-232-3452'
    , '21:46:24'
    , '21:54:21'
    , '2020-03-17'
),
(
	DEFAULT
    , 96834236
	, 4
    , '874-363-1232'
    , '22:03:04'
    , '22:36:20'
    , '2020-03-17'
),
(
	DEFAULT
    , 96834235
	, 2
    , '533-345-2354'
    , '10:03:03'
    , '11:05:34'
    , '2020-03-18'
),
(
	DEFAULT
    , 857342
	, 6
    , '332-542-3563'
    , '02:34:45'
    , '05:14:52'
    , '2020-03-19'
);

-- statement to confirm successful insertion
USE ccc;
SELECT *
FROM call_logs;

-- Adds data to the intake_data's table
INSERT INTO intake_data
(
	intake_data.intake_id
    , intake_data.default_call_log_id
    , intake_data.referral_status
    , intake_data.referral_follow_up
    , intake_data.police_called
    , intake_data.ambulance_called
)
VALUES
(
	4323232
    , 1
    , 'referred'
    , 'yes'
    , 'no'
    , 'yes'
),
(
	DEFAULT
    , 4
    , 'not-referred'
    , 'no'
    , 'yes'
    , 'yes'
),
(
	DEFAULT
    , 8
    , 'referred'
    , 'yes'
    , 'yes'
    , 'yes'
),
(
	DEFAULT
    , 2
    , 'not-referred'
    , 'no'
    , 'yes'
    , 'yes'
),
(
	DEFAULT
    , 6
    , 'referred'
    , 'no'
    , 'yes'
    , 'no'
),
(	
	DEFAULT
	, 3
    , 'not-referred'
    , 'no'
    , 'no'
    , 'yes'
),
(
	DEFAULT
    , 7
    , 'referred'
    , 'yes'
    , 'no'
    , 'no'
),
(
	DEFAULT
	, 5
    , 'not-referred'
    , 'no'
    , 'no'
    , 'yes'
);

-- statement to confirm successful insertion
USE ccc;
SELECT *
FROM intake_data;