# build environment
FROM node:16.16.0-alpine as builder
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY package.json ./
COPY yarn.lock ./
RUN yarn install
RUN npm install react-scripts@5.0.1 -g --silent
RUN npm install -g serve
COPY . ./
RUN yarn run build
EXPOSE 80
CMD ["serve", "-s", "build", "-l", "80"]

# # production environment
# FROM nginx:stable-alpine
# COPY --from=builder /app/build /usr/share/nginx/html
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]   