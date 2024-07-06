# Use the official Node.js image from the Docker Hub
FROM node:16-alpine

# Set environment variables
ENV NODE_ENV=production

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Install PM2 globally
RUN npm install pm2 -g

# Copy the rest of the application code to the working directory
COPY . .

# Build the React application
RUN npm run build

# Expose the port that the app runs on
EXPOSE 3000

# Start the React application using PM2
CMD ["pm2-runtime", "start", "npm", "--", "start"]
