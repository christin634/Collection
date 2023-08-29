@echo off
CHCP 65001
for /f "delims=" %%s in ('"D:\VMware\VMware Workstation\\vmrun.exe" list^|findstr vmx') do (
    "D:\VMware\VMware Workstation\\vmrun.exe" suspend "%%s"
)
taskkill /F /IM vmware.exe
exit