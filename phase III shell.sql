/*
CS4400: Introduction to Database Systems
Fall 2020
Phase III Template

Team 13
Jae Il Kim (jkim3300)
Seil Kwon (skwon96)
Haoyun Cao (hcao74)

Directions:
Please follow all instructions from the Phase III assignment PDF.
This file must run without error for credit.
*/

-- ID: 2a
-- Author: lvossler3
-- Name: register_student
DROP PROCEDURE IF EXISTS register_student;
DELIMITER //
CREATE PROCEDURE register_student(
		IN i_username VARCHAR(40),
        IN i_email VARCHAR(40),
        IN i_fname VARCHAR(40),
        IN i_lname VARCHAR(40),
        IN i_location VARCHAR(40),
        IN i_housing_type VARCHAR(20),
        IN i_password VARCHAR(40)
)
BEGIN

-- Type solution below

INSERT INTO user (username, fname, lname, email, user_password) VALUES (i_username, i_fname, i_lname, i_email, MD5(i_password));
INSERT INTO student (student_username, housing_type, location) values(i_username, i_housing_type, i_location);

-- End of solution
END //
DELIMITER ;

-- ID: 2b
-- Author: lvossler3
-- Name: register_employee
DROP PROCEDURE IF EXISTS register_employee;
DELIMITER //
CREATE PROCEDURE register_employee(
		IN i_username VARCHAR(40),
        IN i_email VARCHAR(40),
        IN i_fname VARCHAR(40),
        IN i_lname VARCHAR(40),
        IN i_phone VARCHAR(10),
        IN i_labtech BOOLEAN,
        IN i_sitetester BOOLEAN,
        IN i_password VARCHAR(40)
)
BEGIN
-- Type solution below

	INSERT INTO user (username, fname, lname, email, user_password) 
    VALUES (i_username, i_fname, i_lname, i_email, MD5(i_password));
	INSERT INTO employee (emp_username, phone_num) values(i_username, i_phone);
	IF i_labtech THEN
	INSERT INTO labtech values(i_username);
	END IF;
	IF i_sitetester THEN
	INSERT INTO sitetester values(i_username);
	END IF;
    
-- End of solution
END //
DELIMITER ;

-- ID: 4a
-- Author: Aviva Smith
-- Name: student_view_results
DROP PROCEDURE IF EXISTS `student_view_results`;
DELIMITER //
CREATE PROCEDURE `student_view_results`(
    IN i_student_username VARCHAR(50),
	IN i_test_status VARCHAR(50),
	IN i_start_date DATE,
    IN i_end_date DATE
)
BEGIN
	DROP TABLE IF EXISTS student_view_results_result;
    CREATE TABLE student_view_results_result(
        test_id VARCHAR(7),
        timeslot_date date,
        date_processed date,
        pool_status VARCHAR(40),
        test_status VARCHAR(40)
    );
    INSERT INTO student_view_results_result

    -- Type solution below

		SELECT t.test_id, t.appt_date, p.process_date, p.pool_status , t.test_status
        FROM Appointment a
            LEFT JOIN Test t
                ON t.appt_date = a.appt_date
                AND t.appt_time = a.appt_time
                AND t.appt_site = a.site_name
            LEFT JOIN Pool p
                ON t.pool_id = p.pool_id
        WHERE i_student_username = a.username
            AND (i_test_status = t.test_status OR i_test_status IS NULL)
            AND (i_start_date <= t.appt_date OR i_start_date IS NULL)
            AND (i_end_date >= t.appt_date OR i_end_date IS NULL);

    -- End of solution
END //
DELIMITER ;

-- ID: 5a
-- Author: asmith457
-- Name: explore_results
DROP PROCEDURE IF EXISTS explore_results;
DELIMITER $$
CREATE PROCEDURE explore_results (
    IN i_test_id VARCHAR(7))
BEGIN
    DROP TABLE IF EXISTS explore_results_result;
    CREATE TABLE explore_results_result(
        test_id VARCHAR(7),
        test_date date,
        timeslot time,
        testing_location VARCHAR(40),
        date_processed date,
        pooled_result VARCHAR(40),
        individual_result VARCHAR(40),
        processed_by VARCHAR(80)
    );
    INSERT INTO explore_results_result

    -- Type solution below

	select test_id, appt_date, appt_time, appt_site, process_date,pool_status, test_status, concat(fname,' ',lname) as 'processed_by' 
	from test natural join pool join user on processed_by = username
	where test_id = i_test_id;

    -- End of solution
END$$
DELIMITER ;

