{{ 
    config(materialized='ephemeral') 
}}

WITH
    src_data as (
SELECT
    SECURITY_CODE as SECURITY_CODE -- TEXT
    , SECURITY_NAME as SECURITY_NAME -- TEXT
    , SECTOR as SECTOR_NAME -- TEXT
    , INDUSTRY as INDUSTRY_NAME -- TEXT
    , COUNTRY as COUNTRY_CODE -- TEXT
    , EXCHANGE as EXCHANGE_CODE -- TEXT
    , LOAD_TS as LOAD_TS -- TIMESTAMP_NTZ
    , 'SEED.ABC_Bank_SECURITY_INFO' as RECORD_SOURCE
    
    FROM {{ source('seeds', 'ABC_Bank_SECURITY_INFO') }}        
), 

hashed as (
    SELECT
        {{ dbt_utils.surrogate_key([ 'SECURITY_CODE' ])}} as SECURITY_HKEY
        , {{ dbt_utils.surrogate_key([
                'SECURITY_CODE', 'SECURITY_NAME', 'SECTOR_NAME',
                'INDUSTRY_NAME', 'COUNTRY_CODE', 'EXCHANGE_CODE' ])
            }} as SECURITY_HDIFF
        , * EXCLUDE LOAD_TS
        , LOAD_TS as LOAD_TS_UTC
    FROM 
        src_data
)

SELECT * FROM hashed