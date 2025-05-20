
/* Parameters deployed by default  - assumes the following for fragmentation of objects:

If <5% nothing is changed
If 5%-30% a REORGANIZE is done
If 30%+ a REBUILD is done

*/

EXECUTE [dbo].[IndexOptimize]
@Databases = 'USER_DATABASES',
@LogToTable = 'Y'; --> need to specify Y or N but default for the job specifies Y

/**** OPTIONS FOR PARAMETERS - EXAMPLES ****/

/* 

Add logging to the Command Log table - recommended if troubleshooting

*/

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
@Indexes = 'ALL_INDEXES, -WideWorldImporters.Sales.Invoices'
@LogToTable = 'Y';



/*** Do all but a specific index ***/

EXECUTE [dbo].[IndexOptimize]
@Databases = 'USER_DATABASES',
@Indexes = 'ALL_INDEXES, -WideWorldImporters.Sales.Invoices.IndexName' --> amend this
@LogToTable = 'Y';



/*** Rebuild offline (Web/Standard Edition) ***/

EXECUTE [dbo].[IndexOptimize]
@Databases = 'USER_DATABASES',
@FragmentationLow = NULL,
@FragmentationMedium = NULL, 
@FragmentationHigh = 'INDEX_REBUILD_OFFLINE', --the default is 30 (determines lower limit for high fragmentation)
@LogToTable = 'Y'



/*** Rebuild online (Developer/Enterprise Edition) - only rebuild when fragmentation is high i.e. avg_fragmentation_in_percent >= 50 ***/

EXECUTE [dbo].[IndexOptimize]
@Databases = 'USER_DATABASES',
@FragmentationLow = NULL,
@FragmentationMedium = NULL, 
@FragmentationHigh = 'INDEX_REBUILD_ONLINE',
@FragmentationLevel2 = 50, --otherwise the default is 30 (determines lower limit for high fragmentation)
@Timelimit = 7200, --only allow for 2 hours
@LogToTable = 'Y'


/* Using the Timelimit Parameter

NOTE - won't stop the current object - will not start next command 
once this timelimit is reached

*/

EXECUTE [dbo].[IndexOptimize]
@Databases = 'USER_DATABASES',
@FragmentationLow = NULL,
@FragmentationMedium = NULL, 
@FragmentationHigh = 'INDEX_REBUILD_ONLINE',
@FragmentationLevel2 = 50, --otherwise the default is 30 (determines lower limit for high fragmentation)
@Timelimit = 7200, --only allow for 2 hours
@LogToTable = 'Y'