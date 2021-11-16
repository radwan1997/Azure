#
# Windows PowerShell script for AD DS Deployment
#
Configuration addc {
  Node "myvm" {
    WindowsFeature MyFeatureInstance {
      Ensure = 'Present'
      Import-Module ADDSDeployment
	Install-ADDSForest `
	-CreateDnsDelegation:$false `
	-DatabasePath "C:\Windows\NTDS" `
	-DomainMode "WinThreshold" `
	-DomainName "boo.com" `
	-DomainNetbiosName "BOO" `
	-ForestMode "WinThreshold" `
	-InstallDns:$true `
	-LogPath "C:\Windows\NTDS" `
	-NoRebootOnCompletion:$false `
	-SysvolPath "C:\Windows\SYSVOL" `
	-Force:$true


    }
  }
}

	