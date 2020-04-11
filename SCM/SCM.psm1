function New-TagForDeployment($deploymentId){
    write-host "[SCM]**** Creating Tag for deploymentId $deploymentId******"
    New-Event -SourceIdentifier TagCreated `
        -MessageData @{Tag = "DEPLOYED/$deploymentId"}|out-null
}
