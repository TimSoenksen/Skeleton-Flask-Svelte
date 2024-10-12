# Use an official Node runtime as a parent image for the frontend
FROM node:22.6.0 AS frontend-builder

# Set the working directory in the container
WORKDIR /app/frontend

# Copy package.json and package-lock.json
COPY frontend/package*.json ./

# Install dependencies
RUN npm install

# Copy the frontend files
COPY frontend .

# List contents of /app/frontend before build
RUN ls -la /app/frontend

# Build the frontend app
RUN npm run build

# List contents of /app/frontend after build
RUN ls -la /app/frontend

# List contents of /app/frontend/build
RUN ls -la /app/frontend/build || echo "build directory not found"

# List contents of /app/frontend/.svelte-kit/output (if it exists)
RUN ls -la /app/frontend/.svelte-kit/output || echo ".svelte-kit/output directory not found"

# Use an official Python runtime as a parent image for the Flask app
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Copy the .env file into the container
COPY .env .env

# Install system dependencies
RUN apt-get update && \
    apt-get install -y gnupg2 curl unixodbc-dev

# Add Microsoft repository and update sources
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update

# Set the environment variable for non-interactive installation and EULA acceptance
ENV DEBIAN_FRONTEND=noninteractive
ENV ACCEPT_EULA=Y

# Install ODBC driver for SQL Server with forced overwrite of any conflicting files
RUN apt-get install -y -o Dpkg::Options::="--force-overwrite" msodbcsql18

# Install build tools and ODBC development headers
RUN apt-get install -y build-essential unixodbc-dev

# Add this after the MSSQL ODBC driver installation
RUN apt-get install -y postgresql-client

# Upgrade pip and install required packages
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copy the Flask app
COPY app.py .

# Copy the built frontend from the previous stage
COPY --from=frontend-builder /app/frontend/build ./frontend/build

# List contents of /app/frontend/build in the final stage
RUN ls -la /app/frontend/build || echo "build directory not found in final stage"

# Create settings directory
RUN mkdir /app/settings


# Make port available, change this if you want to use a differnt port
EXPOSE 1234

# Run the application
CMD ["python", "app.py"]