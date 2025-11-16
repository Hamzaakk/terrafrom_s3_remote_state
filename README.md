# Terraform S3 Remote State

Simple setup for storing Terraform state files remotely in AWS S3.

## 🎯 Problem

When working with Terraform, the state file (`terraform.tfstate`) is stored locally by default. This creates several issues:

- ❌ **No Collaboration** - Team members can't share the same state
- ❌ **Risk of Loss** - Local files can be accidentally deleted
- ❌ **No Version History** - Hard to track changes or rollback
- ❌ **Security Risk** - State files contain sensitive data and shouldn't be in Git
- ❌ **Conflicts** - Multiple people running Terraform at the same time causes state corruption

## 💡 Solution

Store Terraform state remotely in an S3 bucket:

- ✅ **Centralized State** - All team members use the same state file
- ✅ **Automatic Backups** - S3 versioning keeps history of all changes
- ✅ **Encryption** - State data is encrypted at rest
- ✅ **Secure** - Access controlled via IAM policies
- ✅ **Reliable** - AWS handles availability and durability

## 📖 Scenarios

### Scenario 1: First Time Setup
You have Terraform code locally and want to start using remote state.

### Scenario 2: Separate Infrastructure
You have two repos:
- **terraform-state repo** - Creates the S3 bucket (state stored locally)
- **project-infra repo** - Creates your actual infrastructure (state stored in S3)

This is the recommended approach! ✅

## 🚀 Steps to Use

### Step 1: Create the S3 Bucket (terraform-state repo)

```bash
# Clone or navigate to your terraform-state repo
cd terraform-state

# Initialize Terraform
terraform init

# Create the S3 bucket
terraform plan
terraform apply

# Note the bucket name from output
# State for THIS repo stays LOCAL (it's just creating the bucket)
```

**Example `main.tf` for creating S3 bucket:**

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-terraform-state-bucket-12345"  # Must be globally unique

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "Production"
  }
}
```

### Step 2: Configure Backend in Your Project Repo

In your **project infrastructure repo**, create or update `backend.tf`:

```hcl
terraform {
  backend "s3" {
    bucket  = "my-terraform-state-bucket-12345"  # Use the bucket you created
    key     = "project/terraform.tfstate"        # Path within the bucket
    region  = "us-east-1"
    encrypt = true
  }
}
```

### Step 3: Initialize Backend

```bash
# Navigate to your project-infra repo
cd ../project-infra

# Initialize Terraform with the new backend
terraform init

# Terraform will ask: "Do you want to copy existing state to the new backend?"
# Answer: yes (if you have existing local state)
```

### Step 4: Verify Remote State

```bash
# Check state is now in S3
aws s3 ls s3://my-terraform-state-bucket-12345/project/

# Continue working normally
terraform plan
terraform apply
```

## 📁 Repository Structure

### terraform-state repo
```
terraform-state/
├── main.tf              # Creates S3 bucket
├── outputs.tf           # Outputs bucket name
├── terraform.tfstate    # LOCAL state (only for this repo)
└── README.md
```

### project-infra repo
```
project-infra/
├── main.tf              # Your infrastructure code
├── backend.tf           # S3 backend configuration
├── variables.tf
├── outputs.tf
└── README.md
```
