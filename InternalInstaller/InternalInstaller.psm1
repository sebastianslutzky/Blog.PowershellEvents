Import-Module SCM
Import-Module InternalDashboard
Import-Module EmailSender
Import-Module SystemInstaller


function Install-LocalAppAndNotify($appId){
   # When App is Installed, Publish to the Dashboard
   Register-EngineEvent -SourceIdentifier AppInstalled `
   -Action {
       InternalDashboard\Publish-DeployedApp `
        -appId $event.messagedata.appId `
        -deploymentId $event.messagedata.deploymentId
   }|Out-Null

   # ... and create a tag in source control
   Register-EngineEvent -SourceIdentifier AppInstalled `
   -Action {
       SCM\New-TagForDeployment `
        -deploymentId $event.messagedata.deploymentId
   }|Out-Null

   # Email testers when the tag is created 
   Register-EngineEvent -SourceIdentifier TagCreated `
   -Action {
       EmailSender\Send-TagCreatedEmail `
        -tag $event.messagedata.Tag `
        -to 'Testers@myorg.com'
   }|Out-Null

   # Now install the application
   write-host "[InternalInstaller]**** Starting Installation "
   SystemInstaller\Install-LocalApp -appId $appId

     #Do not forget to remove event listeners!!
     Get-EventSubscriber| Remove-Event
}
