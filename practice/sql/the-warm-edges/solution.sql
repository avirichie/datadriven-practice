WITH valid_edge_locations AS (
    SELECT DISTINCT edge_loc
    FROM cdn_logs
    WHERE req_path LIKE '%api%'
      AND cache_hit = 1
)
SELECT
    c.edge_loc,
    c.req_path,
    SUM(c.bytes) AS total_bytes
FROM cdn_logs c
JOIN valid_edge_locations v
    ON c.edge_loc = v.edge_loc
WHERE c.req_path LIKE '%api%'
GROUP BY
    c.edge_loc,
    c.req_path
ORDER BY total_bytes ASC;
