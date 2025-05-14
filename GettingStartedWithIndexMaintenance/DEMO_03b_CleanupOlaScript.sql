USE msdb;
GO

-- Step 1: Drop Maintenance Jobs (based on Ola's naming convention)
DECLARE @job_name NVARCHAR(128);

DECLARE job_cursor CURSOR FOR
SELECT name 
FROM msdb.dbo.sysjobs
WHERE name IN (
    'DatabaseBackup - SYSTEM_DATABASES - FULL',
    'DatabaseBackup - SYSTEM_DATABASES - DIFF',
    'DatabaseBackup - SYSTEM_DATABASES - LOG',
    'DatabaseBackup - USER_DATABASES - FULL',
    'DatabaseBackup - USER_DATABASES - DIFF',
    'DatabaseBackup - USER_DATABASES - LOG',
    'DatabaseIntegrityCheck - SYSTEM_DATABASES',
    'DatabaseIntegrityCheck - USER_DATABASES',
    'IndexOptimize - SYSTEM_DATABASES',
    'IndexOptimize - USER_DATABASES',
    'CommandLog Cleanup',
    'sp_delete_backuphistory',
    'sp_purge_jobhistory'
);

OPEN job_cursor;
FETCH NEXT FROM job_cursor INTO @job_name;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping job: ' + @job_name;
    EXEC msdb.dbo.sp_delete_job @job_name = @job_name;
    FETCH NEXT FROM job_cursor INTO @job_name;
END

CLOSE job_cursor;
DEALLOCATE job_cursor;
GO

-- Step 2: Drop Stored Procedures (based on Ola's maintenance script)
USE DBA;
GO

DECLARE @proc_name NVARCHAR(128);
DECLARE proc_cursor CURSOR FOR
SELECT name 
FROM sys.procedures 
WHERE name IN (
    'CommandExecute',
    'DatabaseBackup',
    'DatabaseIntegrityCheck',
    'IndexOptimize'
);

OPEN proc_cursor;
FETCH NEXT FROM proc_cursor INTO @proc_name;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Dropping procedure: ' + @proc_name;
    EXEC('DROP PROCEDURE IF EXISTS dbo.' + @proc_name);
    FETCH NEXT FROM proc_cursor INTO @proc_name;
END

CLOSE proc_cursor;
DEALLOCATE proc_cursor;
GO

-- Step 3: Drop the CommandLog table (if it exists)
USE DBA;
GO

IF OBJECT_ID('dbo.CommandLog', 'U') IS NOT NULL
BEGIN
    PRINT 'Dropping CommandLog table';
    DROP TABLE dbo.CommandLog;
END
GO

-- Step 4: Remove Maintenance Job Schedules and Job Steps (double check)
SELECT * FROM msdb.dbo.sysjobschedules 
WHERE job_id IN (SELECT job_id FROM msdb.dbo.sysjobs WHERE name LIKE 'DatabaseBackup - %' OR name LIKE 'DatabaseIntegrityCheck - %' OR name LIKE 'IndexOptimize - %');
GO

--DELETE FROM msdb.dbo.sysjobschedules 
--WHERE job_id IN (SELECT job_id FROM msdb.dbo.sysjobs WHERE name LIKE 'DatabaseBackup - %' OR name LIKE 'DatabaseIntegrityCheck - %' OR name LIKE 'IndexOptimize - %');
--GO


PRINT 'Ola Hallengren Maintenance Solution has been successfully removed.';
GO
