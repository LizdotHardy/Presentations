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