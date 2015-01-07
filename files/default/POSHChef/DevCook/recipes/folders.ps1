
Configuration DevCook_Folders {

    <#

    .SYNOPSIS
        Recipe to check that folders are created properly

    .DESCRIPTION
        Another testing recipe to ensure that the folders that have been specified in attributes are
        created on the disk in the correct location

    #>

    [CmdletBinding()]
    param (

        [Parameter(Mandatory=$true)]
        [hashtable]
        [ValidateScript({
            $_.contains("Base") -and
            $_.base.contains("folders")
        })]
        $node
    )

    # Iterate around each of the paths in the folder
    foreach ($path in $node.base.folders.keys) {

        Folder ("Folder_{0}" -f ($path -replace "\", "_")) {
            Ensure = "Present"
            Path = $path
        }
    }
}