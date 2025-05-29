/****** DEMO 2 ******/

USE WideWorldImporters;
GO


/*

Find external fragmentation

*/

SELECT S.name as 'Schema',
       T.name as 'Table',
       I.name as 'Index',
       DDIPS.avg_fragmentation_in_percent,
       DDIPS.page_count
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS DDIPS
INNER JOIN sys.tables T on T.object_id = DDIPS.object_id
INNER JOIN sys.schemas S on T.schema_id = S.schema_id
INNER JOIN sys.indexes I ON I.object_id = DDIPS.object_id
AND DDIPS.index_id = I.index_id
WHERE DDIPS.database_id = DB_ID()
AND I.name IS NOT NULL
--AND DDIPS.page_count > 1000
AND DDIPS.avg_fragmentation_in_percent > 50 --(if running this before and after - do this twice in the script before/after)
ORDER BY DDIPS.avg_fragmentation_in_percent DESC;


/*

Find Internal fragmentation - Check page fullness/density

NOTE - you need to change last parameter to DETAILED to show page density

*/


SELECT S.name as 'Schema',
       T.name as 'Table',
       I.name as 'Index',
       DDIPS.avg_page_space_used_in_percent,
       DDIPS.page_count
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, 'DETAILED') AS DDIPS
INNER JOIN sys.tables T on T.object_id = DDIPS.object_id
INNER JOIN sys.schemas S on T.schema_id = S.schema_id
INNER JOIN sys.indexes I ON I.object_id = DDIPS.object_id
AND DDIPS.index_id = I.index_id
WHERE DDIPS.database_id = DB_ID()
AND I.name IS NOT NULL
AND DDIPS.page_count > 1000
ORDER BY DDIPS.avg_page_space_used_in_percent;






/*

Density and fragmentation (external and internal)

*/
SELECT OBJECT_SCHEMA_NAME(ips.object_id) AS schema_name,  
       OBJECT_NAME(ips.object_id) AS object_name,
       i.name AS index_name,  
       i.type_desc AS index_type,  
       ips.avg_page_space_used_in_percent,  
       ips.avg_fragmentation_in_percent,  
       ips.page_count,  
	   i.fill_factor
FROM sys.dm_db_index_physical_stats(DB_ID(), default, default, default, 'DETAILED') AS ips  
INNER JOIN sys.indexes AS i  
ON ips.object_id = i.object_id  
   AND  
   ips.index_id = i.index_id  
INNER JOIN sys.objects AS o WITH (NOLOCK)
on o.[object_id] = i.[object_id]
INNER JOIN sys.dm_db_partition_stats AS st WITH (NOLOCK)
ON o.[object_id] = st.[object_id]
AND i.[index_id] = st.[index_id]
WHERE ips.page_count >= 1000 --default on Ola scripts
ORDER BY avg_page_space_used_in_percent DESC ;  
GO

