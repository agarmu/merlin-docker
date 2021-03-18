FROM swift:latest as builder

# Default environment variables
ENV MERLIN_LIBRARY_BASE_URL='https://github.com/TheCoderMerlin'
ENV MERLIN_LIBRARY_ROOT_DIR='/usr/local/lib/merlin'


# Setup merlin build system and bash-utils
WORKDIR /tmp/merlin/

COPY tool.manifest toolInstall.sh ./
RUN ./toolInstall.sh

# Install apt libs
RUN apt update -y
RUN apt upgrade -y
RUN apt install libncurses5-dev -y

# Install Merlin Libraries
RUN mkdir -p ${MERLIN_LIBRARY_ROOT_DIR}
RUN deployMerlinLibrary ${MERLIN_LIBRARY_BASE_URL} Igis 1.3.7
RUN deployMerlinLibrary ${MERLIN_LIBRARY_BASE_URL} Scenes                  1.1.5
RUN deployMerlinLibrary ${MERLIN_LIBRARY_BASE_URL} ScenesAnimations        0.1.5
RUN deployMerlinLibrary ${MERLIN_LIBRARY_BASE_URL} ScenesControls          0.1.0
RUN deployMerlinLibrary ${MERLIN_LIBRARY_BASE_URL} MerlinKarel             0.1.7
