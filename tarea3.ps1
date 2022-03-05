

$serviceName = 'wuauserv'
$serviceInfo = Get-Service -Name $serviceName

if($serviceInfo.Status -eq "Running")
{
   
    Write-Host "El servicio " $serviceName " está ejecutándose"
}


if($serviceInfo.Status -eq "Running")
{
 
    Write-Host "El servicio " $serviceName " está ejecutándose"
}
else{
    Write-Host "El servicio " $serviceName " está detenido"
}


if($serviceInfo.Status -eq "Running")
{
    
    Write-Host "El servicio " $serviceName " está ejecutándose"
    Stop-Service -Name $serviceName
}
elseif($serviceInfo.Status -eq "Stopped"){
    Write-Host "El servicio " $serviceName " está detenido"
    Start-Service -Name $serviceName
}
else{
    Write-Host "El servicio " $serviceName " está suspendido"
}

Write-Host "Fin!"
Get-Service -Name $serviceName
Write-Host $serviceInfo.Status
