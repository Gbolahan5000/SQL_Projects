# Introduction
📊 Exploring the Data Job Market
This project focuses on Data Analyst roles, analyzing 💰 top-paying positions, 🔥 in-demand skills, and 📈 the intersection of high demand and high salaries in the field of Data Analytics.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/).

# Background
🚀 Purpose Behind the Project
Born from a desire to better navigate the data analyst job market, this project aims to identify top-paying roles and in-demand skills—streamlining the job search process for others seeking optimal opportunities in the field.

Data hails from [Luke Barousse's SQL course](https://lukebarousse.com/sql). It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions asked through the SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. what skills are most in-demand for data analyst?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
To explore the data analyst job market, I utilized a range of powerful tools:

- **SQL:** The core of my analysis, used to query data and uncover key insights.

- **PostgreSQL:** My database management system of choice, ideal for managing job posting data.

- **Visual Studio Code:** Used for writing and executing SQL queries, and managing the database efficiently.

- **Git & GitHub:** For version control, project tracking, and sharing SQL scripts and findings with others.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market.
Here's how i approached each question:

### 1. What are the top paying Data Analyst jobs.
To identify the highest-paying roles, i filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high ppaying opportunities in the field.

```sql
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
LIMIT 10;
```
Here's the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analystroles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in the job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics. 

![Top Paying Roles](assets\top_paying_jobs.png)

*Bar graph visualizing the salary for the top 10 salaries for data analysts; Created using Power BI from my SQL query results*

### 2. What are the skills required for these top-paying Data Analyst jobs?
To uncover the skills needed for the highest-paying data analyst roles, I created a CTE and I filtered for job postings with salary data, focusing on remote roles. I then extracted the associated skills to find which ones consistently appear in top-paying listings.

```sql
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
    top_paying_jobs.salary_year_avg DESC;
```
Key Breakdown
- **Top Skills for Top Pay:** Skills like AWS, Snowflake, Airflow, and Databricks appeared frequently in listings offering $200K+ salaries.
- **Specialized Tools Pay More:** Tools tied to big data and cloud platforms show a strong correlation with high compensation.
- **Technical Edge:** Advanced technical stacks often separate top-tier roles from average ones.

![Top Paying Skills](assets\top_skills.png)

*Bar graph visualizing the count of skills for the top !0 paying jobs for data analysts; Created using Power BI from my SQL query results*

### 3.  What skills are most in-demand for data analysts?
To find the most frequently requested skills across all data analyst job postings, I counted the number of times each skill appeared in listings.

```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
Top In-Demand Skills:
- **SQL, Excel, and Python** dominate, reaffirming their importance in everyday analytics work.

- **Tableau and Power BI** stand out among BI tools.

- These results show that employers value both **foundational and visualization skills.**

| Skill        | Count |
|--------------|-------|
| SQL          | 7291  |
| Excel        | 4611  |
| Python       | 4330  |
| Tableau      | 3745  |
| Power BI     | 2609  |

*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Which skills are associated with higher salaries?
To understand which skills correlate with higher pay, I calculated the average salary for each skill across data analyst job postings.

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```
Findings:
- pystark, bitbucket, and couchbase topped the list with the highest average salaries.
- These tools, often used in cloud and pipeline automation, show that modern data infrastructure skills are highly valued.
- Specialization drives pay – niche and technical tools pay more than general tools.

| Skill        | Average Salary ($) |
|--------------|--------------------|
| pystark      | 208,172            |
| bitbucket    | 189,155            |
| couchbase    | 160,515            |
| watsonc      | 160,515            |
| datarobot    | 155,486            |
| gitlab       | 154,500            |
| swift        | 153,750            |
| jupyter      | 152,777            |
| pandas       | 151,821            |
| elasticsearc | 145,000            |

*Table of the average salary for the top 10 paying skills for data analyst*

### 5. What are the most optimal skills to learn?
To find the “sweet spot” — skills that are both in high demand and offer high salaries — I ranked each skill by frequency (demand) and average salary, then combined both ranks.

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary 
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
Best of Both Worlds:
- AWS and Snowflake also perform well, showing their growing importance in the modern data stack.
- These skills offer the best return on investment for aspiring data analysts.

| Skill ID      | Skills         | Demand Count | Average Salary ($) |
|---------------|----------------|--------------|--------------------|
| 8             | go             | 27           | 115,320            |
| 234           | confluence     | 11           | 114,210            |
| 97            | hadoop         | 22           | 113,193            |
| 80            | snowflake      | 37           | 112,948            |
| 74            | azure          | 34           | 111,225            |
| 77            | bigquery       | 13           | 109,654            |
| 76            | aws            | 32           | 108,317            |
| 4             | java           | 17           | 106,906            |
| 194           | ssis           | 12           | 106,683            |
| 233           | jira           | 20           | 104,918            |

*Table of the most optimal skills for data analysts sorted by salary*

# What I Learned

This project supercharged my SQL abilities and sharpened my analytical thinking:

- **🧩 Advanced Querying:** Gained confidence in writing complex SQL queries—merging multiple tables, leveraging WITH clauses, and building reusable temp tables like a pro.

- **📊 Data Aggregation Mastery:** Used GROUP BY, COUNT(), AVG(), and other functions to transform raw data into meaningful insights.

- **💡 Real-World Problem Solving:** Learned how to approach data questions strategically, translating them into efficient, insightful queries that answer real business needs.

# Conclusion

This project not only strengthened my SQL skills but also uncovered key insights into the data analyst job market. The analysis serves as a practical guide for prioritizing skill development and job search strategies. By focusing on in-demand, high-paying skills, aspiring data analysts can better position themselves in a competitive landscape. Overall, this journey underscores the value of continuous learning and staying adaptable in the ever-evolving world of data analytics.