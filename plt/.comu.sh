#!/bin/bash
# 27-06-2018
# cosmogat
# .comu.sh
# Coses comunes als guions

function info {
    echo "Utilitzar:"
    echo "$0 [op]"
    echo "On [op] és:"
    echo -e "\t 0 -> Tots els mètodes."
    echo -e "\t 1 -> Mètodes 1-4"
    echo -e "\t 2 -> Mètodes 5-7"
    echo -e "\t 3 -> Mètodes 8-14 i 24, 25"
    echo -e "\t 4 -> Mètodes 15-17"
    echo -e "\t 5 -> Mètodes 18-23"
    echo -e "\t 6 -> Mètodes prova"
}

OPC=0
CONF="ext18"
FITX=()
METO=()
PAS=()

if [ $# -gt 1 ] ; then
    info
    exit 1
elif [ $# -eq 1 ] ; then
    OPC=$1
fi

case $OPC in
    0)
	DIR_ANT=$PWD
	cd ../src
	for i in $(ls *.c) ; do
	    if [ "$i" != "solar.c" ] ; then
		NOM_FIT=$(basename $i .c)
		FITX+=($NOM_FIT)
	    fi
	done
	cd $DIR_ANT
	;;
    1)
	FITX[0]="01_expl"
	FITX[1]="02_simp"
	FITX[2]="03_stor"
	FITX[3]="04_llib"
	PAS[0]=300
	PAS[1]=200
	PAS[2]=100
	PAS[3]=50
	PAS[4]=10
	;;
    2)
	FITX[0]="05_rk-4"
	FITX[1]="06_rkn4"
	FITX[2]="07_rkg4"
	PAS[0]=500
	PAS[1]=200
	PAS[2]=100
	PAS[3]=50
	PAS[4]=10
	;;
    3)
	FITX[0]="08_tjc4"
	FITX[1]="09_ss45"
	FITX[2]="10_ss69"
	FITX[3]="11_ss817"
	FITX[4]="12_s46"
	FITX[5]="13_s46s"
	FITX[6]="14_nb46"
	PAS[0]=2000
	PAS[1]=500
	PAS[2]=200
	PAS[3]=100
	PAS[4]=50
	PAS[5]=10
	;;
    4)
	FITX[0]="15_nia2"
	FITX[1]="16_nia5"
	FITX[2]="17_nia8"
	PAS[0]=5000
	PAS[1]=2000
	PAS[2]=1000
	PAS[3]=500
	PAS[4]=300
	PAS[5]=200
	PAS[6]=100
	PAS[7]=50
	PAS[8]=10
	;;
    5)
	FITX[0]="18_pss613"
	FITX[1]="19_ps44"
	FITX[2]="20_ps44s"
	FITX[3]="21_pn42"
	FITX[4]="22_pm411"
	FITX[5]="23_pni3"
	PAS[1]=300
	PAS[2]=200
	PAS[3]=100
	PAS[4]=50
	PAS[5]=10
	PAS[6]=1
	;;
    6)
	FITX[0]="08_tjc4"
	FITX[1]="03_stor"
	FITX[2]="24_s53"
	FITX[3]="25_s22"
	FITX[4]="26_s44"
	PAS[0]=2000
	PAS[1]=500
	PAS[2]=200
	PAS[3]=100
	PAS[4]=50
	PAS[5]=10
	;;    
    *)
	info
	exit 2
	;;
esac

for i in ${FITX[@]} ; do
    NOM_MET=$(echo $i | cut -d'_' -f2)
    METO+=($NOM_MET)
done
