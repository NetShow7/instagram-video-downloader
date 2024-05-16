# Step 1: Build the app in a node.js environment
FROM node:18-alpine as builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Step 2: Serve the app using a minimal node image
FROM node:18-alpine

WORKDIR /app

COPY --from=builder /app ./

# Expose the port that your app runs on
EXPOSE 3050

CMD ["npm", "start", "--", "-p", "3050"]