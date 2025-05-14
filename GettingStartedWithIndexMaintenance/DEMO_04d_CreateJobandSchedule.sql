USE msdb;
GO

-- Add the job
EXEC sp_add_job 
    @job_name = N'IndexOptimize - USER_DATABASES';

-- Add a step to the job
EXEC sp_add_jobstep 
    @job_name = N'IndexOptimize - USER_DATABASES',
    @step_name = N'Run Index Maintenance',
    @subsystem = N'TSQL',
    @command = N'EXEC dbo.IndexOptimize 
                @Databases = ''USER_DATABASES'',
                @LogToTable = ''Y'';';

-- Add the job to SQL Server Agent
EXEC sp_add_jobserver 
    @job_name = N'IndexOptimize - USER_DATABASES', 
    @server_name = @@SERVERNAME;

PRINT 'IndexOptimize - USER_DATABASES job created successfully.';
GO

USE msdb;
GO

EXEC sp_add_jobschedule 
    @job_name = N'IndexOptimize - USER_DATABASES',
    @name = N'Weekly Index Maintenance - Sundays 8pm',
    @freq_type = 8,       -- Weekly
    @freq_interval = 1,   -- Every week
    @freq_recurrence_factor = 1,  -- Recurs every week
    @freq_subday_type = 1, -- Once per day
    @active_start_time = 200000;  -- 20:00:00 (8 PM)
GO

