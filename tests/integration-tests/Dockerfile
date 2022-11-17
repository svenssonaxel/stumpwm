FROM ubuntu:20.04

ENV STUMPWM_CI=yes

USER root
WORKDIR /root

ENV DISPLAY=":7"
ARG userUID
RUN if [ $userUID -ne 0 ]; then useradd -u $userUID -m -s /bin/bash user; fi

COPY tests/integration-tests/container-scripts/install-deps .
RUN ./install-deps

COPY . stumpwm
ARG userNAME
ARG userWORKDIR
RUN cd stumpwm \
    && mv tests/integration-tests/container-scripts/* /usr/local/bin/ \
    && mv tests/integration-tests/stumpwm.d $userWORKDIR/.stumpwm.d \
    && chown -R $userNAME:$userNAME $userWORKDIR/.stumpwm.d \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install

USER $userNAME
WORKDIR $userWORKDIR
