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
      ORDER BY amount DESC
    ) AS max_rank,
    ROW_NUMBER() OVER (
      PARTITION BY region
      ORDER BY amount
    ) AS min_rank
  FROM unioned_base
)

,expensive AS (
  SELECT
    region,
    svc_name AS most_expensive
  FROM cost_rankings
  WHERE 1 = 1
    AND max_rank = 1
),
cheapest AS (
  SELECT
    region,
    svc_name AS cheapest
  FROM cost_rankings
  WHERE 1 = 1
    AND min_rank = 1
)

SELECT
  cheapest.region,
  most_expensive,
  cheapest
FROM expensive
JOIN cheapest
  ON expensive.region = cheapest.region
