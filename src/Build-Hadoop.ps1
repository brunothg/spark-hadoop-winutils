. "$PSScriptRoot\Get-Hadoop.ps1"
. "$PSScriptRoot\Export-Headers.ps1"

function Build-Hadoop {
    <#
        .SYNOPSIS
            Builds winutils for a specific hadoop version
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, HelpMessage="Hadoop version")]
        [string]$Version,

        [Parameter(Mandatory=$false, HelpMessage="Destination dir")]
        [string]$Destination=".\hadoop",

        [Parameter(Mandatory=$false, HelpMessage="Hadoop git repository URL")]
        [string]$Repository="https://github.com/apache/hadoop.git",

        [Parameter(Mandatory=$false, HelpMessage="Hadoop commons repository sub path")]
        [string]$WinutilsRepositoryBasePath="hadoop-common-project\hadoop-common",

        [Parameter(Mandatory=$false, HelpMessage="Src")]
        [string]$HeaderSrc="src\main\java",

        [Parameter(Mandatory=$false, HelpMessage="Destination dir")]
        [string]$HeaderDestination="target\native\javah",

        [Parameter(HelpMessage="Force destination (may delete existing dirs/files)")]
        [switch]$Force
    )

    function Open-Explorer($Path=".") {
        Push-Location $Path
        Invoke-Item .
        Pop-Location
    }

    $BinDir = "$Destination\$WinutilsRepositoryBasePath\target\bin"
    $WinutilsSlnPath = "$Destination\$WinutilsRepositoryBasePath\src\main\winutils\winutils.sln"
    $WinutilsX64Path = "$Destination\$WinutilsRepositoryBasePath\src\main\winutils\x64\Release"
    $WinutilsX32Path = "$Destination\$WinutilsRepositoryBasePath\src\main\winutils\x32\Release"
    $NativeSlnPath = "$Destination\$WinutilsRepositoryBasePath\src\main\native\native.sln"

    Invoke-Expression "Get-Hadoop -Version '$Version' -Destination '$Destination' -Repository '$Repository' -Force:$(if($Force){'$true'} else {'$false'})"
    Export-Headers -Project (Join-Path $Destination $WinutilsRepositoryBasePath) -Src $HeaderSrc -Destination $HeaderDestination

    Write-Warning "Auto compile not implemented - opening VS project for winutils ..."
    Invoke-Expression $WinutilsSlnPath
    Read-Host -Prompt "Press any key after you successfully compiled the winutils"

    # Try to copy binaries to bin dir (needed for hadoop natives)
    New-Item -Path $BinDir -ItemType Directory -Force | Out-Null
    if (Test-Path -Path $WinutilsX64Path -PathType Container) {
        Copy-Item "$WinutilsX64Path\libwinutils.lib" -Destination "$BinDir\"
        Copy-Item "$WinutilsX64Path\libwinutils.pdb" -Destination "$BinDir\"
        Copy-Item "$WinutilsX64Path\winutils.exe" -Destination "$BinDir\"
        Copy-Item "$WinutilsX64Path\winutils.pdb" -Destination "$BinDir\"
    } elseif (Test-Path -Path $WinutilsX32Path -PathType Container) {
        Copy-Item "$WinutilsX32Path\libwinutils.lib" -Destination "$BinDir\"
        Copy-Item "$WinutilsX32Path\libwinutils.pdb" -Destination "$BinDir\"
        Copy-Item "$WinutilsX32Path\winutils.exe" -Destination "$BinDir\"
        Copy-Item "$WinutilsX32Path\winutils.pdb" -Destination "$BinDir\"
    }

    Write-Warning "Auto compile not implemented - opening VS project for native ..."
    Invoke-Expression $NativeSlnPath
    Read-Host -Prompt "Press any key after you successfully compiled the natives"

    Open-Explorer -Path $BinDir

}

# TODO rm test
Build-Hadoop -Version "3.3.3"