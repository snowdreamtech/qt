FROM snowdreamtech/build-essential:bookworm


# QT
# 1+ Billion Devices and Applications Powered and Assured by Qt
#
# https://doc.qt.io
# https://doc.qt.io/qt-6.2/build-sources.html#linux-x11

# keep the docker container running
ENV KEEPALIVE=1 \
    SSH_ROOT_PASSWORD= \
    LLVM_VERSION=18 \
    QT_VERSION=6.2.10 \
    QT_MAJOR_MINOR_VERSION=6.2 \
    PATH=/usr/local/Qt-6.2.10/bin:$PATH

RUN cat /etc/os-release

RUN set -eux \  
    && apt-get -qqy update  \
    && apt-get -qqy install --no-install-recommends \ 
    lsb-release \
    wget  \
    software-properties-common \
    gnupg2 \
    lld \
    cmake \
    ninja-build \
    python3 \
    && apt-get -qqy --purge autoremove \
    && apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

COPY update-alternatives-llvm.sh /usr/local/bin/

RUN set -eux \
    && wget https://apt.llvm.org/llvm.sh \
    && chmod +x llvm.sh \
    && ./llvm.sh ${LLVM_VERSION} all \
    && update-alternatives-llvm.sh  "${LLVM_VERSION}" 100  >/dev/null 2>&1 \
    && rm llvm.sh 
     

# Base
RUN set -eux \
    && apt-get -qqy update  \
    && apt-get -qqy install \ 
    procps \
    sudo \
    vim \ 
    unzip \
    tzdata \
    openssl \
    wget \
    curl \
    iputils-ping \
    lsof \
    fonts-wqy-zenhei \
    fonts-wqy-microhei \
    apt-transport-https \
    ca-certificates \                                                                                                                                                                                                      
    && update-ca-certificates\
    && apt-get -qqy --purge autoremove \
    && apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    && sed -i "s|Suites:\s*bookworm\s*bookworm-updates.*|Suites: bookworm bookworm-updates bookworm-backports trixie sid experimental|g" /etc/apt/sources.list.d/debian.sources \
    && echo 'export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"' >> /etc/bash.bashrc 

# OpenSSH Server
RUN set -eux \
    && apt-get -qqy update  \
    && apt-get -qqy install --no-install-recommends \ 
    # -t trixie \
    # fastfetch \
    xauth \
    openssh-server \ 
    openssh-sftp-server \ 
    openssh-client \
    && mkdir -p /run/sshd \ 
    && sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config \ 
    && sed -i "s/^#PasswordAuthentication/PasswordAuthentication/g" /etc/ssh/sshd_config \ 
    && sed -i "s/^#PermitEmptyPasswords/PermitEmptyPasswords/g" /etc/ssh/sshd_config \ 
    && sed -i "s/^#HostKey/HostKey/g" /etc/ssh/sshd_config \ 
    && sed -i "s/^#PubkeyAuthentication/PubkeyAuthentication/g" /etc/ssh/sshd_config \ 
    && sed -i "s/^#IgnoreRhosts/IgnoreRhosts/g" /etc/ssh/sshd_config \ 
    && sed -i "s/^#StrictModes/StrictModes/g" /etc/ssh/sshd_config \ 
    && sed -i "s/#MaxAuthTries.*/MaxAuthTries 7/g" /etc/ssh/sshd_config \ 
    && sed -i "s/#MaxSessions.*/MaxSessions 10/g" /etc/ssh/sshd_config \ 
    && sed -i "s/#ClientAliveInterval.*/ClientAliveInterval 900/g" /etc/ssh/sshd_config \ 
    && sed -i "s/#ClientAliveCountMax.*/ClientAliveCountMax 0/g" /etc/ssh/sshd_config \ 
    && sed -i "s/Subsystem.*/Subsystem\tsftp\tinternal-sftp/g" /etc/ssh/sshd_config \
    && sed -i -E "s/#?AllowAgentForwarding.*/AllowAgentForwarding yes/g" /etc/ssh/sshd_config \
    && sed -i -E "s/#?AllowTcpForwarding.*/AllowTcpForwarding yes/g" /etc/ssh/sshd_config \
    && sed -i -E "s/#?AllowTcpForwarding.*/AllowTcpForwarding yes/g" /etc/ssh/sshd_config \
    && sed -i -E "s/#?GatewayPorts.*/GatewayPorts yes/g" /etc/ssh/sshd_config \
    && sed -i -E "s/#?X11Forwarding.*/X11Forwarding yes/g" /etc/ssh/sshd_config \
    && sed -i -E "s/#?X11DisplayOffset.*/X11DisplayOffset 10/g" /etc/ssh/sshd_config \
    && sed -i -E "s/#?X11UseLocalhost.*/X11UseLocalhost yes/g" /etc/ssh/sshd_config \
    && sed -i -E "s/#?PermitTTY.*/PermitTTY yes/g" /etc/ssh/sshd_config \
    && sed -i -E "s/#?PrintMotd.*/PrintMotd no/g" /etc/ssh/sshd_config \ 
    && sed -i -E "s/#?PrintLastLog.*/PrintLastLog yes/g" /etc/ssh/sshd_config \
    # && echo '#!/bin/sh' | tee /etc/update-motd.d/20-fastfetch \
    # && echo 'fastfetch --pipe false' | tee -a /etc/update-motd.d/20-fastfetch \
    # && chmod +x /etc/update-motd.d/20-fastfetch \
    && apt-get -qqy --purge autoremove \
    && apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

