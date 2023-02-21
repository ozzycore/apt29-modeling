FROM ubuntu:15.04

# Install managed dependencies
RUN sed -i -e 's/archive.ubuntu.com\|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list
RUN apt-get update 
RUN apt-get install -y \
  autoconf \
  bison \
  flex \
  g++ \
  graphviz \
  libpcre3 \
  libpcre3-dev \
  libcurl3 \
  libcurl4-openssl-dev \
  make \
  openjdk-8-jdk \
  texlive-font-utils \
  vim \
  wget \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Copy jni_md.h to new location (this resolvfes file not found warning for XSB)
WORKDIR /usr/lib/jvm/java-8-openjdk-amd64/include
RUN cp linux/jni_md.h .

# Set JAVA_HOME for XSB
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Install XSB
WORKDIR /root
RUN wget http://xsb.sourceforge.net/downloads/XSB360.tar.gz && \
  tar -xzf XSB360.tar.gz && \
  rm XSB360.tar.gz
WORKDIR /root/XSB/build
RUN ./configure && ./makexsb
ENV PATH ${PATH}:/root/XSB/bin

# Install MulVAL
WORKDIR /root
RUN mkdir mulval && \
  mkdir mulval/bin && \
  mkdir mulval/bin/adapter && \
  mkdir mulval/bin/metrics
ADD mulval.tar.gz /root/mulval/
WORKDIR /root/mulval
ENV MULVALROOT /root/mulval
ENV PATH ${PATH}:${MULVALROOT}/bin:${MULVALROOT}/utils
RUN make

# Create the input directory
RUN mkdir /input
WORKDIR /input
VOLUME ["/input"]

# Run script to start mysql service and exit to bash
CMD bash -C 'bash'

