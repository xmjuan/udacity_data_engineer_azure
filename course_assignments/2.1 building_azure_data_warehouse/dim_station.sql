CREATE TABLE dim_station (
    [station_id] nvarchar(4000) NOT NULL,
	[name] nvarchar(4000),
	[latitude] float,
	[longitude] float,
    CONSTRAINT PK_dim_station_station_id PRIMARY KEY NONCLUSTERED (station_id) NOT ENFORCED
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
