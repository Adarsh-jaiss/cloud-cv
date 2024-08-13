#!/bin/bash

# Define variables
TF_DIR="/path/to/terraform/directory"  # Adjust to your actual Terraform directory
REMOTE_USER="your_remote_user"         # Adjust as needed
REMOTE_HOST="your.remote.host"         # Adjust as needed
REMOTE_DIR="/path/to/remote/directory" # Adjust as needed

echo "Starting Terraform deployment..."

# Navigate to the Terraform directory
cd $TF_DIR

# Initialize Terraform
terraform init

# Plan the Terraform deployment
terraform plan

# Apply the Terraform deployment
terraform apply -auto-approve

echo "Terraform deployment complete."

echo "Deployment complete!"
