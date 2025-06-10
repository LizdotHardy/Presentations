/***** DEMO 6 *****/

/********************************

OPTIONS FOR PARAMETERS - EXAMPLES 

********************************/


/***  Index Optimize Proc - deploys as 'N' by default, Job creates with 'Y' as default ***/

EXECUTE [dbo].[IndexOptimize]
@Databases = 'USER_DATABASES',
@LogToTable = 'N'; 




/*********************************************************************
Add logging to the Command Log table - recommended if troubleshooting
**********************************************************************/

EXECUTE [dbo].[IndexOptimize]
@Databases = 'USER_DATABASES',
@LogToTable = 'Y';


/*** Only do specific databases ***/

EXECUTE [dbo].[IndexOptimize]
@Databases = 'WorldWideImporters, Northwind',
@LogToTable = 'Y';


/*** Do all but a specific database ***/

EXECUTE [dbo].[IndexOptimize]
@Databases = 'USER_DATABASES, -DBA',
@LogToTable = 'Y';


/*** Do all but a specific table ***/

EXECUTE [dbo].[IndexOptimize]
@Databases = 'USER_DATABASES',
@Indexes = 'ALL_INDEXES, -WideWorldImporters.Sales.Invoices',
@LogToTable = 'Y';


/*** Do all but a specific index ***/

EXECUTE [dbo].[IndexOptimize]
@Databases = 'USER_DATABASES',
@Indexes = 'ALL_INDEXES, -WideWorldImporters.Sales.Invoices.PK_Sales_Invoices',
@LogToTable = 'Y';





/***************************************************************************

@Fragmentation levels - Low/Med/High parameters

Parameters deployed by default:

@FragmentationLow		If fragmentation is <5% nothing is done
@FragmentationMedium	If fragmentation is 5%-30% a REORGANIZE is done 
@FragmentationHigh		If fragmentation is 30%+ a REBUILD is done

***************************************************************************/


/*** tries a reorg then if not a rebuild online is attempted otherwise will do offline ***/

EXECUTE [dbo].[IndexOptimize]
@Databases = 'USER_DATABASES',
@FragmentationLow = NULL,
@FragmentationMedium = 'INDEX_REORGANIZE,INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE', 
@FragmentationHigh = 'INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE', --the default is 30 (determines lower limit for high fragmentation)
@LogToTable = 'Y'


/*************************************************************************** 

Reset @FragmenationHigh level to higher than 50% using @FragmentationLevel2 parameter

Using the Timelimit Parameter
- won't stop the current object - will not start next command once this timelimit is reached

***************************************************************************/

EXECUTE [dbo].[IndexOptimize]
@Databases = 'USER_DATABASES',
@FragmentationLow = NULL,
@FragmentationMedium = 'INDEX_REORGANIZE,INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
@FragmentationHigh = 'INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
@FragmentationLevel2 = 50, /* -sets threshold to 50 rather than default of 30 for high fragmentation) */
@Timelimit = 7200, /* configure in seconds - 2 hours */
@LogToTable = 'Y'




/***************************************************************************
					Update Statistics
***************************************************************************/

EXEC dbo.IndexOptimize 
@Databases = 'USER_DATABASES',
@FragmentationLow = NULL,
@FragmentationMedium = NULL,
@FragmentationHigh = NULL,
@UpdateStatistics = 'ALL', --Update index and column statistics
@StatisticsModificationLevel = 5, --a percentage of modified rows for when the statistics should be updated
@TimeLimit = 1800,
@LogToTable = 'Y';




/***************************************************************************
Using onlymodifiedstats parameter
***************************************************************************/

EXEC dbo.IndexOptimize 
@Databases = 'USER_DATABASES',
@FragmentationLow = NULL,
@FragmentationMedium = NULL,
@FragmentationHigh = NULL,
@UpdateStatistics = 'ALL', --Update index and column statistics
@OnlyModifiedStats = 'Y', 
@TimeLimit = 1800,
@LogToTable = 'Y';










/*** rebuild online is attempted otherwise will do offline ***/

EXECUTE [dbo].[IndexOptimize]
@Databases = 'USER_DATABASES',
@FragmentationLow = NULL,
@FragmentationMedium = NULL, 
@FragmentationHigh = 'INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE', /* the default is 30 (determines lower limit for high fragmentation) */
@LogToTable = 'Y'



/*** rebuild when fragmentation is higher than 50% i.e. avg_fragmentation_in_percent >= 50 ***/

EXECUTE [dbo].[IndexOptimize]
@Databases = 'USER_DATABASES',
@FragmentationLow = NULL,
@FragmentationMedium = 'INDEX_REORGANIZE,INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE', 
@FragmentationHigh = 'INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
@FragmentationLevel2 = 50, /* -sets threshold to 50 rather than default of 30 for high fragmentation) */
@LogToTable = 'Y'