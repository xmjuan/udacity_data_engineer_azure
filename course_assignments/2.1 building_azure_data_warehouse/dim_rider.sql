CREATE TABLE dim_rider (
    [rider_id] bigint NOT NULL,
	[address] nvarchar(4000),
	[firstname] nvarchar(4000),
	[lastname] nvarchar(4000),
	[birthday] date,
	[startdate] date,
	[enddate] date,
	[member] bit,
    CONSTRAINT PK_dim_rider_rider_id PRIMARY KEY NONCLUSTERED (rider_id) NOT ENFORCED
)

GO

INSERT INTO dim_rider (
    [rider_id],
	[address],
	[firstname],
	[lastname],
	[birthday],
	[startdate],
	[enddate],
	[member]  
)
SELECT 
    [rider_id],
	[address],
	[firstname],
	[lastname],
	TRY_CONVERT(date, LEFT([birthday],10)) AS [birthday],
	TRY_CONVERT(date, LEFT([startdate],10)) AS [startdate],
	TRY_CONVERT(date, LEFT([enddate],10)) AS [enddate],
	[member]
FROM staging_rider

GO

SELECT TOP 100 * FROM dim_rider


SELECT MIN([startdate]), MAX([startdate]) FROM dim_rider