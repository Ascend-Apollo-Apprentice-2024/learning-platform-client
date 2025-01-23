# Base image
FROM node:18 AS build

# sets the working directory inside the container
WORKDIR /learning-platform-client

# Copy the project files
COPY . ./

# Install dependencies
RUN npm install

# Build the React app
RUN npm run build

# Use a lightweight server to serve the built app
FROM nginx:alpine

# Copy the built React app to the Nginx directory
COPY --from=build /learning-platform-client/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server to serve the application
CMD ["nginx", "-g", "daemon off;"]
