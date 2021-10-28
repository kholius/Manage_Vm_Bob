#!/bin/bash



# make backup VM
# transfert backup HpV1 to HpV2
# restore VM


# Qu recup info
read -p "IP du nouvel Hyperviseur ? " ip_new_hyprvs
read -p " Nom du profil Root du second hyperviseur " name_cbob_root2





# faire une Backup de la VM selectionnée en cours
make_backup(){

    echo " Oh shit, here we go agaiiin ..."

    cd /var/lib/vz/dump/

    vzdump $id_vm

}

# transférer la dite VM sur le nouvel Hyperviseur
transfert_backup(){

    ls -l | grep $id_vm

    echo $?

    scp /var/lib/vz/dump/* $name_cbob_root2@$ip_new_hyprvs://mnt/pve/cephfs/to_restore/

    echo " Clean Inbound "
    rm -rf /var/lib/vz/dump/*
    echo " Done "
}

#restore_VM(){

#}

# boucle for qui effectue l'action
for id_vm in 101 102 103 104 105 110 125 126 128 129 132 134 135 136 137 138 161 191 200 292 295 293 294
do
  echo " VM $id_vm en cours "

  ping -c 5 $ip_new_hyprvs

  make_backup

  sleep 15

  transfert_backup

  sleep 15 

done
