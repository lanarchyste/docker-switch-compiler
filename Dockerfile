FROM devkitpro/devkitarm:latest

MAINTAINER Julien Binet

# Dépendances nécessaire
RUN dkp-pacman -Syyu --noconfirm devkitA64 libnx
RUN apt-get install -y build-essential
RUN apt-get install -y automake
RUN apt-get install -y liblz4-dev
RUN apt-get install -y zlib1g-dev

# Dépôts à constuire
ADD ./switch-tools /switch/tools
ADD ./Tinfoil /switch/Tinfoil
ADD ./ReiNX /switch/ReiNX

# Construction des outils pour le développement
WORKDIR /switch/tools

RUN ./autogen.sh
RUN ./configure
RUN make

ENV PATH="/switch/tools:${PATH}"

# Construction de Tinfoil
WORKDIR /switch/Tinfoil

RUN make

# Construction de ReiNX
WORKDIR /switch/ReiNX

RUN make

# Lancement du container
WORKDIR /switch

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
