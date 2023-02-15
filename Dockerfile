FROM nginx:1.23-alpine
COPY dist/ /usr/share/nginx/html/root/
ADD default.conf /etc/nginx/conf.d/
