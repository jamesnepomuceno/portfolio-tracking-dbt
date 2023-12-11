WITH
    current_from_snapshot as (
        SELECT *
        FROM {{ ref('SNSH_ABC_BANK_SECURITY_INFO') }}
        WHERE DBT_VALID_TO is null
    )
SELECT *
    FROM current_from_snapshot