select consumer
  ,count(msg_id) deliveries
  ,count(distinct case when part_key is not null then part_key end) unique_events
  from stream_msgs
  where 1=1
  and consumer is not null
  group by 1
