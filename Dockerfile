FROM node:lts-alpine3.17

WORKDIR /app

COPY ./package.json ./

RUN npm install

COPY  . .

RUN npm run build

EXPOSE 3000

CMD [ "npm","start" ]

# Server file

FROM  nginx:1.23-alpine

WORKDIR /usr/share/nginx/html 

RUN rm -rf *

COPY --from=build /app/build .

EXPOSE 80

ENTRYPOINT [ "nginx","-g","daemon off;" ]
