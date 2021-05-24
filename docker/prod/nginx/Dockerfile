# FROM node:latest as build-stage
# WORKDIR ./frontend
# COPY ./frontend .
# ENV VUE_APP_API_URL /api/
# RUN npm install
# RUN npm run build

FROM nginx:latest
RUN mkdir /app
RUN rm /etc/nginx/conf.d/default.conf
# COPY --from=build-stage /frontend/dist /app
COPY ./docker/prod/nginx/nginx.conf /etc/nginx/conf.d/
