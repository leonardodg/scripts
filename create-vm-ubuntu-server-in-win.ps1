$VMName = "Ubuntu-SERVER"
$VMPath = "D:\Hyper-V\$VMName"
$BootISO = "D:\ISOs\ubuntu-24.04-live-server-amd64.iso"
# $VHDPath = "$VMPath\$VMName.vhdx"
$SwitchName = "MyVirtualSwitch"
$RAM = 2GB
$StorageSize = 20GB
$ProcessorCount = 2

$VM = @{
    Name = $VMName
    MemoryStartupBytes = $RAM
    Generation = 2
    NewVHDPath = "$VMPath\$VMName.vhdx"
    BootDevice = "VHD"
    SwitchName = "VirtualSwitch"
    ProcessorCount = $ProcessorCount
}

# Create the VM
New-VM @VM
$VM = Get-VM -Name $VMName
$VM | Set-VM -ProcessorCount $ProcessorCount -AutomaticCheckpointsEnabled 0
$VM | Add-VMDvdDrive -Path $BootISO
Set-VMMemory -VMName $VMName -DynamicMemoryEnabled $false

$VMDvdDrive = $VM | Get-VMDvdDrive
$VM | Set-VMFirmware -FirstBootDevice $VMDvdDrive -EnableSecureBoot Off

$VM | Start-VM