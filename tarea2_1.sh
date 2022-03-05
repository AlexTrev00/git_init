#!/bin/bash -
'''
Script en bash que reune informacion general del sistema y la guarda 
en un archivo.

Modo de uso:
bash tarea2_1.sh < cmds.txt

sepcmds: separa los comandos de la linea de salida
'''
function SepCmds()
{
      LCMD=${ALINE%%|*}                   # <11>
      REST=${ALINE#*|}                    # <12>
      WCMD=${REST%%|*}                    # <13>
      REST=${REST#*|}
      TAG=${REST%%|*}                     # <14>
      
      if [[ $OSTYPE == "MSWin" ]]
      then
         CMD="$WCMD"
      else
         CMD="$LCMD"
      fi
}

function DumpInfo ()
{                                                              # <5>
    printf '<systeminfo host="%s" type="%s"' "$HOSTNAME" "$OSTYPE"
    printf ' date="%s" time="%s">\n' "$(date '+%F')" "$(date '+%T')"
    readarray CMDS                           # <6>
    for ALINE in "${CMDS[@]}"                # <7>
    do
       # ignore comments
       if [[ ${ALINE:0:1} == '#' ]] ; then continue ; fi     # <8>

      SepCmds

      if [[ ${CMD:0:3} == N/A ]]             # <9>
      then
          continue
      else
          printf "<%s>\n" $TAG               # <10>
          $CMD
          printf "</%s>\n" $TAG
      fi
    done
    printf "</systeminfo>\n"
} 

OSTYPE=$(./osdetect.sh)                     # <1>
HOSTNM=$(hostname)                          # <2>
TMPFILE="${HOSTNM}.info"                    # <3>

# gather the info into the tmp file; errors, too
DumpInfo  > $TMPFILE  2>&1                  # <4>
