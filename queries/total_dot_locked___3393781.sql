-- part of a query repo
-- query name: total_dot_locked
-- query link: https://dune.com/queries/3393781


SELECT
    dot_tvl."day_timestamp",
    dot_tvl."lcdot_ldot",
    dot_tvl."lcdot_tdot",
    dot_tvl."dot_ldot",
    dot_tvl."dot_tdot",
    dot_tvl."dot_starlay",
    dot_tvl."ldot_starlay",
    dot_tvl."total",
    dot_tvl."lcdot_ldot" + dot_tvl."lcdot_tdot" AS "lcdot",
    dot_tvl."dot_ldot" + dot_tvl."dot_tdot" + dot_tvl."dot_starlay" AS "dot",
    dot_tvl."ldot_starlay" AS "ldot",
    dot_tvl."lcdot_ldot_volume" + dot_tvl."lcdot_tdot_volume" AS "cumulative_lcdot",
    dot_tvl."dot_ldot_volume" + dot_tvl."dot_tdot_volume" + dot_tvl."dot_idot_volume" AS "cumulative_dot",
    dot_tvl."ldot_starlay" AS "cumulative_ldot"
from (
    SELECT
        eds."day_timestamp",
        SUM((eds."stake_pool_0" - eds."unstake_pool_0")) OVER (ORDER BY eds."day_timestamp" ASC) / 1e10 AS "lcdot_ldot",
        SUM((eds."stake_pool_1" - eds."unstake_pool_1")) OVER (ORDER BY eds."day_timestamp" ASC) / 1e10 AS "lcdot_tdot",
        SUM((eds."stake_pool_2" - eds."unstake_pool_2")) OVER (ORDER BY eds."day_timestamp" ASC) / 1e10 AS "dot_ldot",
        SUM((eds."stake_pool_3" - eds."unstake_pool_3")) OVER (ORDER BY eds."day_timestamp" ASC) / 1e10 AS "dot_tdot",
        SUM((eds."stake_pool_4" - eds."unstake_pool_4")) OVER (ORDER BY eds."day_timestamp" ASC) / 1e10 AS "dot_starlay",
        SUM((eds."stake_pool_5" - eds."unstake_pool_5")) OVER (ORDER BY eds."day_timestamp" ASC) / 1e10 AS "ldot_starlay",

        SUM((eds."stake_pool_0")) OVER (ORDER BY eds."day_timestamp" ASC) / 1e10 AS "lcdot_ldot_volume",
        SUM((eds."stake_pool_1")) OVER (ORDER BY eds."day_timestamp" ASC) / 1e10 AS "lcdot_tdot_volume",
        SUM((eds."stake_pool_2")) OVER (ORDER BY eds."day_timestamp" ASC) / 1e10 AS "dot_ldot_volume",
        SUM((eds."stake_pool_3")) OVER (ORDER BY eds."day_timestamp" ASC) / 1e10 AS "dot_tdot_volume",
        SUM((eds."stake_pool_4")) OVER (ORDER BY eds."day_timestamp" ASC) / 1e10 AS "dot_idot_volume",
        SUM((eds."stake_pool_5")) OVER (ORDER BY eds."day_timestamp" ASC) / 1e10 AS "ldot_ildot_volume",
        SUM(eds."net_stake") OVER (ORDER BY eds."day_timestamp" ASC) / 1e10 AS "total"
    FROM dune.euphrates.result_euphrates_daily_stake AS eds
    ORDER BY eds."day_timestamp" ASC
) as dot_tvl
LIMIT 1000