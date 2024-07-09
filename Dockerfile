FROM node:19 AS build
WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn install

COPY . .
RUN yarn build

FROM node:19
WORKDIR /app

RUN npm install -g serve


COPY --from=build /app/build /app/build
EXPOSE 3000

CMD ["serve", "-s", "build", "-l", "3000"]
