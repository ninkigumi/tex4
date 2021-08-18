FROM alpine:3.9

RUN set -ex \
 && apk add --no-cache --virtual .build-deps \
    curl \
    ghostscript \
    perl \
 && mkdir /tmp/install-tl-unx \
 && wget -qO- http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | tar zx -C /tmp/install-tl-unx --strip-components=1 \
 && echo selected_scheme scheme-basic >> /tmp/install-tl-unx/texlive.profile \
 && echo collection-fontsrecommended 1 >> /tmp/install-tl-unx/texlive.profile \
 && echo collection-latexrecommended 1 >> /tmp/install-tl-unx/texlive.profile \
 && echo collection-langjapanese 1 >> /tmp/install-tl-unx/texlive.profile \
 && echo instopt_adjustpath 1 >> /tmp/install-tl-unx/texlive.profile \
 && echo tlpdbopt_install_docfiles 0 >> /tmp/install-tl-unx/texlive.profile \
 && echo tlpdbopt_install_srcfiles 0 >> /tmp/install-tl-unx/texlive.profile \
 && /tmp/install-tl-unx/install-tl --profile /tmp/install-tl-unx/texlive.profile \
 && rm -rf /tmp/install-tl-unx \
 
