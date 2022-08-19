all: build save import clean

build:
	docker build -t rashoru/aprisrc-sitl .

save:
	docker save rashoru/aprisrc-sitl > image.tar

import:
	microk8s ctr image import image.tar

clean:
	rm -f image.tar