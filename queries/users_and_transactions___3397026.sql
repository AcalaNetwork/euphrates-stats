-- part of a query repo
-- query name: users_and_transactions
-- query link: https://dune.com/queries/3397026


SELECT 
    eds."day_timestamp",
    eds."daily_tx_count",
    SUM(eds."daily_tx_count") OVER (ORDER BY eds."day_timestamp" ASC) AS "total_tx_count",
    eds."daily_users",
    SUM(eds."daily_users") OVER (ORDER BY eds."day_timestamp" ASC) AS "cumulative_users"
FROM dune.euphrates.result_euphrates_daily_stake AS eds
ORDER BY eds."day_timestamp" ASC
LIMIT 1000