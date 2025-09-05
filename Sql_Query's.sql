Create Database Academic_Performance;
Use Academic_Performance;

Create Table Student_info(
	student_id INT PRIMARY KEY,
	first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
	email VARCHAR(100),
	email VARCHAR(100),
	gender enum("male", "female"),
	part_time_job VARCHAR(20),
	absence_days int,
	extracurricular_activities VARCHAR(20),
    weekly_self_study_hours INT,
    career_aspiration VARCHAR(100),
    math_score INT,
    history_score INT,
	physics_score INT,
    chemistry_score INT,
    biology_score INT,
    english_score INT,
    geography_score INT
);

-- Insert Data Using "Table Data Import Wizard" From "student-scores.csv"
SELECT * FROM Student_info;

/* Here are basic, medium, and advanced level SQL query questions tailored
for a typical student scores dataset, suitable for practicing skills and
demonstrating business analysis concepts.*/


-- Basic Level :

-- Q.1 Write a query to list all students and their marks in each subject. 
SELECT 
	concat(first_name," ",last_name) as Full_name,
    math_score, history_score,
    physics_score, chemistry_score,
    biology_score, english_score,
    geography_score
from Student_info;


-- Create A New Column "Total Marks"
ALTER TABLE Student_info
ADD Column Total_marks int;

SET SQL_SAFE_UPDATES = 0;     -- OFF Safe Mode To Permanent Update In Table.

-- Set Value In Total Column 
UPDATE Student_info
Set Total_marks = math_score + history_score + physics_score +
chemistry_score + biology_score + english_score + geography_score;


-- Q.2 Find the total marks scored by each student.
SELECT 
	concat(first_name," ",last_name) as Full_name,
    Total_Marks
from Student_info;


-- Create A New Column "Percentage"
ALTER TABLE Student_info
ADD Column Percentage int;

-- Set Value In Total Column 
UPDATE Student_info
Set Percentage = Total_Marks/700*100;


-- Q.3 Display the names of students having Percentage greater than a specified value (e.g., 75).
SELECT 
	concat(first_name," ",last_name) as Full_name,
    Total_Marks
from Student_info
Where Percentage >=75;
-- ----------------------------------------------------------------------------------------------


-- Medium Level :

-- Q.1 Calculate the average marks for each student and display their names along with the average.
SELECT 
	concat(first_name," ",last_name) as Full_name,
    Percentage As Average_marks
from Student_info;


-- Q.2 List students who have scored above the overall average mark in at least one subject.
SELECT 
	concat(first_name," ",last_name) as Full_name
from Student_info
Where 
	math_score > (select avg(math_score) from Student_info) or
    history_score > (select avg(history_score) from Student_info) or
    physics_score > (select avg(physics_score) from Student_info) or
    chemistry_score > (select avg(chemistry_score) from Student_info) or
    biology_score > (select avg(biology_score) from Student_info) or
    english_score > (select avg(english_score) from Student_info) or
    geography_score > (select avg(geography_score) from Student_info); 


-- Q.3 Retrieve the name of the student who scored the maximum mark in maths subject.
SELECT 
	CONCAT(first_name, ' ', last_name) AS Student, 
    math_score AS Max_Score
FROM Student_info
WHERE math_score = (SELECT MAX(math_score) FROM Student_info) ;
-- ----------------------------------------------------------------------------------------------


-- Advanced  Level :
-- Q.1 Write a query to display students who have the highest marks in minimum 3 subjects
--     among their peers (across all subjects). 
SELECT 
    CONCAT(first_name, ' ', last_name) AS Full_name
FROM Student_info
WHERE 
    (math_score = (SELECT MAX(math_score) FROM Student_info)) +
    (history_score = (SELECT MAX(history_score) FROM Student_info)) +
    (physics_score = (SELECT MAX(physics_score) FROM Student_info)) +
    (chemistry_score = (SELECT MAX(chemistry_score) FROM Student_info)) +
    (biology_score = (SELECT MAX(biology_score) FROM Student_info)) +
    (english_score = (SELECT MAX(english_score) FROM Student_info)) +
    (geography_score = (SELECT MAX(geography_score) FROM Student_info))
    >= 3;


-- Create A New Column "Paasing Marks"
ALTER TABLE Student_info
ADD Column Passing_mark int;

SET SQL_SAFE_UPDATES = 0;     -- OFF Safe Mode To Permanent Update In Table.

-- Set Value In Passing_Marks Column 
UPDATE Student_info
Set Passing_mark = 40;


-- Q.2 Find students who failed in at least one subject, assuming the pass mark is 40.
SELECT 
    CONCAT(first_name, ' ', last_name) AS Full_name
FROM Student_info
WHERE 
	math_score < passing_mark or
    history_score < passing_mark or
	physics_score < passing_mark or
	chemistry_score < passing_mark or
	biology_score < passing_mark or
	english_score < passing_mark or
	geography_score < passing_mark;
    

-- Q.3 Generate a comprehensive performance report showing: 
-- 	   student name, total marks, percentage, and whether they passed all subjects
--     (using CASE, JOINs, and aggregate functions). 
SELECT 
    CONCAT(first_name, ' ', last_name) AS Student_Name,
    Total_Marks,
    Percentage,
    CASE 
        WHEN math_score >= Passing_mark 
             AND history_score >= Passing_mark 
             AND physics_score >= Passing_mark 
             AND chemistry_score >= Passing_mark 
             AND biology_score >= Passing_mark 
             AND english_score >= Passing_mark 
             AND geography_score >= Passing_mark 
        THEN 'Pass'
        ELSE 'Fail'
    END AS Result
FROM Student_info;












