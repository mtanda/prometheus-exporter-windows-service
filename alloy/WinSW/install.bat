@echo off
pushd %~dp0\..\
setlocal

WinSW-alloy.exe install

endlocal
popd
exit /b
