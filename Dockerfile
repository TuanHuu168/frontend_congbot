# Step 1: Build the Vite React app
FROM node:23 AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN chmod +x node_modules/.bin/vite
RUN npm run build
# Step 2: Serve the production build with nginx
FROM nginx:alpine
# Copy Vite's build output (dist folder) to nginx web root
COPY --from=build /app/dist /usr/share/nginx/html
# Copy nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]