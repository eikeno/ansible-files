#!/bin/bash
# generate variant package list for hosts using different GPU and drivers

for i in nvidia amd nouveau; do
    echo "i: $i"
    case $i in
        nouveau)
            ANSIBLE_HOST_GPU_DRIVER=nouveau j2 -f env pacman.j2 | grep -v ^$ > pacman_pkgs__nouveau.txt
            ANSIBLE_HOST_GPU_DRIVER=nouveau j2 -f env aur.j2 | grep -v ^$ > aur_pkgs__nouveau.txt
        ;;

        nvidia)
            ANSIBLE_HOST_GPU_DRIVER=nvidia j2 -f env pacman.j2 | grep -v ^$ > pacman_pkgs__nvidia.txt
            ANSIBLE_HOST_GPU_DRIVER=nvidia j2 -f env aur.j2 | grep -v ^$ > aur_pkgs__nvidia.txt
        ;;

        amd)
            ANSIBLE_HOST_GPU_DRIVER=amd j2 -f env pacman.j2 | grep -v ^$ > pacman_pkgs__amd.txt
            ANSIBLE_HOST_GPU_DRIVER=amd j2 -f env aur.j2 | grep -v ^$ > aur_pkgs__amd.txt
        ;;

    esac
done

