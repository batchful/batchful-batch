title batchful
color 0a
@echo off

goto Logo
goto Ask

:Logo
:::   _             _         _       __         _ 
:::  | |__    __ _ | |_  ___ | |__   / _| _   _ | |
:::  | '_ \  / _` || __|/ __|| '_ \ | |_ | | | || |
:::  | |_) || (_| || |_| (__ | | | ||  _|| |_| || |
:::  |_.__/  \__,_| \__|\___||_| |_||_|   \__,_||_|
:::
:::

for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A

:AskSubFolders
echo This program organizes folders. place this file in the directory you wish to organize and run it.
echo Choose a method of organization:

echo Search sub-folders? [Y/N]
echo WARNING: IF YOU CHOOSE TO SEARCH SUB-FOLDERS, ALL OFF YOUR SUB-FOLDERS WILL GET DELETED (THEIR CONTENT WILL NOT).

set /p answer=""

if %answer% == Y goto SubFolder

:AskMethod
echo This program organizes folders. place this file in the directory you wish to organize and run it.
echo Choose a method of organization:

echo 1. By file extensions.
echo 2. By file names.
echo.

echo Press g for the GitHub repository page and q to exit the program.

set /p answer=""

if %answer% == 1 goto ByExt 
if %answer% == 2 goto ByName
if %answer% == g goto GitHub
if %answer% == q exit /b
rem if %answer% == 3 goto BySyn 

goto Ask

:SubFolder
for /r %%g in (*.*) do move "%%g" "%cd%"

for /d /r %%g in (*.*) do @RD /S /Q "%%g"

goto AskMethod

:ByExt
for %%a in (".\*") do (
    rem check if the file has an extension and if it is not our script
    if "%%~xa" NEQ ""  if "%%~dpnxa" NEQ "%~dpnx0" (
        rem check if extension forlder exists, if not it is created
        if not exist "%%~xa" mkdir "%%~xa"
        rem Copy (or change to move) the file to directory
        move "%%a" "%%~dpa%%~xa\"
    )
)

goto CommitExit

:ByName
for %%i in (*) do (
    if "%%~xa" NEQ ""  if "%%~dpnxa" NEQ "%~dpnx0" (
        if not exist "%%~ni" md "%%~ni" 
        move "%%~i" "%%~ni"
    )
)

:GitHub
rem goto Logo

echo Made by 3174N and SFR-git
echo.
goto GitHubAsk

:GitHubAsk
echo Open GitHub? [Y/N]
set /p open = ""
if /I %open% == Y goto OpenGit
if /I %open% == yes goto OpenGit
if /I %open% == N goto Ask
if /I %open% == no goto Ask
else goto GitHubRe

:GitHubRe
echo "Couldn't understand the response. Possible answers: [Y/n/yes/no]"
goto GitHubAsk

rem :BySyn
rem echo Function not avilable yet

rem goto CommitExit

:OpenGit
start https://github.com/3174N/batchful.git

goto CommitExit

:CommitExit
Set /p P= Press the enter to exit ...