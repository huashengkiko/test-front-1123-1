 # FROM nginx:1.13，下面的小
FROM nginx:1.16.1-alpine

COPY ./dist /usr/share/nginx/html
