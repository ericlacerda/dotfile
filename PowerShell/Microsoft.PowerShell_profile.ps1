$HOUR = (Get-Date).Hour
if ($HOUR -ge 6 -and $HOUR -lt 18) {
    $env:DAYTIME = "day"
} else {
    $env:DAYTIME = "night"
}

Import-Module posh-git

#Aliases
Set-Alias tt tree
Set-Alias ll ls
Set-Alias g git
Set-Alias vim nvim
Set-Alias c clear



#Prompt
#oh-my-posh init pwsh | Invoke-Expression
# Load prompt config
function Get-ScriptDirectory {Split-Path -Path $profile}
$PROMPT_CONFIG = Join-Path (Get-ScriptDirectory) 'DeepTealSea.omp.json'
oh-my-posh init pwsh --config $PROMPT_CONFIG | Invoke-Expression



#Utilities
function whereis($command) {
	Get-Command -Name $command -ErrorAction SilentlyContinue |
	  Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

#Icons
Import-Module Terminal-Icons

#PSReadLine
Import-Module PSReadLine
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineOption -PredictionViewStyle ListView

#fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

#Procura Texto
function proc {
    param(
        [Parameter(Mandatory=$True)]
        [string]$pattern,

        [Parameter(Mandatory=$True)]
        [string]$extension
    )

    Get-ChildItem -Recurse -Filter "*.$extension" | Select-String -Pattern $pattern
}

#Ide dev
function dev {
    Start-Process wt -ArgumentList "-w 0 `; split-pane -V --size 0.31 `; split-pane -H --size 0.50"
}

