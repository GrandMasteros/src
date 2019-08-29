FROM ubuntu:19.10

RUN apt-get update && apt-get install -y \
    build-essential \
    g++-arm-linux-gnueabihf \
    gcc-arm-linux-gnueabihf \
    wget \
    python3-pip 

WORKDIR /tmp

RUN wget https://github.com/Kitware/CMake/releases/download/v3.15.2/cmake-3.15.2-Linux-x86_64.sh && \
    chmod +x cmake-3.15.2-Linux-x86_64.sh && \
    ./cmake-3.15.2-Linux-x86_64.sh --prefix=/usr --skip-license --exclude-subdir

RUN pip3 install conan && \
    conan profile new default --detect && \
    conan profile update settings.arch=armv7hf default && \
    conan profile update env.CXX=/usr/bin/arm-linux-gnueabihf-g++ default && \
    conan profile update env.CC=/usr/bin/arm-linux-gnueabihf-gcc default
