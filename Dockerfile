FROM tiangolo/uwsgi-nginx-flask:python3.7


ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -yq update
RUN apt-get install -yq build-essential
RUN apt-get install -yq zlib1g-dev
RUN apt-get install -yq libncurses5-dev
RUN apt-get install -yq libgdbm-dev
RUN apt-get install -yq libnss3-dev
RUN apt-get install -yq libssl-dev
RUN apt-get install -yq libreadline-dev
RUN apt-get install -yq libffi-dev
RUN apt-get install -yq wget
RUN apt-get install -yq curl
RUN apt-get install -yq rlwrap


## custom for clj stuff
RUN apt-get install -yq openjdk-8-jdk
RUN apt-get install -yq software-properties-common

WORKDIR /tmp

RUN curl -O https://download.clojure.org/install/linux-install-1.10.1.478.sh
RUN bash linux-install-1.10.1.478.sh

WORKDIR /root

RUN mkdir bin

WORKDIR /root/bin

RUN wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
RUN chmod +x lein
RUN ./lein

WORKDIR /root

RUN git clone https://github.com/alanmarazzi/libpy

WORKDIR /root/libpy

CMD ~/bin/lein python run