-- ID: 6a
-- Author: asmith457
-- Name: aggregate_results
DROP PROCEDURE IF EXISTS aggregate_results;
DELIMITER $$
CREATE PROCEDURE aggregate_results(
    IN i_location VARCHAR(50),
    IN i_housing VARCHAR(50),
    IN i_testing_site VARCHAR(50),
    IN i_start_date DATE,
    IN i_end_date DATE)
BEGIN
    DROP TABLE IF EXISTS aggregate_results_result;
    CREATE TABLE aggregate_results_result(
        test_status VARCHAR(40),
        num_of_test INT,
        percentage DECIMAL(6,2)
    );

    INSERT INTO aggregate_results_result

    -- Type solution below

    SELECT test_status, count(*), (count(*) / SUM(count(*)) over ()) * 100
    FROM test t 
    JOIN appointment a ON (t.appt_date = a.appt_date AND t.appt_time = a.appt_time AND t.appt_site = a.site_name)
	JOIN student s ON a.username = s.student_username
	WHERE (i_location = s.location OR i_location IS NULL)
            AND (i_housing = s.housing_type OR i_housing IS NULL)
            AND (i_testing_site = t.appt_site OR i_testing_site IS NULL)
            AND (i_start_date <= t.appt_date OR i_start_date IS NULL)
            AND (i_end_date >= t.appt_date OR i_end_date IS NULL)
	GROUP BY test_status;

    -- End of solution
END$$
DELIMITER ;


-- ID: 7a
-- Author: lvossler3
-- Name: test_sign_up_filter
DROP PROCEDURE IF EXISTS test_sign_up_filter;
DELIMITER //
CREATE PROCEDURE test_sign_up_filter(
    IN i_username VARCHAR(40),
    IN i_testing_site VARCHAR(40),
    IN i_start_date date,
    IN i_end_date date,
    IN i_start_time time,
    IN i_end_time time)
BEGIN
    DROP TABLE IF EXISTS test_sign_up_filter_result;
    CREATE TABLE test_sign_up_filter_result(
        appt_date date,
        appt_time time,
        street VARCHAR (40),
        city VARCHAR(40),
        state VARCHAR(2),
        zip VARCHAR(5),
        site_name VARCHAR(40));
    INSERT INTO test_sign_up_filter_result

    -- Type solution below

	select appt_date, appt_time, street, city, state, zip, appointment.site_name from appointment join site on appointment.site_name = site.site_name
    where username is null 
    and (select location from student where student_username = i_username) = location
    and (i_testing_site = appointment.site_name OR i_testing_site IS NULL)
    AND (i_start_date <= appt_date OR i_start_date IS NULL)
	AND (i_end_date >= appt_date OR i_end_date IS NULL)
    AND (i_start_time <= appt_time OR i_start_time IS NULL)
	AND (i_end_time >= appt_time OR i_end_time IS NULL);

    -- End of solution

    END //
    DELIMITER ;

-- ID: 7b
-- Author: lvossler3
-- Name: test_sign_up
DROP PROCEDURE IF EXISTS test_sign_up;
DELIMITER //
CREATE PROCEDURE test_sign_up(
		IN i_username VARCHAR(40),
        IN i_site_name VARCHAR(40),
        IN i_appt_date date,
        IN i_appt_time time,
        IN i_test_id VARCHAR(7)
)
BEGIN
-- Type solution below

	if (select username from appointment where site_name = i_site_name and appt_date=i_appt_date and appt_time = i_appt_time) is null
    AND i_username not in (select username from appointment join test on site_name = appt_site and appointment.appt_date = test.appt_date and appointment.appt_time = test.appt_time
	where test_status = 'pending')
    then 
    UPDATE appointment SET username = i_username WHERE site_name = i_site_name and appt_date = i_appt_date and appt_time=i_appt_time;
    insert into test (test_id, test_status, pool_id, appt_site, appt_date, appt_time) values (i_test_id, 'pending', null, i_site_name, i_appt_date, i_appt_time);
	end if;

-- End of solution
END //
DELIMITER ;

-- Number: 8a
-- Author: lvossler3
-- Name: tests_processed
DROP PROCEDURE IF EXISTS tests_processed;
DELIMITER //
CREATE PROCEDURE tests_processed(
    IN i_start_date date,
    IN i_end_date date,
    IN i_test_status VARCHAR(10),
    IN i_lab_tech_username VARCHAR(40))
