function Install-LocalApp($appId){
    $deploymentId = Get-Random -Maximum 100
    
    write-host "[SystemInstaller]***** Intalling app with id $appId. Deployment Id: $deploymentId"

    New-Event -SourceIdentifier AppInstalled `
        -MessageData @{appId = $appId; deploymentId= $deploymentId}|out-null
}