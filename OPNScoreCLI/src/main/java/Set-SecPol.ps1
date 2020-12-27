<#
.SYNOPSIS
Replaces a specific parameter in the security policy with another. if you can find the COMPLETE string to complete in your java program then this can change it.

.DESCRIPTION
This was pulled from a stackoverflow post so you can find more detailed info here: https://stackoverflow.com/questions/23260656/modify-local-security-policy-using-powershell#:~:text=In%20Administrative%20Tools%20folder%2C%20double,to%20save%20your%20policy%20change

.PARAMETER ThingToReplace
a string of the setting getting replaced, must mention the current state. see example on the declaration line.

.PARAMETER NewSetting
New thing to put back, see example on declaration line.

.EXAMPLE
Set-SecPolParam -ThingToReplace "PasswordComplexity = 1" -NewSetting "PasswordComplexity = 0"

.NOTES
Comment out the last line to get a file in your C drive that  you can open as a .txt to see all the things you can change with this.
#>
function Set-SecPolParam {
    param (
        $ThingToReplace, #example: "PasswordComplexity"
        $NewSetting     #example: "PasswordComplexity = 0"
    )
    secedit /export /cfg c:\secpol.cfg
    (gc C:\secpol.cfg).replace($ThingToReplace, $NewSetting) | Out-File C:\secpol.cfg
    secedit /configure /db c:\windows\security\local.sdb /cfg c:\secpol.cfg /areas SECURITYPOLICY
    rm -force c:\secpol.cfg -confirm:$false
}
