docker start containername
docker stop containername

test-dbaconnection -SqlInstance localhost:7778,localhost:7779

#use this line for docker instance: 

$inst = connect-DbaInstance -SqlInstance localhost:7777 -SqlCredential (Get-Credential sqladmin) 



#use to deploy to multiple containers at once:

#$inst = connect-DbaInstance -SqlInstance localhost:7778,localhost:7779 -SqlCredential (Get-Credential sqladmin) 


#To Deploy:
 
$params = @{
    SqlInstance = $inst
    Database = 'DBA'
    InstallJobs = $true
    #ReplaceExisting = $true # Replace any existing jobs
}

# Install and configure the maintenance solution


Install-DbaMaintenanceSolution @params 


