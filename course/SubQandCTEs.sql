-- Subqueries and CTEs (Common Table Expressions)

SELECT *
FROM(
    SELECT *
    FROM job_postings_fact
    WHERE job_posted_date BETWEEN '2023-01-01' AND '2023-02-01'
) AS january_jobs;


SELECT *
FROM january_jobs;


SELECT
    company_id,
    company_dim.name AS company_name
FROM
    company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = TRUE
    ORDER BY
        company_id
)



-- CTEs
WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
    total_jobs DESC




-- identify the top 5 skills that are most frequently mentioned in job postings. Use a subquery to find the skill IDs with the highest counts in the skills_job_dim table and then join this result with the skills_dim table to get the skill names.

SELECT
    skills,
    skill_id
FROM skills_dim
WHERE skill_id IN (
    SELECT
        skill_id
    FROM
        skills_job_dim
    GROUP BY
        skill_id
    ORDER BY
        COUNT(skill_id) DESC
    LIMIT 5
)

-- Determine the size category ('Small', 'Medium', or 'Large') for each company by first identifying the number of job postings they have. Use a subquery to calculate the total job postings per company. A company is considered 'Small' if it has less than 10 job postings, 'Medium' if the number of job postings is between 10 and 50, and 'Large' if it has more than 50 job postings. Implement a subquery to aggregate job counts per company before classifying them based on size.


WITH company_size AS (
    SELECT
        company_id,
        CASE
            WHEN COUNT(company_id) < 10 THEN 'Small'
            WHEN COUNT(company_id) BETWEEN 10 AND 50 THEN 'Medium'
            ELSE 'Large'
        END AS category
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT
    company_dim.name AS company_name,
    company_size.category
FROM
    company_dim
LEFT JOIN company_size ON company_size.company_id = company_dim.company_id
ORDER BY
    category


-- Practice - 7
/*
Find the count of the number of remote job postings per skill
    - Display the top 5 skills by their demand in remote jpbs
    - Include skill ID, name, nad count of postings requiring the skill.
*/

-- my answer

WITH remote_skills AS (
    SELECT
        job_id
    FROM
        job_postings_fact
    WHERE
        job_work_from_home = TRUE
)


SELECT
    skills_dim.skills,
    COUNT(skills_job_dim.skill_id) AS remote_skill_count
FROM
    skills_job_dim
LEFT JOIN
    skills_dim
    ON
    skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_id IN (
        SELECT
            job_id
        FROM
            remote_skills
    )
GROUP BY
    skills_dim.skills
ORDER BY
    remote_skill_count DESC
LIMIT 5


-- GPT answer
SELECT
    sd.skills,
    COUNT(sjd.skill_id) AS remote_skill_count
FROM
    skills_job_dim sjd
JOIN
    job_postings_fact jpf ON sjd.job_id = jpf.job_id
LEFT JOIN
    skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_work_from_home = TRUE
GROUP BY
    sd.skills
ORDER BY
    remote_skill_count DESC
LIMIT 5


-- course answer
WITH remote_job_skills AS (
    SELECT
        skills_to_job.skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings
        ON skills_to_job.job_id = job_postings.job_id
    WHERE
        job_postings.job_work_from_home = TRUE
    GROUP BY
        skills_to_job.skill_id
)

SELECT
    skills_dim.skills AS skill_name,
    skill_count
FROM
    remote_job_skills
JOIN
    skills_dim
    ON
    remote_job_skills.skill_id = skills_dim.skill_id
ORDER BY
    skill_count DESC
LIMIT 5