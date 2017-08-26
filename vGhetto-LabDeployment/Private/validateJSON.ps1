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
        # Try to import/convert
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

        
        

    }
    END
    {
        Write-Debug "Exiting validatejson. Perform additional debug?"
    }
}