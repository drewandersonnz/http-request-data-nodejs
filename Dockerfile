FROM node:7

COPY . /usr/src/app/

RUN cd /usr/src/app/ \
 && npm install -g nodemon \
 && npm install

EXPOSE 8888
WORKDIR /usr/src/app
CMD cd /usr/src/app && npm start
