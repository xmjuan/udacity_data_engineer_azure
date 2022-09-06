CREATE TABLE fact_trip (
    [trip_id] nvarchar(4000),
	[rideable_trip] nvarchar(4000),
	[duration] bigint,
	[start_station_id] nvarchar(4000),
	[end_station_id] nvarchar(4000),
	[rider_id] bigint,
    [rider_age] bigint
	)

GO

--- create intermediate table for calculating duration and rider_age
WITH tab1 AS
(SELECT 
    [trip_id],
	[rideable_trip],
	TRY_CONVERT(datetime, [started_at]) AS [started_at],
    TRY_CONVERT(datetime, [ended_at]) AS [ended_at],
    TRY_CONVERT(date, [ended_at]) AS [ended_at_date],
    TRY_CONVERT(bigint, DATEDIFF(second,[started_at],[ended_at])) AS [duration],
	[start_station_id],
	[end_station_id],
	s.[member_id] AS [rider_id],
    DATEDIFF(month, r.[birthday], GETDATE())/12 AS [rider_age]
FROM staging_trip s
JOIN dim_rider r ON s.member_id = r.rider_id
)

--- insert from here
INSERT INTO fact_trip (
    [trip_id],
	[rideable_trip],
	[duration],
	[start_station_id],
	[end_station_id],
	[rider_id],
    [rider_age]
)
SELECT 
    [trip_id],
	[rideable_trip],
	[duration],
	[start_station_id],
	[end_station_id],
	[rider_id],
    [rider_age]
FROM tab1

GO

SELECT TOP 100 * FROM fact_trip

