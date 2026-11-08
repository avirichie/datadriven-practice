select region,min(amount)
  from cloud_costs
  group by 1
  order by 1
