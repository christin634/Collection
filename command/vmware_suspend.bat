@echo off
CHCP 65001
for /f "delims=" %%s in ('"path\\to\\vmrun.exe" list^|findstr vmx') do (
    "path\\to\\vmrun.exe" suspend "%%s"
)
taskkill /F /IM vmware.exe
exit
