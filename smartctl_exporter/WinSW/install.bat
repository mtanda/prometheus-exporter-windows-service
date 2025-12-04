@echo off
pushd %~dp0\..\
setlocal

WinSW-smartctl_exporter.exe install

endlocal
popd
exit /b
