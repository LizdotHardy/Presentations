
#/**************************************************

#DEPLOY USING DBATOOLS - automated/multiple instances

#**************************************************/

#CONTAINER CHECKS

#list all active containers
#docker ps

#list all active containers
#docker ps -a

#Check sql is up and running
#docker logs lizsql1 | Select-String "Recovery is complete"


#run Ola clean up script

#DEPLOY OLA TO INSTANCES:


#Set credential and test connection
$cred = get-credential sqladmin 
test-dbaconnection -SqlInstance localhost:7777 -SqlCredential $cred -SkipPSRemoting


#use to deploy to single container

$inst = connect-DbaInstance -SqlInstance localhost:7777 -SqlCredential $cred



#Use to deploy to multiple containers at once:

$inst = connect-DbaInstance -SqlInstance localhost:7778,localhost:7779 -SqlCredential $cred 



#To Deploy:
 
$params = @{
    SqlInstance = $inst
    Database = 'DBA'
    InstallJobs = $true
    LogToTable = $true
    }

# Install and configure the maintenance solution


Install-DbaMaintenanceSolution @params 

