FROM node:7

RUN npm install -g nodemon

EXPOSE 8888

WORKDIR /usr/src/app
CMD npm install && npm start
