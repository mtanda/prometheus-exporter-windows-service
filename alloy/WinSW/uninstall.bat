@echo off
pushd %~dp0\..\
setlocal

WinSW-alloy.exe uninstall

endlocal
popd
exit /b
