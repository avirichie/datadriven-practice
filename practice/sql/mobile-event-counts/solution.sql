select event_type,count(event_id) event_count
  from event_data
  where 1=1
  and coalesce(tags,'missing') ilike '%mobile%'
  group by 1
