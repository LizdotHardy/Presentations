/***** DEMO 09 *****/


/*********************************************************************

Execute Parameter - great for fine tuning your maintenance solution

Execute commands. By default, the commands are executed normally. 
If this parameter is set to N, then the commands are printed only.

Value:	Description:
Y		Execute commands. This is the default.
N		Only print commands.

**********************************************************************/


USE DBA;
GO

--Using the @Execute = 'N' parameter to check what is going to update based on parameters used in the job

EXECUTE [dbo].[IndexOptimize]
@Databases = 'WideWorldImporters',
@LogToTable = 'Y',
@Execute = 'N'