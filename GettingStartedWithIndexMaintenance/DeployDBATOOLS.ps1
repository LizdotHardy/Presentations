#CONTAINER CHECKS

#$inst = connect-DbaInstance -SqlInstance localhost:7777 -SqlCredential (Get-Credential sqladmin) 


# list all containers
docker ps -a

#list all active containers
docker ps

#list all stopped containers
docker ps -a --filter "status=exited"





#STOP/START CONTAINERS/TEST CONNECTION


#stop container 1

docker stop lizsql1


#start containers

docker start lizsql2, lizsql3

#test access to my local container - not a remote powershell connection
$cred = get-credential sqladmin 
test-dbaconnection -SqlInstance localhost:7778,localhost:7779 -SqlCredential $cred -SkipPSRemoting 





#DEPLOY OLA TO INSTANCES


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





#STOP/START CONTAINERS

#stop containers/start container 1 again

docker stop lizsql2, lizsql3

docker start lizsql1

