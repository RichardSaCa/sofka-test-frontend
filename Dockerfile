FROM node:18-alpine as build
WORKDIR /usr/src/app
COPY package*.json ./
COPY angular.json ./
RUN npm install
COPY . .
RUN npm run build


### NGINX
FROM nginx:1.24-alpine
RUN mkdir /usr/share/nginx/html/sofka-test
#RUN ls -la /usr/src/app/
COPY --from=build /usr/src/app/dist/sofka-test/browser /usr/share/nginx/html/sofka-test
COPY --from=build /usr/src/app/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
