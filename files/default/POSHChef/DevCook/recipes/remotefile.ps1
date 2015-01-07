
Configuration DevCook_RemoteFile {

    <#

    .SYNOPSIS
        Copy a remote file and directory locally

    .DESCRIPTION
        Copy a file from a remote source and a directory to ensure that they are copied properly

        When a file is copied the following rules apply:
            1. If it does not exist locally copy it
            2. If it exists locally get the checksum and compare with the remote, if they are different copy the remote

        When a directory is copied the only criteria is that the directory does not exist locally, if it does it will not be updated

        This recipe will create a dummy directory and then populate it with the number of files as specified in attributes.  These files
        will contain random strings so that they will get a different checksum.  After creation the RemoteFile resource will be used to copy
        this directory to a new one to ensure the files are copied correctly.

    .NOTES

        In this simple recipe a local file and directory will be copied.  The resource will handle this but it is not practical
        for this cookbook to have shares confiured within it to mimic the test.

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

    # Create a local directory
    File "Create directory for RemoteFile" {
        Ensure = "Present"
        DestinationPath = $node.DevCook.path
        Type = "Directory"
    }

    # Create an array of text that will be placed into several files
    $set = "abcdefghijklmnopqrstuvwxyz0123456789".ToCharArray()
    $text = @()
    for ($i = 0; $i -le $node.DevCook.files; $i ++) {

        # reset the string on each loop
        $string = [String]::Empty

        # create a random string that is 10 characters long
        for ($x = 0; $x -lt 20; $x++) {
            $string += $set | Get-Random
        }

        # apply the string to the text array
        $text += $string
    }

    # iterate around the text array and create a file for each entry
    $count = 1
    foreach ($str in $text) {

        # Create the filename of the new file
        $filename = "DevCook_File_{0}.txt" -f $count

        File ("Create File {0}" -f $filename) {
            Ensure = "Present"
            DestinationPath = "{0}\{1}" -f $node.DevCook.path, $filename
            Contents = $str
        }

        # increment the loop count
        $count ++
    }

    # Use the remotefile resource to copy the newly created directory
    POSHChef_RemoteFile "Copy Directory" {
        Ensure = "Present"
        Source = $node.DevCook.path
        Target = $node.DevCook.target
    }

}