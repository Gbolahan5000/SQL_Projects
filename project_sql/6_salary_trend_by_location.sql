
SELECT 
    job_location,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary,
    COUNT(*) AS job_count
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_location IS NOT NULL
GROUP BY 
    job_location
ORDER BY 
    avg_salary DESC
LIMIT 25;


