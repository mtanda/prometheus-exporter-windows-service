# Prometheus Exporter Windows Service

This repository contains configuration files to run Prometheus exporters as Windows services using [WinSW (Windows Service Wrapper)](https://github.com/winsw/winsw).

## Overview

This repository provides pre-configured service definitions for:

- **Grafana Alloy** - Modern telemetry data collector
- **smartctl_exporter** - SMART disk monitoring exporter for Prometheus

The configuration files allow you to easily run these exporters as Windows services without manual startup.

## Prerequisites

### Required Software

- **smartmontools**: Install using winget:

  ```cmd
  winget install smartmontools.smartmontools -s winget
  ```

### Required Downloads

You need to download the following components from their respective repositories:

1. **WinSW executable** from [winsw/winsw](https://github.com/winsw/winsw)
2. **Grafana Alloy** from [grafana/alloy](https://github.com/grafana/alloy)
3. **smartctl_exporter** from [prometheus-community/smartctl_exporter](https://github.com/prometheus-community/smartctl_exporter)

## Installation

### 1. Download Required Binaries

Download the following files and place them in the specified locations:

- Download `WinSW.exe` and rename/copy it as:
  - `alloy/WinSW-alloy.exe`
  - `smartctl_exporter/WinSW-smartctl_exporter.exe`
- Download `alloy-windows-amd64.exe` and place it in `alloy/bin/`
- Download `smartctl_exporter.exe` and place it in `smartctl_exporter/bin/`

### 2. Final Directory Structure

After downloading all required files, your directory structure should look like this:

```text
alloy/
├── WinSW/
│   ├── install.bat
│   └── uninstall.bat
├── WinSW-alloy.exe
├── WinSW-alloy.xml
├── bin/
│   └── alloy-windows-amd64.exe
└── config.alloy

smartctl_exporter/
├── WinSW/
│   ├── install.bat
│   └── uninstall.bat
├── WinSW-smartctl_exporter.exe
├── WinSW-smartctl_exporter.xml
└── bin/
    └── smartctl_exporter.exe
```

### 3. Install Services

#### Grafana Alloy Service

```cmd
cd alloy/WinSW
install.bat
```

#### smartctl_exporter Service

```cmd
cd smartctl_exporter/WinSW
install.bat
```

### 4. Uninstall Services

If you need to remove the services:

#### Remove Grafana Alloy Service

```cmd
cd alloy/WinSW
uninstall.bat
```

#### Remove smartctl_exporter Service

```cmd
cd smartctl_exporter/WinSW
uninstall.bat
```

## Configuration

### Grafana Alloy

The Alloy configuration is located in `alloy/config.alloy`. Modify this file according to your monitoring requirements.

#### Remote Write Configuration

The configuration includes a Grafana Cloud remote write endpoint that needs to be customized for your environment. Update the following in `config.alloy`:

- Remote write URL
- Authentication credentials
- Any other environment-specific settings

**Note:** If remote write is configured, the setup can work with both Prometheus and Grafana Cloud as the destination.

### smartctl_exporter

The smartctl_exporter service is configured through the `smartctl_exporter/WinSW-smartctl_exporter.xml` file. The default configuration should work with standard smartmontools installations.

#### Device Configuration

You may need to configure specific device names for your system. To find available devices, run:

```cmd
smartctl.exe --scan
```

Update the device configuration in the service XML file or exporter arguments as needed based on the output of the scan command.

## Service Management

Once installed, you can manage the services through:

1. **Windows Services** (`services.msc`)
2. **Command line** using `sc` commands
3. **PowerShell** service cmdlets

The services will be named:

- `alloy`
- `smartctl_exporter`

## Troubleshooting

### Check Service Status

```cmd
sc query alloy
sc query smartctl_exporter
```

### View Service Logs

Service logs are typically stored in the respective service directories under `WinSW/logs/`.

### Common Issues

- Ensure all executable files have proper permissions
- Verify that smartmontools is properly installed and accessible
- Check that the configuration files are valid
- Ensure Windows Service permissions are correctly set

## Links

- [WinSW (Windows Service Wrapper)](https://github.com/winsw/winsw)
- [Grafana Alloy](https://github.com/grafana/alloy)
- [smartctl_exporter](https://github.com/prometheus-community/smartctl_exporter)
- [smartmontools](https://www.smartmontools.org/)
- [Windows Exporter Dashboard](https://grafana.com/grafana/dashboards/14694-windows-exporter-dashboard/) - Grafana dashboard for Windows monitoring
