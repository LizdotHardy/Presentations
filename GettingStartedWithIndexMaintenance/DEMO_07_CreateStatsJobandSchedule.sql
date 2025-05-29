USE msdb;
GO

-- Add the job
EXEC sp_add_job 
    @job_name = N'Update Statistics - USER_DATABASES';

-- Add a step to the job --(5% of rows in table/index modified then will update stats) --check 1800 limit
EXEC sp_add_jobstep 
    @job_name = N'Update Statistics - USER_DATABASES',
    @step_name = N'Run Index Maintenance',
    @subsystem = N'TSQL',
    @command = N'USE DBA;
                GO            
                EXEC dbo.IndexOptimize 
                @Databases = ''USER_DATABASES'',
                @FragmentationLow = NULL,
                @FragmentationMedium = NULL,
                @FragmentationHigh = NULL,
                @UpdateStatistics = ''ALL'',
                @StatisticsModificationLevel = 5, 
                @TimeLimit = 1800,
                @LogToTable = ''Y'';';

-- Add the job to SQL Server Agent
EXEC sp_add_jobserver 
    @job_name = N'Update Statistics - USER_DATABASES', 
    @server_name = @@SERVERNAME;

PRINT 'Update Statistics - USER_DATABASES job created successfully.';
GO

USE msdb;
GO

EXEC sp_add_jobschedule 
    @job_name = N'Update Statistics - USER_DATABASES',
    @name = N'Daily Index Maintenance - Daily 10pm',
    @freq_type = 4,       
    @freq_interval = 1, 
    @freq_recurrence_factor = 1,  
    @freq_subday_type = 1,
    @active_start_time = 220000; 
GO

