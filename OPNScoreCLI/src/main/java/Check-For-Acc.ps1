<#
.SYNOPSIS
 Verify if an account with given string exists.

.DESCRIPTION
See synopsis.

.PARAMETER Username
The string username that we're looking for.

.EXAMPLE
Get-AccExistence -Username "JarJar"

.NOTES
light input scrubbing not meant for direct user interaction.
#>
function Get-AccExistence {
    param (
        $Username
    )
    
    #makes parameter required in a non annoying way
    if(-not($Username)) {Throw "Usage: Get-AccExistence -Username 'string'"}

    $Exists = $true

    # try to find the requested user, if it doesn't exist then the error it caught and variable set.
    try { $Trash = Get-LocalUser $Username -erroraction Stop} # assign the result so it's not returned, and set the error action so it works properly with try / catch.
    catch { 
        $Exists = $trash #VSC generates a warning when variables are assigned but not used so i added this useless line to get rid of the error
        $Exists = $false }

    return $Exists
}