IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'ximinfs_ximingen2_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [ximinfs_ximingen2_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://ximinfs@ximingen2.dfs.core.windows.net', 
		TYPE = HADOOP 
	)
GO

CREATE EXTERNAL TABLE staging_rider (
	[rider_id] bigint,
	[address] nvarchar(4000),
	[firstname] nvarchar(4000),
	[lastname] nvarchar(4000),
	[birthday] varchar(50),
	[startdate] varchar(50),
	[enddate] varchar(50),
	[member] bit
	)
	WITH (
	LOCATION = 'publicrider.txt',
	DATA_SOURCE = [ximinfs_ximingen2_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.staging_rider
GO