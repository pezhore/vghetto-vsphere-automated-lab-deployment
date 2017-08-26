function validateJson
{
    [CmdletBinding()]
    param(
            [ValidateScript({Test-Path -Type Leaf $_})]
            [String] $json
         )
    
    BEGIN {}
    PROCESS
    {
        # Try to import/convert from JSON
        try
        {
            $config = Get-Content $json | ConvertFrom-Json -ErrorAction Stop
        }
        catch
        {
            $config = @{}
            $config.Error = "$_"
            Return $config            
        }

        # Check if the binaries are valid
        foreach ($binary in $($config.Binaries | Get-Member -MemberType NoteProperty).Name )
        {
            Remove-Variable pathType -ErrorAction SilentlyContinue
            if ($binary -match "path")
            {
                $pathType = "Container"
            }
            else
            {
                $pathType = "Leaf"
            }
            if (! (Test-path -Type $pathType $Config.Binaries.$binary))
            {
                Write-Debug "Binary $binary not valid $pathType, debug?"
                $config | Add-Member -MemberType NoteProperty -Name Error -Value "Binary $binary not valid $pathType"
                return $config
            }
        }
    }
    END
    {
        Write-Debug "Exiting validatejson. Perform additional debug?"
    }
}