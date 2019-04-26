# stage: 1 — basic files environment
FROM node:10 as react-native-build
WORKDIR /app
COPY . ./
RUN npm
RUN npm run build
# stage: 2 — the production environment
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY -- from=react-build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]