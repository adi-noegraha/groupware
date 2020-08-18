# build stage
FROM node:10.16-alpine as build-stage

# Create app folder
RUN mkdir /app
WORKDIR /app

# Copy all files to app folder
COPY package*.json ./
RUN npm install --progress=false
COPY . /app

# Environment app
ARG VUE_APP_BASE_API_API
ARG VUE_APP_SECRET_CLIENT_GOOGLE
ARG VUE_APP_FIREBASE_API_KEY
ARG VUE_APP_FIREBASE_AUTH_DOMAIN
ARG VUE_APP_FIREBASE_DB_URL
ARG VUE_APP_FIREBASE_PROJECT_ID
ARG VUE_APP_FIREBASE_STORAGE_BUCKET
ARG VUE_APP_FIREBASE_MESSAGING_SENDER_ID
ARG VUE_APP_FIREBASE_APP_ID
ARG VUE_APP_FIREBASE_MEASUREMENT_ID
ARG VUE_APP_FIREBASE_PUBLIC_VAPID_KEY
ARG VUE_APP_VERSION

ENV VUE_APP_BASE_API_API $VUE_APP_BASE_API_API
ENV VUE_APP_SECRET_CLIENT_GOOGLE $VUE_APP_SECRET_CLIENT_GOOGLE
ENV VUE_APP_FIREBASE_API_KEY $VUE_APP_FIREBASE_API_KEY
ENV VUE_APP_FIREBASE_AUTH_DOMAIN $VUE_APP_FIREBASE_AUTH_DOMAIN
ENV VUE_APP_FIREBASE_DB_URL $VUE_APP_FIREBASE_DB_URL
ENV VUE_APP_FIREBASE_PROJECT_ID $VUE_APP_FIREBASE_PROJECT_ID
ENV VUE_APP_FIREBASE_STORAGE_BUCKET $VUE_APP_FIREBASE_STORAGE_BUCKET
ENV VUE_APP_FIREBASE_MESSAGING_SENDER_ID $VUE_APP_FIREBASE_MESSAGING_SENDER_ID
ENV VUE_APP_FIREBASE_APP_ID $VUE_APP_FIREBASE_APP_ID
ENV VUE_APP_FIREBASE_MEASUREMENT_ID $VUE_APP_FIREBASE_MEASUREMENT_ID
ENV VUE_APP_FIREBASE_PUBLIC_VAPID_KEY $VUE_APP_FIREBASE_PUBLIC_VAPID_KEY
ENV VUE_APP_VERSION $VUE_APP_VERSION

RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage

# Environment app
ARG VUE_APP_BASE_API_API
ARG VUE_APP_SECRET_CLIENT_GOOGLE
ARG VUE_APP_FIREBASE_API_KEY
ARG VUE_APP_FIREBASE_AUTH_DOMAIN
ARG VUE_APP_FIREBASE_DB_URL
ARG VUE_APP_FIREBASE_PROJECT_ID
ARG VUE_APP_FIREBASE_STORAGE_BUCKET
ARG VUE_APP_FIREBASE_MESSAGING_SENDER_ID
ARG VUE_APP_FIREBASE_APP_ID
ARG VUE_APP_FIREBASE_MEASUREMENT_ID
ARG VUE_APP_FIREBASE_PUBLIC_VAPID_KEY
ARG VUE_APP_VERSION

ENV VUE_APP_BASE_API_API $VUE_APP_BASE_API_API
ENV VUE_APP_SECRET_CLIENT_GOOGLE $VUE_APP_SECRET_CLIENT_GOOGLE
ENV VUE_APP_FIREBASE_API_KEY $VUE_APP_FIREBASE_API_KEY
ENV VUE_APP_FIREBASE_AUTH_DOMAIN $VUE_APP_FIREBASE_AUTH_DOMAIN
ENV VUE_APP_FIREBASE_DB_URL $VUE_APP_FIREBASE_DB_URL
ENV VUE_APP_FIREBASE_PROJECT_ID $VUE_APP_FIREBASE_PROJECT_ID
ENV VUE_APP_FIREBASE_STORAGE_BUCKET $VUE_APP_FIREBASE_STORAGE_BUCKET
ENV VUE_APP_FIREBASE_MESSAGING_SENDER_ID $VUE_APP_FIREBASE_MESSAGING_SENDER_ID
ENV VUE_APP_FIREBASE_APP_ID $VUE_APP_FIREBASE_APP_ID
ENV VUE_APP_FIREBASE_MEASUREMENT_ID $VUE_APP_FIREBASE_MEASUREMENT_ID
ENV VUE_APP_FIREBASE_PUBLIC_VAPID_KEY $VUE_APP_FIREBASE_PUBLIC_VAPID_KEY
ENV VUE_APP_VERSION $VUE_APP_VERSION

COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]