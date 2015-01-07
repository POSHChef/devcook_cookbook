
Configuration DevCook_Log {

    <#

    .SYNOPSIS
        Outputs a message in the DSC run using the log resource

    .DESCRIPTION
        Using the Log resource that is built into POSHChef, output information to the screen

    #>

    [CmdletBinding()]
    param (

        [Parameter(Mandatory=$true)]
        [hashtable]
        [ValidateScript({
            $_.contains("DevCook")
        })]
        $node
    )

    # Use the resource
    # Use a uniq ID for the resource name as it will not need to be reused
    Log (([Guid]::NewGuid()).Guid) {
        Message = "DevCook Log Resource"
    }
}