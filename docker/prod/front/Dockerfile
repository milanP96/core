FROM node:latest
ENV VUE_APP_API_URL http://novaera.rs/api/
ENV HOST 0.0.0.0
ENV APP_ROOT /src

RUN mkdir ${APP_ROOT}
WORKDIR ${APP_ROOT}

ADD ./front/package.json ${APP_ROOT}/package.json
ADD ./front/ ${APP_ROOT}

RUN npm install
RUN npm run build
CMD npm run start