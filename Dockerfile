# BUILD
FROM node:15.4 as BUILD
WORKDIR /app
COPY package*.json ./
RUN npm install --silent
COPY . .
RUN npm run build

# RUN
FROM nginx:alpine
COPY --from=BUILD /app/nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=BUILD /app/build /usr/share/nginx/html
RUN cat /etc/nginx/nginx.conf
RUN ls -l /usr/share/nginx/html
EXPOSE 80