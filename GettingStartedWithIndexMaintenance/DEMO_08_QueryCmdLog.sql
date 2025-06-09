/***** DEMO 8 *****/


/*********************************************************************************************************

Using the Command Log - great tool for troubleshooting errors in maintenance and checking results/timings

**********************************************************************************************************/


USE DBA;
GO

 --check for error messages

  SELECT * 
  FROM DBA.dbo.CommandLog
  WHERE ErrorMessage IS NOT NULL


--see when Statistics are updated (ensure stats job has run first)

  SELECT * 
  FROM [DBA].[dbo].[CommandLog]
   WHERE StartTime > GETDATE()-1
    AND CommandTYPE LIKE '%UPDATE%STATISTICS%'
  ORDER BY Databasename, StartTime

  
 --see what was updated - Look for REORG and REBUILDs (blank for this demo)

 SELECT * 
 FROM [DBA].[dbo].[CommandLog]
  WHERE StartTime > '2025-06-01'
   AND CommandType = 'ALTER_INDEX'
 ORDER BY Databasename, StartTime


 --see what was updated - check for REORG only (blank for this demo)

 SELECT * 
 FROM [DBA].[dbo].[CommandLog]
  WHERE StartTime > '2025-06-01'
   AND CommandType = 'ALTER_INDEX'
   AND Command LIKE 'ALTER INDEX%REORGANIZE%'
 ORDER BY Databasename, StartTime


--see what was updated - check for REBUILD only (blank for this demo)

 SELECT * 
 FROM [DBA].[dbo].[CommandLog]
  WHERE StartTime > '2025-06-01'
   AND CommandType = 'ALTER_INDEX'
   AND Command LIKE 'ALTER INDEX%REBUILD%'
 ORDER BY Databasename, StartTime