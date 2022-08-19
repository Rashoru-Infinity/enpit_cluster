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

exp-board:
	microk8s kubectl get svc kubernetes-dashboard -n kube-system -o yaml | sed -z "s/ports:\n  - port: 443\n/ports:\n  - nodePort: 32000\n    port: 443\n/g" | sed "s/type: ClusterIP/type: NodePort/g" | microk8s kubectl apply -f -

stop:
	microk8s stop

remove: stop
	sudo snap remove microk8s; sudo groupdel microk8s; su - $$USER