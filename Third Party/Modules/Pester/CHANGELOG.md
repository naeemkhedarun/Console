## Unreleased

## 3.0.0-beta2 (July 4, 2014)
  - Add code coverage
  - Fix TestName 
  - Fix direct execution of tests when the script is dot-sourced to global scope [GH-144]
  - Fix mock parameter filter in strict mode [GH-143]
  - Fix nUnit schema compatibility
  - Fix special characters in nUnit output
  
## 3.0.0-beta (June 24, 2014)
  - Add full support for module mocking
  - Isolate Pester internals from tested code
  - Tests.ps1 files can be run directly
  - Add It scope to TestDrive
  - Add It scope to Mock
  - Add Scope parameter to Assert-MockCalled
  - Measure test time more precisely
  
## 2.1.0 (June 15, 2014)
  - Process It blocks in memory [GH-123]
  - Fixed -ExecutionPolicy in pester.bat [GH-130]
  - Add support for mocking internal module functions, aliases, exe and filters. [GH-126]
  - Fix TestDrive clean up [GH-129]
  - Fix ShouldArgs in Strict-Mode [GH-134]
  - Fix initialize $PesterException [GH-136]
  - Validate Should Assertion methods [GH-135]
  - Fix using commands without fully qualified names [GH-137]
  - Enable latest strict mode when running Pester tests using Pester.bat

## 2.0.4 (March 9, 2014)

  - Fixed issue where TestDrive doesn't work with paths with . characters
    [GH-52]
  - Fixed issues when mocking Out-File [GH-71]
  - Exposing TestDrive with Get-TestDriveItem [GH-70]
  - Fixed bug where mocking Remove-Item caused cleanup to break [GH-68]
  - Added -Passthu to Setup to obtain file system object references [GH-69]
  - Can assert on exception messages from Throw assertions [GH-58]
  - Fixed assertions on empty functions [GH-50]
  - Fixed New-Fixture so it creates proper syntax in tests [GH-49]
  - Fixed assertions on Object arrays [GH-61]
  - Fixed issue where curly brace misalignment would cause issues [GH-90]
  - Better contrasting output colours [GH-92]
  - New-Fixture handles "." properly [GH-86]
  - Fixed mix scoping of It and Context [GH-98] and [GH-99]
  - Test Drives are randomly generated, which should allow concurrent Pester processes [GH-100] and [GH-94] 
  - Fixed nUnit test failing on non-US computers [GH-109]
  - Add case sensitive Be, Contain and Match assertions [GH-107]
  - Fix Pester template self-tests [GH-113]
  - Time is output to the XML report [GH-95]
  - Internal fixes to remove unnecessary dependencies among functions
  - Cleaned up Invoke-Pester interface
  - Make output better structured
  - Add -PassThru to Invoke-Pester [GH-102], [GH-84] and [GH-46]
  - Makes New-Fixture -Path option more resilient [GH-114]
  - Make the New-Fixture input accept any path and output objects
  - Move New-Fixture to separate script
  - Remove Write-UsageForNewFixture
  - Fix Should Throw filtering by exception message [GH-125]
  
## 2.0.3 (Apr 16, 2013)

  - Fixed line number reported in pester failure when using new pipelined
    should assertions [GH-40]
  - Added describe/context scoping for mocks [GH-42]

## 2.0.2 (Feb 28, 2013)

  - Fixed exit code bug that was introduced in version 2.0.0

## 2.0.1 (Feb 3, 2013)

  - Renamed -EnableLegacyAssertions to -EnableLegacyExpectations

## 2.0.0 (Feb 2, 2013)

  - Functionality equivalent to 1.2.0 except legacy assertions disabled by
    default. This is a breaking change for anyone who is already using Pester

## 1.2.0 (Feb 2, 2013)

  - Fixing many of the scoping issues [GH-9]
  - Ability to tag describes [GH-35]
  - Added new assertion syntax (eg: 1 | Should Be 1)
  - Added 'Should Throw' assertion [GH-37]
  - Added 'Should BeNullOrEmpty' assertion [GH-39]
  - Added negative assertions with the 'Not' keyword
  - Added 'Match' assertion
  - Added -DisableOldStyleAssertions [GH-19] and [GH-27]
  - Added Contain assertion which tests file contents [GH-13]

## 1.1.1 (Dec 29, 2012)

  - Add should.not_be [GH-38]

## 1.1.0 (Nov 4, 2012)

  - Add mocking functionality [GH-26]

## Previous

This changelog is inspired by the
[Vagrant](https://github.com/mitchellh/vagrant/blob/master/CHANGELOG.md) file.
Hopefully this will help keep the releases tidy and understandable.

