# https://hub.docker.com/r/toshiara/alpine-texlive-ja
# https://github.com/toshi-ara/docker-alpine-texlive-ja/

FROM frolvlad/alpine-glibc:latest
LABEL lastupdate=2021.5.1

# /usr/local/texlive/2021/bin/x86_64-linuxmusl:$PATH

ENV TL_VERSION      2021
ENV TL_PATH         /usr/local/texlive/${TL_VERSION}
ENV PATH            ${TL_PATH}/bin/x86_64-linuxusl:${TL_PATH}/bin/aarch64-linuxusl:/bin:${PATH}

RUN apk add --no-cache gnupg perl fontconfig-dev freetype-dev \
                       curl wget lha tar xz ghostscript && \
    mkdir /tmp/install-tl-unx && \
    curl -L http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | \
    tar -xz -C /tmp/install-tl-unx --strip-components=1 && \
    printf "%s\n" \
      "selected_scheme scheme-basic" \
      "tlpdbopt_install_docfiles 0" \
      "tlpdbopt_install_srcfiles 0" \
      > /tmp/install-tl-unx/texlive.profile && \
    /tmp/install-tl-unx/install-tl \
      --profile=/tmp/install-tl-unx/texlive.profile && \
    tlmgr install \
      collection-latexextra \
      collection-fontsrecommended \
      collection-langjapanese \
      lualatex-math \
      xetex xecjk ctex \
      latexmk light-latex-make
      
#RUN tlmgr --repository http://www.texlive.info/tlgpg/ install tlgpg && \
#    tlmgr repository add https://contrib.texlive.info/current tlcontrib && \
#    tlmgr pinning add tlcontrib '*' && \
#    tlmgr install japanese-otf-nonfree \
#    japanese-otf-uptex-nonfree \
#    ptex-fontmaps-macos

RUN mkdir -p /System/Library/Fonts \
 && touch '/System/Library/Fonts/ヒラギノ明朝 ProN.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ丸ゴ ProN W4.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ角ゴシック W0.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ角ゴシック W1.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ角ゴシック W2.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ角ゴシック W3.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ角ゴシック W4.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ角ゴシック W5.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ角ゴシック W6.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ角ゴシック W7.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ角ゴシック W8.ttc' \
 && touch '/System/Library/Fonts/ヒラギノ角ゴシック W9.ttc'

#RUN tlmgr repository add http://contrib.texlive.info/current tlcontrib
#RUN tlmgr pinning add tlcontrib '*'
#RUN tlmgr install japanese-otf-nonfree japanese-otf-uptex-nonfree ptex-fontmaps-macos cjk-gs-integrate-macos cjk-gs-integrate adobemapping
#RUN tlmgr path add
#RUN cjk-gs-integrate --link-texmf --cleanup
#RUN cjk-gs-integrate-macos --link-texmf --fontdef-add=cjkgs-macos-highsierra.dat
#RUN mktexlsr
#RUN kanji-config-updmap-sys --jis2004 hiragino-highsierra-pron

RUN curl -fsSL https://www.preining.info/rsa.asc | tlmgr key add -
RUN tlmgr repository add http://contrib.texlive.info/current tlcontrib
RUN tlmgr pinning add tlcontrib '*'
RUN tlmgr repository status
RUN tlmgr install japanese-otf-nonfree japanese-otf-uptex-nonfree ptex-fontmaps-macos cjk-gs-integrate-macos
RUN cjk-gs-integrate --link-texmf --cleanup
RUN cjk-gs-integrate-macos --link-texmf
RUN kanji-config-updmap-sys status


#RUN cjk-gs-integrate --link-texmf --fontdef-add cjkgs-macos-highsierra.dat \
# && cjk-gs-integrate-macos --link-texmf \
# && kanji-config-updmap-sys --jis2004 hiragino-highsierra-pron \
# && mktexlsr \

RUN rm -f /System/Library/Fonts/*.ttc \
 && apk del .build-deps && \
    rm -fr /tmp/install-tl-unx

WORKDIR /workdir

CMD ["sh"]
