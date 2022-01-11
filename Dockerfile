FROM alpine

MAINTAINER Willem Essenstam <wessenstam.at@gmail.com>

RUN apk add --no-cache --virtual --update py-pip make wget ca-certificates ttf-dejavu openjdk8-jre graphviz \
    && pip install --upgrade pip \
    && pip install livereload sphinx sphinx_rtd_theme sphinxcontrib-plantuml sphinx_autobuild \
    && pip install sphinx_bootstrap_theme \
    && pip install sphinx_fontawesome \
    && pip install sphinxcontrib.fulltoc \
    && pip install sphinx-theme \
    && pip install myst-parser

RUN wget http://downloads.sourceforge.net/project/plantuml/plantuml.jar -P /opt/ \
    && echo -e '#!/bin/sh -e\njava -jar /opt/plantuml.jar "$@"' > /usr/local/bin/plantuml \
    && chmod +x /usr/local/bin/plantuml

COPY ./.sphinx-server.yml /opt/sphinx-server/

WORKDIR /web

EXPOSE 8000 35729

CMD ["/usr/bin/make", "livehtml"]
