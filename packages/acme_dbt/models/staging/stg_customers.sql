with 

    raw_customers as (
        select * from {{ ref('raw_customers') }}
    )

,   final as (
        select
            id as customer_id
        ,   first_name
        ,   last_name
        ,   {{ dbt.concat(["first_name"," ","last_name"]) }} as full_name
        ,   {{ dbt_utils.generate_surrogate_key(['id']) }}   
        from source
    )

select * from final
