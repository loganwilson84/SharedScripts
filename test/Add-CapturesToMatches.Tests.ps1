﻿<#
.SYNOPSIS
Tests adding named capture group values as note properties to Select-String MatchInfo objects.
#>

Describe 'Adding named capture group values'{
	Context 'Add to pipeline' -Tag example {
		It "Value '<Text>' should add '<Name>' and '<Email>'" -TestCases @(
			@{ Text = 'Arthur Dent adent@example.org'; Name = 'Arthur Dent'; Email = 'adent@example.org' }
			@{ Text = 'Tricia McMillan trillian@example.com'; Name = 'Tricia McMillan'; Email = 'trillian@example.com' }
		 ) {
			Param([string]$Text,[string]$Name,[string]$Email)
			$result = $Text |Select-String '^(?<Name>.*?\b)\s*(?<Email>\S+@\S+)$' |Add-CapturesToMatches.ps1
			$result.Name |Should -BeExactly $Name
			$result.Email |Should -BeExactly $Email
		}
	}

}
