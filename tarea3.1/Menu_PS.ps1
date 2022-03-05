# Edwin Soto Arregoitia, Adrian Alejandro Treviño Bautista,Sofia Flores Cisneros 
import-module -name ModuloT 
clear-host 
function get-menu{
$Menu= Read-Host "Elige una opcion: 
1:¿Deseas ver las reglas de bloqueo?
2:¿Desea Agregar Reglas de Bloqueo?                                               
3:¿Deseas Eliminar Reglas de Bloqueo?                                                                                               
4:¿Desea ver status de perfil?
5:¿Desea cambiar el Status del Perfil?
6:¿Desea ver su perfil actual de red?
7:¿Desea cambiar su perfil actual de red?
8:salida                                                                         
Opción"
clear-host
Switch($Menu){
  1{Get-ReglasBloqueo}
  2{Add-ReglasBloqueo}
  3{Remove-ReglasBloqueo}
  4{Get-StatusPerfil}
  5{Set-Statusperfil}
  6{Get-PerfilRedActual}
  7{Set-PerfilRedActual}
  8{Exit}
  Default {Write-Host "Opción no valida" -ErrorAction SilentlyContinue}
}}
do{
  get-menu
  }while($true)
 