# Qt for X11 Requirements
# Platform Plugin Dependencies
RUN set -eux \
    && apt-get -qqy update  \
    && apt-get -qqy install \ 
    libfontconfig1-dev \
    libfreetype-dev \
    libx11-dev \
    libx11-xcb-dev \
    libxext-dev \
    libxfixes-dev \
    libxi-dev \
    libxrender-dev \
    libxcb1-dev \
    libxcb-glx0-dev \
    libxcb-keysyms1-dev \
    libxcb-image0-dev \
    libxcb-shm0-dev \
    libxcb-icccm4-dev \
    libxcb-sync-dev \
    libxcb-xfixes0-dev \
    libxcb-shape0-dev \
    libxcb-randr0-dev \
    libxcb-render-util0-dev \
    libxcb-util-dev \
    libxcb-xinerama0-dev \
    libxcb-xkb-dev \
    libxkbcommon-dev \
    libxkbcommon-x11-dev \
    && apt-get -qqy --purge autoremove \
    && apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

# Accessibility Dependencies
# The Qt accessibility implementation uses the Assistive Technology Service Provider Interface (AT-SPI). 
# Besides DBUS, the development package libatspi2.0-dev must be installed.
RUN set -eux \
    && apt-get -qqy update  \
    && apt-get -qqy install \ 
    libatspi2.0-dev \
    && apt-get -qqy --purge autoremove \
    && apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*    

# OpenGL Dependencies
# Configure attempts to automatically detect OpenGL ES 2.0, or later, or regular desktop OpenGL.
#  You can disable OpenGL support by using the -no-opengl option.
#
# Note: The Qt OpenGL module (which contains classes that start with QGL) has been deprecated in favor of the Qt GUI module
#  (which contains classes that start with QOpenGL).
RUN set -eux \
    && apt-get -qqy update  \
    && apt-get -qqy install \ 
    mesa-utils \
    libgles2-mesa-dev \
    libglfw3-dev  \
    freeglut3-dev \
    libglew-dev \
    libegl-dev \
    libegl1-mesa-dev \
    && apt-get -qqy --purge autoremove \
    && apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*    

# Download Qt source code and unzip it.
RUN wget -c https://mirrors.tuna.tsinghua.edu.cn/qt/archive/qt/${QT_MAJOR_MINOR_VERSION}/${QT_VERSION}/single/qt-everywhere-opensource-src-${QT_VERSION}.tar.xz \
    && tar xvf qt-everywhere-opensource-src-${QT_VERSION}.tar.xz 

# # Compile
RUN cd qt-everywhere-src-${QT_VERSION} \
    && ./configure \
    && cmake --build . --parallel $(nproc) \
    && cmake --install . \
    && rm -rfv qt-everywhere-opensource-src-${QT_VERSION}.tar.xz \
    && rm -rfv qt-everywhere-src-${QT_VERSION} \
    && echo 'export PATH=/usr/local/Qt-6.2.10/bin:$PATH' | tee -a /root/.bashrc 


COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]