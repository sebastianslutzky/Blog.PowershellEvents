$env:PSMODULEPATH = $PSScriptRoot

Import-Module InternalInstaller

Install-LocalAppAndNotify 42
