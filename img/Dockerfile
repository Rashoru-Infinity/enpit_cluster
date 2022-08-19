FROM hisazumi/aprisrc-sitl

RUN cp -r /home/ubuntu /home/template && \
    sed -i -z 's@#!/bin/bash\n@#!/bin/bash\n \
    if [ \$(ls -la /home/ubuntu | wc -l) = 3 ]; then\n \
        rsync -l -r /home/template/ /home/ubuntu/\n \
    fi\n@' /startup.sh