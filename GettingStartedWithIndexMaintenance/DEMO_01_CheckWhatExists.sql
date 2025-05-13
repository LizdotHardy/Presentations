--What Index Maintenance already exists?

--check sql agent jobs relating to "index" in job name
SELECT name AS JobName, 
       enabled AS IsEnabled, 
       description
FROM msdb.dbo.sysjobsteps sjs
JOIN msdb.dbo.sysjobs sj ON sjs.job_id = sj.job_id
WHERE sjs.command LIKE '%Index%'
ORDER BY name;

--check for Ola job names
SELECT sj.name AS JobName, 
       sjs.step_name, 
       sjs.command
FROM msdb.dbo.sysjobsteps sjs
JOIN msdb.dbo.sysjobs sj ON sjs.job_id = sj.job_id
WHERE sjs.command LIKE '%IndexOptimize%'; 

--check for Ola Hallengren procs (check master or "dba" or similar database)
SELECT name
FROM master.sys.procedures
WHERE name IN ('IndexOptimize', 'CommandExecute');

