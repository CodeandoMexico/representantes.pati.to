FROM ruby:2.1-onbuild

# Triste, pero necesitamos NodeJS para trabajar con CoffeeScript
# Lo siguiente son los pasos para instalar NVM y una versión de node

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 0.10.33

# Instala nvm con node y npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH

# Corremos la version web con Rack
CMD [ "rackup", "-o", "0.0.0.0" ]
