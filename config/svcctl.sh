#!/bin/bash

function update() {
    sed "s/suffix/$1/g" template.yaml | sed "s/svcPort/$((29999+$1))/g" | microk8s kubectl apply -f - &
}

function update_range() {
    for i in $(seq $1 $2); do
        update $i
    done;
}

function delete() {
    sed "s/suffix/$1/g" template.yaml | sed "s/svcPort/$((29999+$1))/g" | microk8s kubectl delete -f - &
}

function delete_range() {
    for i in $(seq $1 $2); do
        delete $i
    done;
}

function print_default() {
    sed "s/suffix/$1/g" template.yaml | sed "s/svcPort/$((29999+$1))/g"
}

function edit_svc() {
    microk8s kubectl edit svc -n ros-vnc-$1
}

function edit_deployment() {
    microk8s kubectl edit deployment -n ros-vnc-$1
}

function edit_pvc() {
    microk8s kubectl edit pvc -n ros-vnc-$1
}

case $1 in
    update) update $2 ;;
    update_range) update_range $2 $3 ;;
    delete) delete $2 ;;
    delete_range) delete_range $2 $3 ;;
    print) print_default $2 ;;
    edit_svc) edit_svc $2 ;;
    edit_deployment) edit_deployment $2 ;;
    edit_pvc) edit_pvc $2 ;;
esac
