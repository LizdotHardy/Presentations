/***** DEMO 1 *****/


/**************************************************************************

What Index Maintenance already exists?

***************************************************************************/


USE DBA;
GO


/**************************************************************************
Check sql agent jobs relating to "index" in job step
***************************************************************************/

SELECT sj.name AS JobName, 
       sj.enabled AS IsEnabled, 
       sj.description,
       sjs.command
FROM msdb.dbo.sysjobsteps sjs
JOIN msdb.dbo.sysjobs sj ON sjs.job_id = sj.job_id
WHERE sjs.command LIKE '%Index%'
ORDER BY name;




/**************************************************************************
check for maintenance plans - NOTE - won't work in SQL on Linux
***************************************************************************/

SELECT [name]
FROM msdb.dbo.sysmaintplan_plans;




/**************************************************************************
check for Ola jobs with name like index optimize
***************************************************************************/

SELECT sj.name AS JobName, 
       sjs.step_name, 
       sjs.command
FROM msdb.dbo.sysjobsteps sjs
JOIN msdb.dbo.sysjobs sj ON sjs.job_id = sj.job_id
WHERE sj.name LIKE '%IndexOptimize%'; 




/**************************************************************************
check for Ola Hallengren procs (check master or "dba" or similar database)
***************************************************************************/

SELECT name
FROM sys.procedures
WHERE name IN ('IndexOptimize', 'CommandExecute');




/**************************************************************************
If nothing looks to be in place, ASK AROUND...
**************************************************************************/