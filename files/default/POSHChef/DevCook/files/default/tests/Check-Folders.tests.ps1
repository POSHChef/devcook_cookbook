

<#

    .SYNOPSIS
        Check that the folders that have been created in the Folders resource exist

#>

# Read in the attributes for the node so that they can be tested
$attributes_file = (Get-Variable -Name test_attributes -Scope Global).Value

# If the file exists read it in
if (Test-Path -Path $attributes_file) {
    $attributes = Get-Content -Path $attributes_file -Raw | ConvertFrom-Json
} else {

    Write-Log -LogLevel Error -Message ("Attributes file cannot be found: {0}" -f $attributes_file)
    return
}


Describe "[DevCook::folders]" {

    foreach ($folder in @($attributes.devcook.path, $attributes.devcook.target)) {
        It ("Path exists: {0}" -f $folder) {

            # Iterate around the folders in the attributes and make sure they exist
            Test-Path -Path $folder | Should Be $true
        }
    }
}