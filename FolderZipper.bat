::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFD9dQQ+NAE+/Fb4I5/jHyeWLpkgPbusvaIrJlLGWJYA=
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
color 0a
cls
chcp 65001 >nul
title Folder Zipper ^| v1.0

:: User-Interface
echo.
echo                        ╔════════════════════════════════╗
echo                        ║         Folder Zipper          ║
echo                        ╠════════════════════════════════╣
echo                        ╚════════════════════════════════╝
echo.
echo                        ╔════════════════════════════════╗
echo                        ║                                ║
echo                        ║                                ║
echo                        ║      Drag a folder here!       ║
echo                        ║                                ║
echo                        ║                                ║
echo                        ╚════════════════════════════════╝
echo.
echo.


:WaitForDragDrop
:: Wait for the user to drag and drop a folder
set /p folder=Path:

:: Check if the folder exists
if not exist "%folder%" (
    echo Error: The specified folder does not exist.
    pause
    exit /b
)

:ProcessFolder
:: Get the path of the script's directory
set "scriptDir=%~dp0"

:: Extract the folder name from the path
for %%i in ("%folder%") do set folderName=%%~nxi

:: Set the output ZIP file path (save in the script's directory)
set "zipfile=%scriptDir%%folderName%.zip"

:: Create the ZIP file
echo Creating ZIP file: %zipfile%
powershell Compress-Archive -Path "%folder%\*" -DestinationPath "%zipfile%" 2>nul

:: Check if the ZIP was created
if exist "%zipfile%" (
    echo.
    echo Folder successfully zipped as "%zipfile%"
    echo.
    powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Folder Zipper', 'Your ZIP Archive is ready!', [System.Windows.Forms.ToolTipIcon]::None)}"

) else (
    echo Error: Failed to create the ZIP file.
    powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Error; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Folder Zipper', 'Something went wrong creating your ZIP Archive!', [System.Windows.Forms.ToolTipIcon]::None)}"
)

:: Pause to see the result
pause
exit
