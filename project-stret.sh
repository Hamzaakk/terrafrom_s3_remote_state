#!/bin/bash

# Project name
PROJECT_NAME="terraform-state"

# Create root project folder
mkdir -p $PROJECT_NAME
cd $PROJECT_NAME || exit

# Create main Terraform files
touch main.tf variables.tf outputs.tf terraform.tfvars

# Create modules folder and submodules
mkdir -p  modules/s3 modules/dynamo

# Create module files
for module in s3 dynamo; do
    touch modules/$module/main.tf modules/$module/variables.tf modules/$module/outputs.tf
done

# Create GitHub Actions workflow folder
