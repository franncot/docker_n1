FROM node:21-alpine3.17

WORKDIR /backend

RUN npm install -g ts-node

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run prebuild

RUN npm run build

RUN apk --no-cache add curl

EXPOSE 5000

ENV DATABASE_URL=mongodb://mongodb:27017

ENV DATABASE_NAME=TopicstoreDb

ENV HOST=0.0.0.0

ENV PORT=5000

CMD ["npm", "start"]
