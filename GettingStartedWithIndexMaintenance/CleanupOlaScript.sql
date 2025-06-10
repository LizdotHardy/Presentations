USE msdb;
GO

-- Step 1: Drop Maintenance Jobs (based on Ola's naming convention)
--info only message -Msg 14262, Level 16, State 1, Procedure sp_verify_job_identifiers, Line 67 [Batch Start Line 2]
EXEC msdb.dbo.sp_delete_job @job_name = 'DatabaseBackup - SYSTEM_DATABASES - FULL';
EXEC msdb.dbo.sp_delete_job @job_name = 'DatabaseBackup - SYSTEM_DATABASES - DIFF';
EXEC msdb.dbo.sp_delete_job @job_name = 'DatabaseBackup - SYSTEM_DATABASES - LOG';
EXEC msdb.dbo.sp_delete_job @job_name = 'DatabaseBackup - USER_DATABASES - FULL';
EXEC msdb.dbo.sp_delete_job @job_name = 'DatabaseBackup - USER_DATABASES - DIFF';
EXEC msdb.dbo.sp_delete_job @job_name = 'DatabaseBackup - USER_DATABASES - LOG';
EXEC msdb.dbo.sp_delete_job @job_name = 'DatabaseIntegrityCheck - SYSTEM_DATABASES';
EXEC msdb.dbo.sp_delete_job @job_name = 'DatabaseIntegrityCheck - USER_DATABASES';
EXEC msdb.dbo.sp_delete_job @job_name = 'IndexOptimize - SYSTEM_DATABASES';
EXEC msdb.dbo.sp_delete_job @job_name = 'IndexOptimize - USER_DATABASES';
EXEC msdb.dbo.sp_delete_job @job_name = 'CommandLog Cleanup';
EXEC msdb.dbo.sp_delete_job @job_name = 'sp_delete_backuphistory';
EXEC msdb.dbo.sp_delete_job @job_name = 'sp_purge_jobhistory';
EXEC msdb.dbo.sp_delete_job @job_name = 'Output File Cleanup';
GO

-- Step 2: Drop Stored Procedures (based on Ola's maintenance script)
USE DBA;
GO

DROP PROCEDURE IF EXISTS dbo.CommandExecute
DROP PROCEDURE IF EXISTS dbo.DatabaseBackup
DROP PROCEDURE IF EXISTS dbo.DatabaseIntegrityCheck
DROP PROCEDURE IF EXISTS dbo.IndexOptimize
GO


-- Step 3: Drop the CommandLog table (if it exists)
USE DBA;
GO

DROP TABLE IF EXISTS dbo.CommandLog;
GO

PRINT 'Ola Hallengren Maintenance Solution has been successfully removed.';
GO
