# create a shared network
#docker network create localnet

# fire up 2 SQL Servers
docker run -p 7777:1433  --volume shared:/shared:z --name lizsql1 --hostname lizsql1 --network localnet -d jpomfret7/lizsql1:latest
docker run -p 7778:1433  --volume shared:/shared:z --name lizsql2 --hostname lizsql2 --network localnet -d jpomfret7/lizsql2:latest

New-DbaClientAlias -ComputerName 'localhost,7777' -ServerName 'localhost,7777' -Alias lizsql1
New-DbaClientAlias -ComputerName 'localhost,7778' -ServerName 'localhost,7778' -Alias lizsql2


Get-DbaClientAlias | where AliasName -like 'liz*' | Format-Table

$cred = Get-Credential sqladmin
# password is top secret: dbatools.IO

# This uses PSDefaultParameterValues to automatically pass in the credential for all dbatools commands
$PSDefaultParameterValues = @{ '*-dba*:SqlCredential' =  $cred }

# now you can connect like this
Connect-DbaInstance -SqlInstance lizsql1, lizsql2

# and get databases like this
Get-DbaDatabase -SqlInstance lizsql1, lizsql2 | FT

# list all containers
docker ps -a



###REMOVE CONTAINERS SCRIPTS###

# remove lizsql1 even if it's running
#docker rm lizsql1 -f

# remove both even if they are running
#docker rm lizsql1 lizsql2  -f
