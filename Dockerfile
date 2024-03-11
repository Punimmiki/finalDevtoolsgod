# Build Vue.js frontend
FROM node:latest as frontend-build
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend .
RUN npm run build

# Build Node.js backend
FROM node:latest as backend-build
WORKDIR /app/backend
COPY backend/package*.json ./
RUN npm install
COPY backend .
RUN npm run build

# Final stage, serving both frontend and backend using Nginx
FROM nginx:alpine
COPY --from=frontend-build /app/frontend/dist /usr/share/nginx/html
COPY --from=backend-build /app/backend /usr/share/nginx/html/api
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
