FROM quay.io/fedora/fedora-coreos:testing
LABEL maintainer="Shion Tanaka / tnk4on.github.io"
COPY rosetta.conf /etc/binfmt.d/rosetta.conf
COPY rosetta.service /etc/systemd/system/rosetta.service
RUN systemctl enable rosetta.service
RUN ostree container commit