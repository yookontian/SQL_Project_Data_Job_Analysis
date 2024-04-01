SELECT
    id_to_company.name
FROM
    job_postings_fact
LEFT JOIN
    company_dim AS id_to_company
    ON
    job_postings_fact.company_id = id_to_company.company_id
WHERE
    job_health_insurance is TRUE
    AND
    job_posted_date BETWEEN '2023-04-01' AND '2023-06-30'

GROUP BY
    id_to_company.name;
    


CREATE TABLE january_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE job_posted_date BETWEEN '2023-01-01' AND '2023-02-01';

CREATE TABLE february_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE job_posted_date BETWEEN '2023-02-01' AND '2023-03-01';

CREATE TABLE march_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE job_posted_date BETWEEN '2023-03-01' AND '2023-04-01';

SELECT job_posted_date
FROM march_jobs;

SELECT * FROM job_postings_fact
LIMIT 5;

SELECT
    MIN(salary_year_avg) AS min_salary,
    MAX(salary_year_avg) AS max_salary,
    AVG(salary_year_avg) AS avg_salary

FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    AND
    salary_year_avg IS NOT NULL


SELECT
    job_id,
    salary_year_avg,
    CASE
        WHEN salary_year_avg <= 54438 THEN 'Low'
        WHEN salary_year_avg <= 366938 THEN 'Medium'
        ELSE 'High'
    END AS salary_range
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    AND
    salary_year_avg IS NOT NULL
GROUP BY job_id
ORDER BY
    salary_year_avg DESC;
