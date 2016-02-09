FROM ubuntu:14.04

ENV LANGUAGE=en_US.UTF-8 LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 PYTHONIOENCODING=UTF-8

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 575159689BEFB442 && \
    echo 'deb http://download.fpcomplete.com/ubuntu trusty main'|tee /etc/apt/sources.list.d/fpco.list

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
        python3-pip \
        python3-dev \
        libzmq3-dev \
        stack \
        libncurses-dev \
        pkg-config

RUN pip3 install  ipython jupyter
EXPOSE 8888
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]
RUN useradd --uid 1000 -m jupyter
RUN mkdir -p -m 700 /books && chown jupyter /books
VOLUME /books
USER jupyter
RUN mkdir -p -m 700 ~/.jupyter/
RUN stack --install-ghc --resolver lts-5.0 install ihaskell && ~/.local/bin/ihaskell install
ADD jupyter_notebook_config.py /home/jupyter/.jupyter/

CMD ["stack", "exec", "jupyter", "notebook"]
