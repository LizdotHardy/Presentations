USE DBA;
GO

 --check for error messages

  SELECT * 
  FROM DBA.dbo.CommandLog
  WHERE ErrorMessage IS NOT NULL

  --see what was updated - Look for REORG and REBUILDs

  SELECT * 
  FROM [DBA].[dbo].[CommandLog]
   WHERE StartTime > '2025-05-22 23:59:59'
    AND CommandType = 'ALTER_INDEX'
  ORDER BY databasename, StartTime

  --see what was updated - check for REORG only

  SELECT * 
  FROM [DBA].[dbo].[CommandLog]
   WHERE StartTime > '2025-05-22 23:59:59'
    AND CommandType = 'ALTER_INDEX'
    AND Command LIKE 'ALTER INDEX%REORGANIZE%'
  ORDER BY databasename, StartTime

--see what was updated - check for REBUILD only

  SELECT * 
  FROM [DBA].[dbo].[CommandLog]
   WHERE StartTime > '2025-05-09 23:59:59'
    AND CommandType = 'ALTER_INDEX'
    AND Command LIKE 'ALTER INDEX%REBUILD%'
  ORDER BY databasename, StartTime

--see when Statistics are updated

  SELECT * 
  FROM [DBA].[dbo].[CommandLog]
   WHERE StartTime > GETDATE()-1
    AND CommandTYPE LIKE '%UPDATE%STATISTICS%'
  ORDER BY databasename, StartTime
