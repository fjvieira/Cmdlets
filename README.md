# Cmdlets

This repository contains PowerShell Cmdlets to automate the development environment setup.

## Jabba Set JDK

Managing JVMs in Windows is an unglamorous task.
[Jabba](https://github.com/shyiko/jabba) is a cross-platform version manager that handles it well, but the tool requires some additional commands each time
you change versions.

To mitigate this, the `jabba-set-jdk.psm1` module makes the `SET-JDK` command available.

### Requirements

- Jabba or one of its forks installed. I recommend this [one](https://github.com/Jabba-Team/jabba).
- Set up Jabba as described in the documentation (including PowerShell commands).
- Run the cmdlet as an administrator.

### Usage

```powershell
SET-JDK <Jabba JDK valid version or alias>
```

Using `SET-JDK` without arguments will lead to a PowerShell exception and
an output list with Jabba installed SDKs (`jabba ls` command output).

### Import a module by default

You can configure PowerShell to load modules by default through:

- Edit or create the file located at:
C:\Users\\*username*\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
- Add the following script (change the base directory):

```powershell
$jabbaSetJdkModule = "<Base dir>\Cmdlets\jabba-set-jdk.psm1"
if (Test-Path $jabbaSetJdkModule) {
  Import-Module $jabbaSetJdkModule
}
```
