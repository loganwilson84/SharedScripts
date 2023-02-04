﻿<#
.SYNOPSIS
Tests replacing each of the longest matching parts of a string with an embedded environment variable with that value.
#>

Describe 'Compress-EnvironmentVariables' -Tag Compress-EnvironmentVariables {
	BeforeAll {
		if(!(Get-Module -List PSScriptAnalyzer)) {Install-Module PSScriptAnalyzer -Force}
		$scriptsdir,$sep = (Split-Path $PSScriptRoot),[io.path]::PathSeparator
		$ScriptName = Join-Path $scriptsdir Compress-EnvironmentVariables.ps1
		if($scriptsdir -notin ($env:Path -split $sep)) {$env:Path += "$sep$scriptsdir"}
	}
	Context 'Comment-based help' -Tag CommentHelp {
		It "Should produce help object" {
			Get-Help $ScriptName |Should -Not -BeOfType string `
				-Because 'Get-Help should not fall back to the default help string'
		}
	}
	Context 'Replaces each of the longest matching parts of a string with an embedded environment variable with that value' `
		-Tag CompressEnvironmentVariables,Compress,EnvironmentVariables {
		It "For '<Value>', should return '<Result>'" -TestCases @(
			@{ Value ="[$env:APPDATA]"; Result = '[%APPDATA%]' }
			@{ Value ="[$env:COMPUTERNAME]"; Result = '[%COMPUTERNAME%]' }
			@{ Value ="$env:TEMP\tempdata"; Result = '%TEMP%\tempdata' }
		) {
			Param([string] $Value, [string] $Result)
			Compress-EnvironmentVariables.ps1 $Value |Should -Be $Result
		}
	}
}
