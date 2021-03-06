@ECHO OFF

MODE CON: COLS=120 LINES=35
TITLE Installing Console...

CD /D %~dp0

SET POWERSHELLSWITCHES=-NoProfile -NonInteractive -ExecutionPolicy RemoteSigned

powershell.exe %POWERSHELLSWITCHES% -File .\Install.ps1 -PreReqCheck
IF ERRORLEVEL 1 GOTO END

%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe %POWERSHELLSWITCHES% -File .\Install.ps1 -Specific
%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe %POWERSHELLSWITCHES% -File .\Install.ps1 -Specific
powershell.exe %POWERSHELLSWITCHES% -File .\Install.ps1 -Mixed

:END
PAUSE