function Export-Headers {
    <#
        .SYNOPSIS
            Generates and saves the JNI header files, needed to compile winutils
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false, HelpMessage="Source dir")]
        [ValidateScript({Test-Path -Path $_ -PathType Container})]
        [string]$Path=(Get-Location).Path,

        [Parameter(Mandatory=$true, HelpMessage="Destination dir")]
        [ValidateScript({Test-Path -Path $_ -PathType Container})]
        [string]$Destination
    )
    
}