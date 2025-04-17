/*
Question: What skills are required for the top paying Data Analyst jobs?
- Use the top 10  highest paying Data Analyst jobs from the previous query.
- Add the specific skills required for each role.
- Why? It provides a detailed view of the skills to develop that align with top salaries.
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        name AS company_name,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date
    FROM
        job_postings_fact
    LEFT JOIN company_dim
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_location = 'Anywhere' AND
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim
    ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    top_paying_jobs.salary_year_avg DESC
;

/*
The breakdown of the most in demand skill for Data Analyst in 2023, based on job postings:
SQL is leading with a bold count of 8
Python follows with a bold count of 7
Tableau is also highly sort after, with a bold count of 6
Other skills like R, Snowflake, Panda, and Excel show varying degrees of demand.
*/