BEGIN
    DROP TABLE IF EXISTS tests_processed_result;
    CREATE TABLE tests_processed_result(
        test_id VARCHAR(7),
        pool_id VARCHAR(10),
        test_date date,
        process_date date,
        test_status VARCHAR(10) );
    INSERT INTO tests_processed_result
    -- Type solution below

	SELECT t.test_id, p.pool_id, t.appt_date, p.process_date, t.test_status
	FROM test t JOIN pool p ON p.pool_id = t.pool_id
	WHERE (i_lab_tech_username = p.processed_by)
	AND (i_start_date <= t.appt_date OR i_start_date IS NULL)
	AND (i_end_date >= t.appt_date OR i_end_date IS NULL)
	AND (i_test_status = t.test_status OR i_test_status IS NULL);

    -- End of solution
    END //
    DELIMITER ;

-- ID: 9a
-- Author: ahatcher8@
-- Name: view_pools
DROP PROCEDURE IF EXISTS view_pools;
DELIMITER //
CREATE PROCEDURE view_pools(
    IN i_begin_process_date DATE,
    IN i_end_process_date DATE,
    IN i_pool_status VARCHAR(20),
    IN i_processed_by VARCHAR(40)
)
BEGIN
    DROP TABLE IF EXISTS view_pools_result;
    CREATE TABLE view_pools_result(
        pool_id VARCHAR(10),
        test_ids VARCHAR(100),
        date_processed DATE,
        processed_by VARCHAR(40),
        pool_status VARCHAR(20));

    INSERT INTO view_pools_result
-- Type solution below
-- Pending included when lower bound givenm but Pending excluded when upper bound or processed by is given (HOW)?
	SELECT p.pool_id, GROUP_CONCAT( t.test_id ) as test_ids , p.process_date, p.processed_by, p.pool_status
    FROM pool p JOIN test t ON t.pool_id = p.pool_id
    WHERE (i_begin_process_date <= p.process_date OR i_begin_process_date IS NULL)
    AND (i_end_process_date >= p.process_date OR i_end_process_date IS NULL)
    AND (i_pool_status = p.pool_status OR i_pool_status IS NULL)
    AND (i_processed_by = p.processed_by OR i_processed_by IS NULL)
    GROUP BY p.pool_id
    ORDER BY test_ids ASC;

-- End of solution
END //
DELIMITER ;

-- ID: 10a
-- Author: ahatcher8@
-- Name: create_pool
DROP PROCEDURE IF EXISTS create_pool;
DELIMITER //
CREATE PROCEDURE create_pool(
	IN i_pool_id VARCHAR(10),
    IN i_test_id VARCHAR(7)
)
BEGIN
-- Type solution below

	if i_test_id in (select test_id from test) and (select pool_id from test where test_id = i_test_id) is null and i_test_id is not null
    then
    insert into pool (pool_id, pool_status, process_date, processed_by) values (i_pool_id, 'pending', null, null);
    update test set pool_id = i_pool_id where test_id=i_test_id;
    end if;

-- End of solution
END //
DELIMITER ;

-- ID: 10b
-- Author: ahatcher8@
-- Name: assign_test_to_pool
DROP PROCEDURE IF EXISTS assign_test_to_pool;
DELIMITER //
CREATE PROCEDURE assign_test_to_pool(
    IN i_pool_id VARCHAR(10),
    IN i_test_id VARCHAR(7)
)
BEGIN
-- Type solution below

	if (select count(*) from test where pool_id=i_pool_id) < 7 and (select pool_id from test where test_id = i_test_id) is null
	then 
	update test set pool_id = i_pool_id where test_id = i_test_id;
	end if;

-- End of solution
END //
DELIMITER ;

-- ID: 11a
-- Author: ahatcher8@
-- Name: process_pool
DROP PROCEDURE IF EXISTS process_pool;
DELIMITER //
CREATE PROCEDURE process_pool(
    IN i_pool_id VARCHAR(10),
    IN i_pool_status VARCHAR(20),
    IN i_process_date DATE,
    IN i_processed_by VARCHAR(40)
)
BEGIN
-- Type solution below

    SELECT pool_status
    INTO @poolcurr_status
    FROM POOL
    WHERE pool_id = i_pool_id;

    IF ((@poolcurr_status = 'pending') AND (i_pool_status = 'positive' OR i_pool_status = 'negative'))
    THEN        
        UPDATE pool
        SET pool_status = i_pool_status, process_date = i_process_date, processed_by = i_processed_by
        WHERE pool_id = i_pool_id;
    END IF;


-- End of solution
END //
DELIMITER ;

