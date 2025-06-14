DECLARE @DatabaseID int

SET @DatabaseID = DB_ID()

SELECT DB_NAME(@DatabaseID) AS DatabaseName,
       schemas.[name] AS SchemaName,
       objects.[name] AS ObjectName,
       indexes.[name] AS IndexName,
       objects.type_desc AS ObjectType,
       indexes.type_desc AS IndexType,
       indexes.fill_factor AS [FillFactor],
       dm_db_index_physical_stats.partition_number AS PartitionNumber,
       dm_db_index_physical_stats.page_count AS [PageCount],
       dm_db_index_physical_stats.avg_fragmentation_in_percent AS AvgFragmentationInPercent,
       dm_db_index_physical_stats.avg_page_space_used_in_percent AS PageDensity
FROM sys.dm_db_index_physical_stats (@DatabaseID, NULL, NULL, NULL, 'DETAILED') dm_db_index_physical_stats
INNER JOIN sys.indexes indexes ON dm_db_index_physical_stats.[object_id] = indexes.[object_id] AND dm_db_index_physical_stats.index_id = indexes.index_id
INNER JOIN sys.objects objects ON indexes.[object_id] = objects.[object_id]
INNER JOIN sys.schemas schemas ON objects.[schema_id] = schemas.[schema_id]
WHERE objects.[type] IN('U','V')
AND objects.is_ms_shipped = 0
AND indexes.[type] IN(1,2,3,4)
AND indexes.is_disabled = 0
AND indexes.is_hypothetical = 0
AND dm_db_index_physical_stats.alloc_unit_type_desc = 'IN_ROW_DATA'
AND dm_db_index_physical_stats.index_level = 0
AND dm_db_index_physical_stats.page_count >= 1000