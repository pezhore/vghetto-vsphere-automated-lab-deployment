function Invoke-LabDeployment
{
    [CmdletBinding()]
    param(
            [Parameter(Mandatory=$true)]
            [ValidateScript({Test-Path -Type Leaf $_})]
            [Alias("json","config")]
            [String] $jsonConfig
         )
    
    BEGIN
    {
        $deploymentConfig = validateJSON $jsonConfig
        If ( !($deploymentConfig.Valid))
        {
            Throw "Invalid JSON. $($deploymentConfig.Error)."
        }
    }
    PROCESS
    {
        Write-Output $deploymentConfig
    }
    END
    {
        Write-Debug "Exiting Invoke-LabDeployment, perform any additional debugging?"
    }
}