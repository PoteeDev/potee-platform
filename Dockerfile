FROM alpine:3

ARG MITOGEN_VERSION=0.3.0

WORKDIR /platform
# install terrafrom
RUN apk --no-cache add terraform --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community
# install ansible
RUN apk --update --no-cache add \
        ca-certificates \
        git \
        openssh-client \
        openssl \
        python3\
        py3-pip \
        py3-cryptography \
        rsync \
        sshpass \ 
        curl 
RUN pip install ansible netaddr requests
RUN curl -s -L https://github.com/mitogen-hq/mitogen/archive/refs/tags/v${MITOGEN_VERSION}.tar.gz | tar xzf - -C /opt
COPY deploy/ deploy/
# RUN ansible-galaxy install -r ./deploy/ansible/requirements.yaml
COPY deploy.sh .
RUN chmod +x deploy.sh

ENTRYPOINT [ "/bin/ash", "deploy.sh" ]