-- ID: 11b
-- Author: ahatcher8@
-- Name: process_test
DROP PROCEDURE IF EXISTS process_test;
DELIMITER //
CREATE PROCEDURE process_test(
    IN i_test_id VARCHAR(7),
    IN i_test_status VARCHAR(20)
)
BEGIN
-- Type solution below
	SELECT pool_status
    INTO @curr_status
    FROM test left outer join pool on test.pool_id = pool.pool_id
    WHERE test_id = i_test_id;
   
    if
        ((@curr_status = 'positive') AND (i_test_status = 'positive' OR i_test_status = 'negative') and (select test_status from test where test_id = i_test_id) = 'pending')
    THEN
        update test set test_status = i_test_status where test_id=i_test_id;
	end if;
  
	if (@curr_status = 'negative') and (i_test_status = 'negative') then
      update test set test_status = 'negative' where test_id = i_test_id;
	end if;

-- End of solution
END //
DELIMITER ;

-- ID: 12a
-- Author: dvaidyanathan6
-- Name: create_appointment

DROP PROCEDURE IF EXISTS create_appointment;
DELIMITER //
CREATE PROCEDURE create_appointment(
	IN i_site_name VARCHAR(40),
    IN i_date DATE,
    IN i_time TIME
)
BEGIN
-- Type solution below

	if (select count(*) from test where appt_date= i_date and appt_site = i_site_name) 
    <= 10 * (select count(*) from working_at where site = i_site_name)
	then 
	insert into appointment values (null, i_site_name, i_date, i_time);
    end if;

-- End of solution
END //
DELIMITER ;

-- ID: 13a
-- Author: dvaidyanathan6@
-- Name: view_appointments
DROP PROCEDURE IF EXISTS view_appointments;
DELIMITER //
CREATE PROCEDURE view_appointments(
    IN i_site_name VARCHAR(40),
    IN i_begin_appt_date DATE,
    IN i_end_appt_date DATE,
    IN i_begin_appt_time TIME,
    IN i_end_appt_time TIME,
    IN i_is_available INT  -- 0 for "booked only", 1 for "available only", NULL for "all"
)
BEGIN
    DROP TABLE IF EXISTS view_appointments_result;
    CREATE TABLE view_appointments_result(

        appt_date DATE,
        appt_time TIME,
        site_name VARCHAR(40),
        location VARCHAR(40),
        username VARCHAR(40));

    INSERT INTO view_appointments_result
-- Type solution below

		SELECT a.appt_date, a.appt_time, a.site_name, s.location, a.username 
		FROM appointment a JOIN site s
		ON a.site_name = s.site_name
		WHERE (i_begin_appt_date <= a.appt_date OR i_begin_appt_date IS NULL)
			AND (i_end_appt_date >= a.appt_date OR i_end_appt_date IS NULL)
			AND (i_begin_appt_time <= a.appt_time OR i_begin_appt_time IS NULL)
			AND (i_end_appt_time >= a.appt_time OR i_end_appt_time IS NULL)
			AND (i_site_name = a.site_name OR i_site_name IS NULL)
			AND ((i_is_available = 0 AND a.username IS NOT NULL) OR (i_is_available = 1 AND a.username IS NULL) OR (i_is_available IS NULL));
            
-- End of solution
END //
DELIMITER ;


-- ID: 14a
-- Author: kachtani3@
-- Name: view_testers
DROP PROCEDURE IF EXISTS view_testers;
DELIMITER //
CREATE PROCEDURE view_testers()
BEGIN
    DROP TABLE IF EXISTS view_testers_result;
    CREATE TABLE view_testers_result(

        username VARCHAR(40),
        name VARCHAR(80),
        phone_number VARCHAR(10),
        assigned_sites VARCHAR(255));

    INSERT INTO view_testers_result
-- Type solution below

    SELECT s.sitetester_username, CONCAT(u.fname, ' ', u.lname),  e.phone_num, GROUP_CONCAT(w.site)
    FROM employee e RIGHT JOIN sitetester s ON e.emp_username = s.sitetester_username
    LEFT JOIN user u ON u.username = e.emp_username
    LEFT JOIN working_at w ON w.username = e.emp_username
    GROUP BY s.sitetester_username;

-- End of solution
END //
DELIMITER ;

-- ID: 15a
-- Author: kachtani3@
-- Name: create_testing_site
DROP PROCEDURE IF EXISTS create_testing_site;
DELIMITER //
CREATE PROCEDURE create_testing_site(
	IN i_site_name VARCHAR(40),
    IN i_street varchar(40),
    IN i_city varchar(40),
    IN i_state char(2),
    IN i_zip char(5),
    IN i_location varchar(40),
    IN i_first_tester_username varchar(40)
)
BEGIN
-- Type solution below

