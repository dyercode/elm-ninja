FROM nginx:1.25-alpine
COPY dist/ /usr/share/nginx/html
ADD default.conf /etc/nginx/conf.d/
