{{ config(materialized='view') }}

SELECT
  application_id,
  job_id,
  customer,
  created_at,
  JSON_VALUE(raw_data, '$.email') AS email,
  JSON_VALUE(raw_data, '$.first_name') AS first_name,
  JSON_VALUE(raw_data, '$.last_name') AS last_name,
  JSON_VALUE(raw_data, '$.status') AS status,
  JSON_VALUE(raw_data, '$.source.type') AS source
FROM {{ source('emply_dw', 'applications_raw') }}
