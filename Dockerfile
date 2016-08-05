FROM alpine:edge
MAINTAINER Fabio Nitto <fabio.nitto@gmail.com>

RUN apk add --no-cache \
    nodejs \
    python2

RUN npm install -g grunt-cli

RUN apk add --no-cache --virtual build-essential \
    g++ \
    git \
    make &&\
    git clone --branch 3.3.0 https://github.com/hakimel/reveal.js.git && \
    cd reveal.js && npm install &&\
    apk del build-essential

COPY index.html /slides/

RUN rm /reveal.js/index.html &&\
    ln -s /slides/index.html /reveal.js/index.html

COPY Gruntfile.js /reveal.js/

WORKDIR reveal.js
CMD grunt serve
EXPOSE 8000

