-- part of a query repo
-- query name: latest_overall_stats
-- query link: https://dune.com/queries/3397059


SELECT
    t1.day_timestamp,
    t1.TOTAL as total_value_locked,
    t2.total as total_dot_locked,
    t2."lcdot_ldot",
    t2."lcdot_tdot",
    t2."dot_ldot",
    t2."dot_tdot",
    t2."cumulative_dot" + t2."cumulative_lcdot" + t2."cumulative_ldot" as total_dot_volume,
    t3.total_tx_count
FROM 
    query_3396975 t1 -- total value locked
JOIN 
    query_3393781 t2 -- total dot locked
ON 
    t1.day_timestamp = t2.day_timestamp 
JOIN 
    query_3397026 t3 -- transaction & users
ON 
    t1.day_timestamp = t3.day_timestamp 
ORDER BY 
    t1.day_timestamp DESC 
LIMIT 1;
