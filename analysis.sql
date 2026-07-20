SELECT * FROM student;

-- Q. What is the distribution of students across different major categories?
SELECT major_category , COUNT(*) AS "number_of_students"
FROM student
GROUP BY major_category
ORDER BY number_of_students DESC;

-- Q. How are students distributed across different years of study?
SELECT year_of_study , COUNT(*) AS "number_of_students"
FROM student
GROUP BY year_of_study
ORDER BY number_of_students DESC;

-- Q. What is the average pre-semester CGPA and post-semester CGPA for each major category?
SELECT  major_category ,
ROUND(AVG(pre_semester_gpa::NUMERIC),2) AS "average pre-semester gpa",
ROUND(AVG(post_semester_gpa::NUMERIC),2) AS "average post-semester gpa"
FROM student
GROUP BY major_category DESC;

-- Q.How many students improved , declined or maintained their CGPA after the semester?
SELECT performance_status , COUNT(student_id) AS "number_of_students"
FROM student
GROUP BY performance_status
ORDER BY number_of_students DESC;

-- Q. Which major category spends the highest average number of hours using gen AI each week?
SELECT major_category , ROUND(AVG(weekly_genai_hours::NUMERIC),2) AS "average_weekly_genAI_hours"
FROM student
GROUP BY major_category
ORDER BY AVG(weekly_genai_hours) DESC
LIMIT 1;

-- Q. Which primary AI use case is the most common amongst students?
SELECT primary_use_case , COUNT(student_id) AS "number_of_students"
FROM student
GROUP BY primary_use_case 
ORDER BY number_of_students DESC;

-- Q. How many students of each major category for each prompt engineering skill level?
SELECT  major_category  , prompt_engineering_skill , COUNT(student_id) AS "number_of_students"
FROM student
GROUP BY major_category,prompt_engineering_skill 
ORDER BY major_category ,
		CASE prompt_engineering_skill
			WHEN 'Beginner' THEN 1
			WHEN 'Intermediate' THEN 2
			WHEN 'Advanced' THEN 3
			END;

-- Q. Do students with paid subscriptions spend more time using genAI than those without subscription?
SELECT paid_subscription , ROUND(AVG(weekly_genai_hours::NUMERIC),2) AS "average_weekly_genai_hours"
FROM student
GROUP BY paid_subscription
ORDER BY AVG(weekly_genai_hours) DESC;

-- Q. Which major category students are facing high anxiety?
SELECT major_category , COUNT(student_id) AS "number_of_student"
FROM student
WHERE anxiety_level IN ('High','Medium')
GROUP BY major_category
ORDER BY number_of_student DESC;

-- Q. Which major category contributes the highest number of students to the overall top 20 students?
WITH top_20 AS (
	SELECT * FROM student
	ORDER BY post_semester_gpa DESC
	LIMIT 20
)
SELECT major_category FROM top_20
GROUP BY major_category
ORDER BY COUNT(student_id) DESC
LIMIT 1;






