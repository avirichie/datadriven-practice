select session_id,user_id,session_duration_sec
  from user_sessions
  where 1=1
  and session_duration_sec < 100
  and YEAR(session_start) = 2026
