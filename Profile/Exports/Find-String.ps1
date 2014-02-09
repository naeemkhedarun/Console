function Find-String {
    [CmdletBinding()]
	param(
		[Parameter(Position=0,Mandatory=$true)]$pattern,
		$path = $pwd,
		[switch]$regex,
		[switch]$showContext,
		[switch]$includeLargeFiles	
    )

	$maxFileSizeToSearchInBytes = 1024*1024 # 1mb

	Get-ChildItem -Path $path -Recurse | 
		? { $_.PSIsContainer -eq $false -and ($includeLargeFiles -or $_.Length -le $maxFileSizeToSearchInBytes) } | 
		Select-String -Pattern $pattern -AllMatches -SimpleMatch:$(!$regex) -Context:$(?: {$showContext} {"3"} {$false}) |
		Out-ColorMatchInfo
}
@{Function = "Find-String"}

set-strictmode -off
function Out-ColorMatchInfo {
param ( 
    [Parameter(Mandatory=$true, ValueFromPipeline=$true)] 
    [Microsoft.PowerShell.Commands.MatchInfo] 
    $match
)
#http://mohundro.com/blog/2009/06/12/find-stringps1---ack-for-powershell/
#https://github.com/drmohundro/Find-String/blob/master/Find-String.psm1
#http://answers.oreilly.com/topic/1989-how-to-search-a-file-for-text-or-a-pattern-in-windows-powershell/
    begin {
        $script:priorPath = ''
        $script:hasContext = $false
    }
    process { 
        function Write-PathOrSeparator($match) {
            if ($script:priorPath -ne $match.Path) {
                write-host ''
                write-host $match.Path -foregroundColor Green
                $script:priorPath = $match.Path
            }
            else {
                if ($script:hasContext) { 
                    write-host '--' 
                }
            }
        }
        Write-PathOrSeparator $match

        function Write-HighlightedMatch($match) {
            write-host "$($match.LineNumber):" -nonewline
            $index = 0
            foreach ($m in $match.Matches) {
                write-host $match.Line.SubString($index, $m.Index - $index) -nonewline
                write-host $m.Value -ForegroundColor Black -BackgroundColor Yellow -nonewline
                $index = $m.Index + $m.Length
            }
            if ($index -lt $match.Line.Length) {
                write-host $match.Line.SubString($index) -nonewline
            }
            write-host ''
        }

        function Write-ContextLines($context, $contextLines) {
            if ($context.length -eq $null) {return}

            $script:hasContext = $true
            for ($i = 0; $i -lt $context.length; $i++) {
                "$($contextLines[$i])- $($context[$i])"
            }
        }


        $lines = ($match.LineNumber - $match.Context.DisplayPreContext.Length)..($match.LineNumber - 1)
        Write-ContextLines $match.Context.DisplayPreContext $lines

        Write-HighlightedMatch $match

        $lines = ($match.LineNumber + 1)..($match.LineNumber + $match.Context.DisplayPostContext.Length)
        Write-ContextLines $match.Context.DisplayPostContext $lines

    }
    end {}
}