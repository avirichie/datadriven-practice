with user_category as (
select p.category
  ,t.user_id
  ,count(*) as total_transactions
  ,sum(t.total_amount) as total_sale
  ,sum(t.total_amount)/count(*) as avg_basket_size
  from products p
  join transactions t  on p.product_id = t.product_id
  group by 1,2
)
  , user_tiers as (
  select *
  , case when avg_basket_size > 500 then 'High'
          when avg_basket_size >= 200 and avg_basket_size <= 500 then 'Medium'
          else 'Low'
         end as segment
  from user_category 
)
  select category
    ,segment
    ,count(*) unique_users
    ,sum(total_transactions) total_transactions
    ,round(sum(total_sale),3) as total_sales
    ,round(avg(avg_basket_size),3) as avg_basket_size  
    from user_tiers
    group by 1,2
    order by 1,2
