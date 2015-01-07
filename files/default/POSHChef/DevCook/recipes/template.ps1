
Configuration DevCook_Template {

    <#

    .SYNOPSIS
        Write out a template file to the disk

    .DESCRIPTION
        Write out a rendered template file and ensure that the specified service is notified
        for restart.

        As this is for cookbook development and testing it is possible to skip the service restart eithe on
        the command line when running chef or permenantly in the configuration file.  Please see the example
        section for information.

    .EXAMPLE

        PS C:\> Invoke-POSHChef -skip notifies

        This will run POSHChef and will determine what services need to be restarted, but they will not be restarted
        This only works for this particular run

    .EXAMPLE

        Add the following to the POSHCHef configuation file

        skip = @(
            notifies
        )

        and then run

        PS C:\> Invoke-POSHChef

        This is a permenant change so POSHChef will never try to restart services when it is run on a machine

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

    # Using the POSHChef core resource write out the template
    Template "DevCook_Template" {
        Ensure = "Present"
        Source = "statement.txt.tmpl"   
        Destination = "c:\temp\statement.txt"
        Attributes = $node | ConvertTo-Json -Depth 99
        Cookbook = "devcook"
        Notifies = @("Dnscache")
    }
}