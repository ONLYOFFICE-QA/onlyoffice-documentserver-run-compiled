FROM gentoo/portage:latest as portage
FROM gentoo/stage3-amd64:latest
COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo
RUN emerge -qv dev-vcs/git
RUN git clone --recursive https://github.com/ONLYOFFICE/DocumentServer.git
RUN cd DocumentServer && git submodule foreach --recursive git checkout develop
RUN emerge -qv app-arch/p7zip \
               dev-vcs/subversion 
RUN eselect python set 2 # Using python3 cause error in v8 fetching `No module named 'urlparse'`
#RUN cd DocumentServer/core/Common/3dParty && ./make.sh
RUN cd /DocumentServer/core/Common/3dParty/boost && bash fetch.sh
RUN cd /DocumentServer/core/Common/3dParty/boost && bash build.sh
RUN cd /DocumentServer/core/Common/3dParty/cef && bash fetch.sh
RUN cd /DocumentServer/core/Common/3dParty/cef && bash build.sh
RUN cd /DocumentServer/core/Common/3dParty/curl && bash fetch.sh
RUN cd /DocumentServer/core/Common/3dParty/curl && bash build.sh
RUN cd /DocumentServer/core/Common/3dParty/icu && bash fetch.sh
RUN sed -i 's/xlocale/locale/' /DocumentServer/core/Common/3dParty/icu/linux_64/icu/source/i18n/digitlst.cpp # See https://github.com/ONLYOFFICE/core/pull/90
RUN cd /DocumentServer/core/Common/3dParty/icu && bash fetch.sh
RUN cd /DocumentServer/core/Common/3dParty/icu && bash build.sh
RUN cd /DocumentServer/core/Common/3dParty/openssl && bash fetch.sh
RUN cd /DocumentServer/core/Common/3dParty/openssl && bash build.sh
RUN cd /DocumentServer/core/Common/3dParty/v8 && bash fetch.sh
#RUN cd /DocumentServer/core/Common/3dParty/v8 && bash build.sh