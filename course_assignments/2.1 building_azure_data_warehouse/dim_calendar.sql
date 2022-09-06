
--- used method from https://datasavvy.me/2016/08/06/create-a-date-dimension-in-azure-sql-data-warehouse/

DECLARE @StartDate DATE = '20100101', @NumberOfYears INT = 30;

--- prevent set or regional settings from interfering with 
--- interpretation of dates / literals

CREATE TABLE dim_calendar (
    [date] date,  
    [month] int,
    [quarter] int,
    [year] int
);

SET DATEFIRST 7;
SET DATEFORMAT mdy;
SET LANGUAGE US_ENGLISH;

DECLARE @CutoffDate DATE = DATEADD(YEAR, @NumberOfYears, @StartDate);

--- create dates based on sys
INSERT dim_calendar([date]) 
SELECT d
FROM
(
SELECT d = DATEADD(DAY, rn-1, @StartDate)
FROM
    (
    SELECT TOP (DATEDIFF(DAY, @StartDate, @CutoffDate)) 
    rn = ROW_NUMBER() OVER (ORDER BY s1.[object_id])
    FROM sys.all_objects AS s1
    CROSS JOIN sys.all_objects AS s2
    ORDER BY s1.[object_id]
    ) AS x
) AS y
GO

--- update table with other needed columns
UPDATE dim_calendar 
set 
  [month]      = DATEPART(MONTH,    [date]),
  [quarter]    = DATEPART(QUARTER,  [date]),
  [year]       = DATEPART(YEAR,     [date])

SELECT TOP 10 * FROM dim_calendar ORDER BY [date] DESC