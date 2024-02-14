# Stage 1: Build the Node.js application
FROM node:lts-alpine3.17 AS build

WORKDIR /app

COPY package.json  ./

RUN npm install

COPY . .

RUN npm run build

# Stage 2: Serve the built files using NGINX
FROM nginx:1.23-alpine

WORKDIR /usr/share/nginx/html

COPY --from=build /app/build .

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]
