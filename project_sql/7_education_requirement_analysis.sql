-- Finding the average salary for job postings with and without degree requirements
SELECT 
    'Degree Mentioned' AS degree_status,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings_fact
WHERE 
    job_no_degree_mention = FALSE

UNION ALL

SELECT 
    'No Degree Mentioned' AS degree_status,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings_fact
WHERE 
    job_no_degree_mention = TRUE;

