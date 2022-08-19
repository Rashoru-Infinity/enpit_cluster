COMMA	:= ,

build:
	$(MAKE) -C img all

update-range:
	cd config; ./svcctl.sh update_range $(subst $(COMMA), ,$(RANGE)); cd ../

delete-range:
	cd config; ./svcctl.sh delete_range $(subst $(COMMA), ,$(RANGE)); cd ../

setup:
	sudo snap install microk8s --classic --channel=1.24

group:
	sudo usermod -a -G microk8s $$USER; sudo chown -f -R $$USER ~/.kube; newgrp microk8s

dns:
	microk8s enable dns

storage:
	microk8s enable storage

dashboard:
	microk8s enable dashboard