/*
Find job postings from the first querter that have a salary greater than $70K
Combine job posting tables from the first qurter of 2023
Gets job postings with an average yearly salary > $70000
*/

SELECT
    q1_job_postings.job_title_short,
    q1_job_postings.job_location,
    q1_job_postings.job_via,
    q1_job_postings.job_posted_date::date,
    q1_job_postings.salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS q1_job_postings
WHERE
    salary_year_avg > 70000
    AND
    q1_job_postings.job_title_short = 'Data Analyst'
ORDER BY q1_job_postings.salary_year_avg DESC
