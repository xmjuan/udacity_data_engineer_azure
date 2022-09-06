CREATE TABLE dim_station (
    [station_id] nvarchar(4000),
	[name] nvarchar(4000),
	[latitude] float,
	[longitude] float
)

GO

INSERT INTO dim_station (
    [station_id],
	[name],
	[latitude],
	[longitude]
)
SELECT 
    [station_id],
	[name],
	[latitude],
	[longitude]
FROM staging_station

GO

SELECT TOP 100 * FROM dim_station

