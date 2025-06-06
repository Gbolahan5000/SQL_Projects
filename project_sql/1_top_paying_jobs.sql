/*
Question: What are the top-paoying Data Analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focus on job postings with specified salaries (NOT NULL).
- Why? Highlight the Top-paying opportunties for Data Analysts, offering insight into the job market.
*/

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
    ;