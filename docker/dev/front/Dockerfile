FROM node:latest
ENV VUE_APP_API_URL http://localhost:8000/api/
ENV APP_ROOT /src

RUN mkdir ${APP_ROOT}
WORKDIR ${APP_ROOT}

ADD ./front/package.json ${APP_ROOT}/package.json
ADD ./front/ ${APP_ROOT}