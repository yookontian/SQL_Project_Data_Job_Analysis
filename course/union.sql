-- union: remove duplicate rows, must have the same number of columns and similar data types

SELECT *
FROM january_jobs

SELECT *
FROM february_jobs

SELECT *
FROM march_jobs

-- UNION: combines results from two or more SELECT statements, removing duplicates
SELECT
    job_title_short,
    company_id,
    job_location
FROM january_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM february_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM march_jobs

-- UNION ALL: combines results from two or more SELECT statements, including duplicates

SELECT
    job_title_short,
    company_id,
    job_location
FROM january_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM february_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM march_jobs


-- practice 1
-- Get the corresponding skill and skill type for each job posting in q1, 
-- includes those without any skills, too
-- salary > 70000


SELECT
    january_jobs.job_id,
    skills_job_dim.skill_id,
    skills_dim.skills,
    skills_dim.type
FROM january_jobs
LEFT JOIN
    skills_job_dim ON january_jobs.job_id = skills_job_dim.job_id
LEFT JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    january_jobs.salary_year_avg > 70000

UNION

SELECT
    february_jobs.job_id,
    skills_job_dim.skill_id,
    skills_dim.skills,
    skills_dim.type
FROM february_jobs
LEFT JOIN
    skills_job_dim ON february_jobs.job_id = skills_job_dim.job_id
LEFT JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    february_jobs.salary_year_avg > 70000

UNION

SELECT
    march_jobs.job_id,
    skills_job_dim.skill_id,
    skills_dim.skills,
    skills_dim.type
FROM march_jobs
LEFT JOIN
    skills_job_dim ON march_jobs.job_id = skills_job_dim.job_id
LEFT JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    march_jobs.salary_year_avg > 70000

-- concise version
SELECT
    q1_job_postings.job_id,
    skills_job_dim.skill_id,
    skills_dim.skills,
    skills_dim.type
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
)   AS q1_job_postings
LEFT JOIN
    skills_job_dim ON q1_job_postings.job_id = skills_job_dim.job_id
LEFT JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    q1_job_postings.salary_year_avg > 70000
