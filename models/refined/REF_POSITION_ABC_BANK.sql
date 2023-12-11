WITH
current_from_snapshot as (
    -- Removed to use MACROS
    -- SELECT *
    -- FROM {{ ref('SNSH_ABC_BANK_POSITION') }}
    -- WHERE DBT_VALID_TO is null

    -- That's the MACRO
    {{
        current_from_snapshot(
            snsh_ref=ref('SNSH_ABC_BANK_POSITION'),
            output_load_ts = false
        )
    }}
)

select 
    *
    , POSITION_VALUE - COST_BASE as UNREALIZED_PROFIT
    , ROUND(UNREALIZED_PROFIT / COST_BASE, 5) as UNREALIZED_PROFIT_PCT
from current_from_snapshot