--What Index Maintenance already exists? -- check whole server
USE DBA;
GO

/*

--check sql agent jobs relating to "index" in job name - step command

*/

SELECT name AS JobName, 
       enabled AS IsEnabled, 
       description
FROM msdb.dbo.sysjobsteps sjs
JOIN msdb.dbo.sysjobs sj ON sjs.job_id = sj.job_id
WHERE sjs.command LIKE '%Index%'
ORDER BY name;


--check for maintenance plans

SELECT [name]
FROM msdb.dbo.sysmaintplan_plans;


--check for Ola job names
SELECT sj.name AS JobName, 
       sjs.step_name, 
       sjs.command
FROM msdb.dbo.sysjobsteps sjs
JOIN msdb.dbo.sysjobs sj ON sjs.job_id = sj.job_id
WHERE sjs.command LIKE '%IndexOptimize%'; 

--check for Ola Hallengren procs (check master or "dba" or similar database)
SELECT name
FROM sys.procedures
WHERE name IN ('IndexOptimize', 'CommandExecute');



--If nothing looks to be in place, ASK AROUND...

