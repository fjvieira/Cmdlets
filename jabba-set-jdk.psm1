# This module sets the JDK version in use by Jabba and sets 
# the JAVA_HOME environment variable to the selected JDK version.
# PS: It requires administrator privileges.

Function Set-JDK {
  [CmdletBinding()]

  param(
    # Mandatory parameter for JDK version
    [Parameter()]
    [string] $JdkVersion
    
  )

  begin {
    # Check if Jabba is available in PATH
    $jabbaCommand = Get-Command -Name "jabba" -ErrorAction SilentlyContinue
    if (!($jabbaCommand)) {
      Write-Error "Jabba not found in PATH. Please install or add Jabba to your PATH environment variable."
      throw 'Jabba not found'
    }
  }

  process {
    # Write message about running Jabba command
    Write-Host "Configuring environment for JDK: $JdkVersion"

    # Check if a valid JDK version was provided, if not, list installed versions
    if ((-not $JdkVersion) -or !(jabba ls | Select-String -Pattern $JdkVersion)) {
      Write-Error -Message "Param does not match any installed JDK versions"
      $jabbaOutput = (jabba ls | ForEach-Object { $_ -replace '\e\[\d+m', '' }) -join "`n"
      Write-Host "Installed versions:`n`n$jabbaOutput"
    }
    else {
      # Use Jabba to set the default JDK
      jabba use $JdkVersion

      # Set the JAVA_HOME env var
      [Environment]::SetEnvironmentVariable('JAVA_HOME', "$(jabba which $(jabba current))", 'Machine')

    }

  }

  end { }

}