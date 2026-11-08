SELECT
    impression_time,
    revenue
FROM ad_impressions
-- Highest revenue first.
-- If revenue ties, the earlier impression comes first.
ORDER BY revenue DESC, impression_time ASC
-- We only need the top 3 impressions.
LIMIT 3;
