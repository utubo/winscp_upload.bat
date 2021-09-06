@setlocal enabledelayedexpansion&set a=%*&(if defined a set a=!a:"=\"!&set a=!a:'=''!)&powershell/c $i=$input;iex ('$i^|^&{$PSCommandPath=\"%~f0\";$PSScriptRoot=\"%~dp0";#'+(${%~f0}^|Out-String)+'} '+('!a!'-replace'[$(),;@`{}]','`$0'))&exit/b
# thx: https://reosablo.hatenablog.jp/entry/2016/07/09/193617

###################
# Powershell script

foreach($target in $args) {
	$localDir = Split-Path (Get-Item $target) -Parent
	$localFile = Split-Path (Get-Item $target) -Leaf
	$configFile = ""
	$found = $FALSE
	$configDir = $localDir
	while ("$configDir") {
		$configFile = $configDir + "\_winscp.json"
		if (Test-Path $configFile) {
			$found = $TRUE;
			break;
		}
		$configDir = Split-Path $configDir -Parent
	}
	if (-not $found) {
		echo $target
		echo '... _winscp.json not found'
		continue;
	}

	$config = (Get-Content -Path "$configFile" | ConvertFrom-Json)
	$session = $config.session
	$remoteDir = $localDir.Replace($configDir, $config.remoteDir) + "/"
	$remoteDir = $remoteDir.Replace("\", "/")
	echo "winscp $session /upload $target $remoteDir"
	winscp $session /command "cd $remoteDir" "lcd $localDir" "put $localFile" "exit"
}

###################
# Example of _winscp.json
#
# {
#   "session": "my session",
#   "remoteDir": "~/public_html"
# }

