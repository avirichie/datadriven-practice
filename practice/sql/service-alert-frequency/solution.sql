with alert_base as (
select svc_name
  ,count(alert_id) occurrence_count
from alert_events
group by 1
)
select svc_name   
  , occurrence_count
  , dense_rank() over (order by occurrence_count desc) rnk
from alert_base
