﻿#Initial Set up


#REMINDERS

#Exit anything not required

#Pause any auto updates/notifications




Import-Module DBATools


#Start Containers - quick check can connect - check all dbs/ola there on 777, check dbs esp dba db on 7778/9



docker start lizsql1

#Stop any if perf issues - 7778/9 not needed immediately



#Start first container
docker start lizsql1

$cred = get-credential sqladmin 
test-dbaconnection -SqlInstance localhost:7777 -SqlCredential $cred -SkipPSRemoting





#if I need to trash/redo containers:



#Use this to restart docker

#docker desktop restart

#get-process docker* | stop-process
#get-process docker* | start-process
#Stop-Service -Name Docker
#Start-Service -Name Docker


# create a shared network
#docker network create localnet

# fire up 2 SQL Servers
docker run -p 7777:1433  --volume shared:/shared:z --name lizsql1 --hostname lizsql1 --network localnet -d jpomfret7/lizsql1:latest
docker run -p 7778:1433  --volume shared:/shared:z --name lizsql2 --hostname lizsql2 --network localnet -d jpomfret7/lizsql2:latest
docker run -p 7779:1433  --volume shared:/shared:z --name lizsql3 --hostname lizsql3 --network localnet -d jpomfret7/lizsql3:latest

New-DbaClientAlias -ComputerName 'localhost,7777' -ServerName 'localhost,7777' -Alias lizsql1
New-DbaClientAlias -ComputerName 'localhost,7778' -ServerName 'localhost,7778' -Alias lizsql2
New-DbaClientAlias -ComputerName 'localhost,7779' -ServerName 'localhost,7779' -Alias lizsql3

Get-DbaClientAlias | where AliasName -like 'liz*' | Format-Table

$cred = Get-Credential sqladmin
# password is top secret: dbatools.IO

# This uses PSDefaultParameterValues to automatically pass in the credential for all dbatools commands
$PSDefaultParameterValues = @{ '*-dba*:SqlCredential' =  $cred }

# now you can connect like this
Connect-DbaInstance -SqlInstance lizsql1, lizsql2, lizsql3

# and get databases like this
Get-DbaDatabase -SqlInstance lizsql1, lizsql2, lizsql3

# list all containers
docker ps -a

#stop containers
docker stop lizsql2, lizsql3


#### DESTROY CONTAINERS###


# remove lizsql1 even if it's running
#docker rm lizsql1 -f

# remove both even if they are running
#docker rm lizsql1 lizsql2 lizsql3  -f 

# you can also tidy up old images like so
#docker image remove jpomfret7/lizsql1 jpomfret7/lizsql2 jpomfret7/lizsql3