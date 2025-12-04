@echo off
pushd %~dp0\..\
setlocal

WinSW-smartctl_exporter.exe uninstall

endlocal
popd
exit /b
