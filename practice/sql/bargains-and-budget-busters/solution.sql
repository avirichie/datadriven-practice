WITH unioned_base AS (
  SELECT svc_name,region,amount
  FROM cloud_costs
  UNION
  SELECT svc_name,region,amount
  FROM cost_allocs
)
 ,cost_rankings AS (
  SELECT
    svc_name,
    region,
    ROW_NUMBER() OVER (
      PARTITION BY region
      ORDER BY amount DESC,svc_name
    ) AS max_rank,
    ROW_NUMBER() OVER (
      PARTITION BY region
      ORDER BY amount,svc_name
    ) AS min_rank
  FROM unioned_base
)

SELECT region
  ,max(case when max_rank = 1 then svc_name end) as most_expensive
  ,max(case when min_rank = 1 then svc_name end) as cheapest
FROM cost_rankings
group by 1
