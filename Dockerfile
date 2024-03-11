FROM node:latest as build

WORKDIR /app/frontend

COPY frontend/package.json frontend/package-lock.json ./

RUN npm install

COPY frontend .

RUN npm run build

# Stage 2: Build final image
FROM nginx:alpine

COPY --from=build /app/frontend/ /usr/share/nginx/html

# Expose port 80
EXPOSE 8085

# Command to run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
