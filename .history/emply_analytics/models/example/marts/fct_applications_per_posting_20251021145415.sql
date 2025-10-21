{{ config(materialized='table') }}

SELECT
  p.customer,
  CAST(p.job_id AS STRING) AS job_id,
  p.vacancy_id,
  p.title,
  COUNT(a.application_id) AS total_applications,
  COUNTIF(CAST(a.status AS INT64) = 1) AS active_applications,
  MIN(a.created_at) AS first_application_date,
  MAX(a.created_at) AS last_application_date
FROM {{ ref('stg_postings') }} AS p
LEFT JOIN {{ ref('stg_applications') }} AS a
  ON CAST(p.job_id AS STRING) = CAST(a.job_id AS STRING)
GROUP BY 1,2,3,4
