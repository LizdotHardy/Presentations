--BACKUP DATABASE [WideWorldImporters] TO DISK = '/shared/WideWorldImporters-Full.bak' WITH STATS = 5;


--RESTORE FILELISTONLY FROM DISK = '/shared/WideWorldImporters-Full.bak'

/*

--restore the db to container

*/

USE [master]
RESTORE DATABASE [WWImporters] FROM  DISK = N'/Shared/WideWorldImporters-Full.bak' 
WITH  FILE = 1,  
MOVE N'WWI_Primary' TO N'/var/opt/mssql/data/WWImporters.mdf',  
MOVE N'WWI_UserData' TO N'/var/opt/mssql/data/WWImporters_UserData.ndf',  
MOVE N'WWI_Log' TO N'/var/opt/mssql/data/WWImporters.ldf',  
MOVE N'WWI_InMemory_Data_1' TO N'/var/opt/mssql/data/WWImporters_InMemory_Data_1',  
NOUNLOAD,  STATS = 5
GO


--BACKUP DATABASE [dba] TO DISK = '/shared/dba.bak' WITH STATS = 5;


--RESTORE FILELISTONLY FROM DISK = '/shared/dba.bak'

/*

--restore the db to container

*/

/*

restore dbadb if not already deployed

USE [master]
RESTORE DATABASE [dbadb] FROM  DISK = N'/shared/dba.bak' 
WITH  FILE = 1,  
MOVE N'dba' TO N'/var/opt/mssql/data/dbadb_data.mdf',   
MOVE N'dba_log' TO N'/var/opt/mssql/data/dbadb_log.ldf',    
NOUNLOAD,  STATS = 5
GO

*/