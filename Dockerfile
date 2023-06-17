# Use a base image
FROM nginx:stable-alpine

# Set the working directory inside the container
WORKDIR /usr/share/nginx/html

# Copy the website files into the container
COPY index.html .

# Expose the default HTTP port
EXPOSE 80

# Set the entrypoint command
CMD ["nginx", "-g", "daemon off;"]