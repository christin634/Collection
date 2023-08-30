@echo off

:: Define the available Java versions and their corresponding JAVA_HOME paths
set "versions[1]=%JAVA5_HOME%"
set "versions[2]=%JAVA8_HOME%"
set "versions[3]=%JAVA11_HOME%"
set "versions[4]=%JAVA17_HOME%"

:: Prompt user to select the desired Java version
echo Select the Java version:
echo 1. Java 5
echo 2. Java 8
echo 3. Java 11
echo 4. Java 17
set /p selection="Enter the index number: "

:: Validate the user input
if "%selection%"=="1" (
    set "JAVA_HOME=%versions[1]%"
) else if "%selection%"=="2" (
    set "JAVA_HOME=%versions[2]%"
) else if "%selection%"=="3" (
    set "JAVA_HOME=%versions[3]%"
) else if "%selection%"=="4" (
    set "JAVA_HOME=%versions[4]%"
) else (
    echo Invalid selection! Exiting...
    exit /b 1
)

:: Set the JAVA_HOME environment variable
ver | findstr /i "10\." > nul
if %errorlevel% equ 0 (
    setx -m JAVA_HOME "%JAVA_HOME%"
) else (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v JAVA_HOME /t REG_SZ /d "%JAVA_HOME%" /f
)

:: Verify the JAVA_HOME value
set | findstr /i "JAVA_HOME"
echo JAVA_HOME has been successfully set to %JAVA_HOME%
pause