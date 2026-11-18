FROM ghcr.io/cirruslabs/flutter:3.41.2 AS build
WORKDIR /app
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get
COPY lib/ lib/
COPY web/ web/
RUN flutter build web --release --no-pub

FROM nginx:stable-alpine
COPY --from=build /app/build/web/ /usr/share/nginx/html/
EXPOSE 80
