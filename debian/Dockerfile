FROM snowdreamtech/build-essential:bookworm

ENV QT_VERSION=5.15.15 \
    QT_MAJOR_MINOR_VERSION=5.15

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
    libxcb-xinerama0-dev \
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
# RUN wget -c https://download.qt.io/official_releases/qt/${QT_MAJOR_MINOR_VERSION}/${QT_VERSION}/single/qt-everywhere-opensource-src-${QT_VERSION}.tar.xz \
#     && tar xvf qt-everywhere-opensource-src-${QT_VERSION}.tar.xz 

# # Compile
# RUN cd qt-everywhere-opensource-src-${QT_VERSION} \
#     ./configure \
#     && make -j$(nproc) \
#     && make -j$(nproc) docs

# FROM snowdreamtech/debian:12.7.0

# # OCI annotations to image
# LABEL org.opencontainers.image.authors="Snowdream Tech" \
#     org.opencontainers.image.title="QT Image Based On Debian" \
#     org.opencontainers.image.description="Docker Images for QT on Debian. (i386,amd64,arm32v5,arm32v7,arm64,mips64le,ppc64le,s390x)" \
#     org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/qt" \
#     org.opencontainers.image.base.name="snowdreamtech/qt:debian" \
#     org.opencontainers.image.licenses="MIT" \
#     org.opencontainers.image.source="https://github.com/snowdreamtech/qt" \
#     org.opencontainers.image.vendor="Snowdream Tech" \
#     org.opencontainers.image.version="12.7" \
#     org.opencontainers.image.url="https://github.com/snowdreamtech/qt"

# # keep the docker container running
# ENV KEEPALIVE=1

# RUN set -eux \
#     && apt-get -qqy update  \
#     && apt-get -qqy install \ 
#     vim \
#     && apt-get -qqy --purge autoremove \
#     && apt-get -qqy clean \
#     && rm -rf /var/lib/apt/lists/* \
#     && rm -rf /tmp/* \
#     && rm -rf /var/tmp/*

# COPY docker-entrypoint.sh /usr/local/bin/

# ENTRYPOINT ["docker-entrypoint.sh"]