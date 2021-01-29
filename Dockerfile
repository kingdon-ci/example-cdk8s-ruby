# syntax = docker/dockerfile:1
FROM kingdonb/rvm-ruby3:6cf2f72c as builder-base
LABEL maintainer="Kingdon Barrett <kingdon@teamhephy.com>"
ENV APPDIR="/home/${RVM_USER}/app"
ENV RUBY=3.0.0
ENV GEMSET=testing

USER root
COPY jenkins/runasroot-dependencies.sh /home/${RVM_USER}/jenkins/
RUN /home/${RVM_USER}/jenkins/runasroot-dependencies.sh
RUN chgrp rvm /usr/local/bin && chmod g+w /usr/local/bin

FROM builder-base AS gem-builder-base
USER ${RVM_USER}
COPY --chown=rvm Gemfile Gemfile.lock .ruby-version ${APPDIR}/

FROM builder-base AS jenkins-builder
COPY jenkins/runasroot-jenkins-dependencies.sh /home/${RVM_USER}/jenkins/
RUN /home/${RVM_USER}/jenkins/runasroot-jenkins-dependencies.sh

FROM gem-builder-base AS gem-bundle
RUN  \
    rvm ${RUBY} do rvm gemset create ${GEMSET} \
 && rvm ${RUBY}@${GEMSET} do bundle check \
 || rvm ${RUBY}@${GEMSET} do bundle install
RUN echo 'export PATH="$PATH:$HOME/app/bin"' >> ~/.profile \
 && echo "rvm ${RUBY}@${GEMSET}" >> ~/.profile

FROM gem-bundle AS builder
FROM builder AS slug
COPY --chown=${RVM_USER} . ${APPDIR}
USER ${RVM_USER}
# RUN echo 'export PATH="$PATH:$HOME/app/bin"' >> ../.profile

FROM jenkins-builder AS jenkins
COPY --from=gem-bundle --chown=${RVM_USER} \
  /usr/local/rvm/gems/ruby-${RUBY}@${GEMSET} /usr/local/rvm/gems/ruby-${RUBY}@${GEMSET}
COPY --from=slug --chown=${RVM_USER} \
  ${APPDIR} ${APPDIR}
USER root
RUN useradd -m -u 1000 -g rvm jenkins
RUN chgrp rvm -R /home/${RVM_USER}/app
RUN chmod g+w -R /home/${RVM_USER}/app
USER jenkins
# RUN echo 'export PATH="$PATH:/home/rvm/app/bin"' >> ~/.profile

FROM slug AS prod
USER ${RVM_USER}
CMD rvm ${RUBY}@${GEMSET} do ./jenkins/rake-ci.sh
