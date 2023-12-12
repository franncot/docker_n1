FROM node:21-alpine3.17

WORKDIR /frontend

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

ENV API_URI=http://backend:5000/api/topics

RUN apk --no-cache add curl


CMD ["node", "server.js"]
