{{ config(materialized='view') }}

SELECT
  job_id,
  vacancy_id,
  customer,
  media_id,
  created_at,
  JSON_VALUE(raw_data, '$.title.localization[0].value') AS title,
  JSON_VALUE(raw_data, '$.content.localization[0].value') AS content,
  JSON_VALUE(raw_data, '$.time_zone') AS time_zone,
  JSON_VALUE(raw_data, '$.stage') AS stage
FROM {{ source('emply_dw', 'postings_raw') }}
