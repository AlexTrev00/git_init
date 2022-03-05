function Get-ReglasBloqueo{
    if(Get-netfirewallRule -action block -enabled true -ErrorAction SilentlyContinue){
        get-netfirewallrule -action block -enabled true 
}   else{
    write-host 'no hay reglas definidas aun'
}
}

function Get-PerfilRedActual{
    try{
    $perfilred = get-netconnectionprofile
    write-host 'nombre de red:' $perfilred.name
    write-host 'perfil de red:' $perfilred.networkcategory
    }catch{
        write-host "Ocurrio un error"
    }
}

function Get-StatusPerfil{
    param([Parameter(Mandatory)] [ValidateSet("Public","Private")] [string] $perfil)
    $status = Get-NetFirewallProfile -Name $perfil
    Write-Host "Perfil:" $perfil
    if($status.enabled){
        Write-Host "Status: Activado"
    } else{
        Write-Host "Status: Desactivado"       
    }
}

function Set-StatusPerfil{ 
	param([Parameter(Mandatory)] [ValidateSet("Public","Private")] [string] $perfil) 
	$status = Get-NetFirewallProfile -Name $perfil 
	Write-Host "Perfil:" $perfil 
	if($status.enabled){ 
		Write-Host "Status actual: Activado" 
		$opc = Read-Host -Promt "Deseas desactivarlo? [Y] Si [N] No" 
		if ($opc -eq "Y"){ 
			Set-NetFirewallProfile -Name $perfil -Enabled False 
		} 
	} else{ 
		Write-Host "Status: Desactivado" 
		$opc = Read-Host -Promt "Deseas activarlo? [Y] Si [N] No" 
		if ($opc -eq "Y"){ 
			Write-Host "Activando perfil" 
			Set-NetFirewallProfile -Name $perfil -Enabled True 
		} 
	} 
	Get-StatusPerfil -perfil $perfil 
} 


function Set-PerfilRedActual{
    $perfilred = Get-NetConnectionProfile
    if($perfilred.network -eq 'Public'){
        Write-Host 'Perfil: Public'
        $opc = Read-Host -Prompt '¿Quieres Cambiarlo a Privado? [Y] YES, [N] NO'
            if($opc -eq 'y' -or 'yes' ){
                Set-NetConnectionProfile -Name $perfilred.Name -NetworkCategory Private
                Write-Host 'perfil: Privado'
    
            }
    }else{
        Write-Host 'Perfil: Privado'
        $opc = Read-Host -Prompt '¿Quieres Cambiarlo a Public? [Y] YES, [N] NO'
        if($opc -eq 'y' -or 'yes'){
            Set-NetConnectionProfile -Name $perfilred.Name -NetworkCategory Public
            Write-Host 'Perfil: Public'
        }
    }
    Get-PerfilRedActual
}


function Add-ReglasBloqueo{
    $puerto = Read-Host -Prompt "Cuál puerto quieres bloquear?" 
	New-NetFirewallRule -DisplayName "Puerto-Entrada-$puerto" -Profile "Public" -Direction Inbound -Action Block -Protocol TCP -LocalPort $puerto 
}
	


function Remove-ReglasBloqueo{  

$reglas = Get-NetFirewallRule -Enabled True  -ErrorAction:silentlycontinue  

Write-Host "Reglas actuales"  

foreach($regla in $reglas){  

Write-Host "Regla:" $regla.DisplayName  

Write-Host "Perfil:" $regla.Profile  

Write-Host "ID:" $regla.Name  

$opc = Read-Host -Prompt "Deseas eliminar esta regla [Y] Si [N] No"  

if($opc -eq "Y"){  

Remove-NetFirewallRule -ID $regla.name  

break  

}  

}  

} 












