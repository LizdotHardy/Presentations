#use this line for connecting to 1 docker instance: 

#$inst = connect-DbaInstance -SqlInstance localhost:7777 -SqlCredential (Get-Credential sqladmin) 



#stop container 1

docker stop lizsql1




#start containers

docker start lizsql2, lizsql3

test-dbaconnection -SqlInstance localhost:7778,localhost:7779







#use to deploy to multiple containers at once:

$inst = connect-DbaInstance -SqlInstance localhost:7778,localhost:7779 -SqlCredential (Get-Credential sqladmin) 





#To Deploy:
 
$params = @{
    SqlInstance = $inst
    Database = 'master'
    InstallJobs = $true
    #ReplaceExisting = $true # Replace any existing jobs
}

# Install and configure the maintenance solution


Install-DbaMaintenanceSolution @params 









#stop containers/start container 1 again

docker stop lizsql2, lizsql3

docker start lizsql1

