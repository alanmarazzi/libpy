FROM tiangolo/uwsgi-nginx-flask:python3.7


ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -yq update &&\
 build-essential zlib1g-dev libncurses5-dev libgdbm-dev &&\
 libnss3-dev  libssl-dev libreadline-dev libffi-dev &&\
 wget  curl rlwrap

## custom for clj stuff
RUN apt-get install -yq openjdk-8-jdk software-properties-common

WORKDIR /tmp

RUN curl -O https://download.clojure.org/install/linux-install-1.10.1.478.sh &&\
    bash linux-install-1.10.1.478.sh

WORKDIR /root

RUN mkdir bin

WORKDIR /root/bin

RUN wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein &&\ chmod +x lein && ./lein

WORKDIR /root

RUN git clone https://github.com/alanmarazzi/libpy

WORKDIR /root/libpy

RUN echo '{"PYTHONHOME" "/usr/local"}' > python.edn

CMD ["~/bin/lein", "python", "run"]