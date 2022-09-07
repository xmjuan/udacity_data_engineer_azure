CREATE TABLE fact_payment (
    [payment_id] bigint,
	[payment_date] date,
	[amount] float,
	[rider_id] bigint,
    CONSTRAINT PK_fact_payment_payment_id PRIMARY KEY NONCLUSTERED ([payment_id]) NOT ENFORCED
)

GO

INSERT INTO fact_payment (
    [payment_id],
	[payment_date],
	[amount],
	[rider_id]
)
SELECT 
    [payment_id],
	TRY_CONVERT(date, LEFT([payment_date],10)) AS [payment_date],
	[amount],
	[rider_id]
FROM staging_payment

GO

SELECT TOP 100 * FROM fact_payment

SELECT MIN([payment_date]), MAX([payment_date]) FROM dbo.fact_payment