/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions.
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and helps identify the most financially rewarding skills to acquire or improve.

*/

SELECT
    skills_dim.skills,
    skills_dim.type,
    ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS avg_salary
FROM job_postings_fact
JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_location = 'Anywhere' AND
    job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.job_title_short = 'Data Analyst'
GROUP BY
    skills_dim.skills,
    skills_dim.type
ORDER BY
    avg_salary DESC
LIMIT 25

/*
Results:
[
  {
    "skills": "pyspark",
    "type": "libraries",
    "avg_salary": "208172.25"
  },
  {
    "skills": "bitbucket",
    "type": "other",
    "avg_salary": "189154.50"
  },
  {
    "skills": "couchbase",
    "type": "databases",
    "avg_salary": "160515.00"
  },
  {
    "skills": "watson",
    "type": "cloud",
    "avg_salary": "160515.00"
  },
  {
    "skills": "datarobot",
    "type": "analyst_tools",
    "avg_salary": "155485.50"
  },
  {
    "skills": "gitlab",
    "type": "other",
    "avg_salary": "154500.00"
  },
  {
    "skills": "swift",
    "type": "programming",
    "avg_salary": "153750.00"
  },
  {
    "skills": "jupyter",
    "type": "libraries",
    "avg_salary": "152776.50"
  },
  {
    "skills": "pandas",
    "type": "libraries",
    "avg_salary": "151821.33"
  },
  {
    "skills": "elasticsearch",
    "type": "databases",
    "avg_salary": "145000.00"
  },
  {
    "skills": "golang",
    "type": "programming",
    "avg_salary": "145000.00"
  },
  {
    "skills": "numpy",
    "type": "libraries",
    "avg_salary": "143512.50"
  },
  {
    "skills": "databricks",
    "type": "cloud",
    "avg_salary": "141906.60"
  },
  {
    "skills": "linux",
    "type": "os",
    "avg_salary": "136507.50"
  },
  {
    "skills": "kubernetes",
    "type": "other",
    "avg_salary": "132500.00"
  },
  {
    "skills": "atlassian",
    "type": "other",
    "avg_salary": "131161.80"
  },
  {
    "skills": "twilio",
    "type": "sync",
    "avg_salary": "127000.00"
  },
  {
    "skills": "airflow",
    "type": "libraries",
    "avg_salary": "126103.00"
  },
  {
    "skills": "scikit-learn",
    "type": "libraries",
    "avg_salary": "125781.25"
  },
  {
    "skills": "jenkins",
    "type": "other",
    "avg_salary": "125436.33"
  },
  {
    "skills": "notion",
    "type": "async",
    "avg_salary": "125000.00"
  },
  {
    "skills": "scala",
    "type": "programming",
    "avg_salary": "124903.00"
  },
  {
    "skills": "postgresql",
    "type": "databases",
    "avg_salary": "123878.75"
  },
  {
    "skills": "gcp",
    "type": "cloud",
    "avg_salary": "122500.00"
  },
  {
    "skills": "microstrategy",
    "type": "analyst_tools",
    "avg_salary": "121619.25"
  }
]
*/