INSERT INTO site(site_name, street, city, state, zip, location) VALUES(i_site_name, i_street, i_city, i_state, i_zip, i_location);
INSERT INTO working_at(username, site) VALUES(i_first_tester_username, i_site_name);

-- End of solution
END //
DELIMITER ;

-- ID: 16a
-- Author: kachtani3@
-- Name: pool_metadata
DROP PROCEDURE IF EXISTS pool_metadata;
DELIMITER //
CREATE PROCEDURE pool_metadata(
    IN i_pool_id VARCHAR(10))
BEGIN
    DROP TABLE IF EXISTS pool_metadata_result;
    CREATE TABLE pool_metadata_result(
        pool_id VARCHAR(10),
        date_processed DATE,
        pooled_result VARCHAR(20),
        processed_by VARCHAR(100));

    INSERT INTO pool_metadata_result
-- Type solution below

		SELECT p.pool_id, p.process_date, p.pool_status, CONCAT(u.fname, ' ', u.lname)
		FROM pool p JOIN user u 
		ON p.processed_by = u.username
		WHERE pool_id = i_pool_id and p.pool_status <> 'pending';

    -- End of solution
END //
DELIMITER ;

-- ID: 16b
-- Author: kachtani3@
-- Name: tests_in_pool
DROP PROCEDURE IF EXISTS tests_in_pool;
DELIMITER //
CREATE PROCEDURE tests_in_pool(
    IN i_pool_id VARCHAR(10))
BEGIN
    DROP TABLE IF EXISTS tests_in_pool_result;
    CREATE TABLE tests_in_pool_result(
        test_id varchar(7),
        date_tested DATE,
        testing_site VARCHAR(40),
        test_result VARCHAR(20));

    INSERT INTO tests_in_pool_result
-- Type solution below

    SELECT test_id, appt_date, appt_site, test_status FROM test
    WHERE pool_id = i_pool_id;
    
-- End of solution
END //
DELIMITER ;

-- ID: 17a
-- Author: kachtani3@
-- Name: tester_assigned_sites
DROP PROCEDURE IF EXISTS tester_assigned_sites;
DELIMITER //
CREATE PROCEDURE tester_assigned_sites(
    IN i_tester_username VARCHAR(40))
BEGIN
    DROP TABLE IF EXISTS tester_assigned_sites_result;
    CREATE TABLE tester_assigned_sites_result(
        site_name VARCHAR(40));

    INSERT INTO tester_assigned_sites_result
-- Type solution below

	SELECT site FROM working_at WHERE username = i_tester_username;

-- End of solution
END //
DELIMITER ;

-- ID: 17b
-- Author: kachtani3@
-- Name: assign_tester
DROP PROCEDURE IF EXISTS assign_tester;
DELIMITER //
CREATE PROCEDURE assign_tester(
	IN i_tester_username VARCHAR(40),
    IN i_site_name VARCHAR(40)
)
BEGIN
-- Type solution below

	INSERT INTO working_at(username, site) VALUES(i_tester_username,i_site_name);

-- End of solution
END //
DELIMITER ;


-- ID: 17c
-- Author: kachtani3@
-- Name: unassign_tester
DROP PROCEDURE IF EXISTS unassign_tester;
DELIMITER //
CREATE PROCEDURE unassign_tester(
	IN i_tester_username VARCHAR(40),
    IN i_site_name VARCHAR(40)
)
BEGIN
-- Type solution below

	IF (SELECT COUNT(*) FROM working_at WHERE site=i_site_name) > 1 THEN
		DELETE FROM working_at WHERE site=i_site_name AND username = i_tester_username;
    END IF;

-- End of solution
END //
DELIMITER ;


-- ID: 18a
-- Author: lvossler3
-- Name: daily_results
DROP PROCEDURE IF EXISTS daily_results;
DELIMITER //
CREATE PROCEDURE daily_results()
BEGIN
	DROP TABLE IF EXISTS daily_results_result;
    CREATE TABLE daily_results_result(
		process_date date,
        num_tests int,
        pos_tests int,
        pos_percent DECIMAL(6,2));
	INSERT INTO daily_results_result
    -- Type solution below

    SELECT p.process_date, COUNT(*), SUM(t.test_status='positive'), 
		ROUND((SUM(t.test_status = 'positive') / COUNT(*)) * 100, 2)
	FROM test t JOIN pool p
	ON t.pool_id = p.pool_id
	GROUP BY p.process_date
    HAVING p.process_date IS NOT NULL;

    -- End of solution
    END //
    DELIMITER ;














