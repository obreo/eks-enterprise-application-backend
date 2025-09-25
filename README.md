# CI/CD Workflow Documentation


This project uses GitHub Actions to automate the build and deployment of Docker images for the frontend application. The workflow is defined in `.github/workflows/workflow.yml`.

## Workflow Overview

- **Triggers:**
  - On push to `dev`, `staging`, or `prod` branches
  - Manually via the GitHub Actions UI (`workflow_dispatch`)

- **Purpose:**
  - Build a Docker image for the frontend
  - Tag the image with a label and commit SHA
  - Push the image to AWS Elastic Container Registry (ECR)

## How the Workflow Works

For each environment (`dev`, `staging`, `prod`), a separate job runs with the following steps:

1. **Checkout repository**
	- Uses the `actions/checkout` action to pull the latest code.

2. **Build Docker image**
	- Runs `docker build` to create a Docker image tagged as `${{ vars.ECR_REPOSITORY }}:${{ env.IMAGE_TAG }}`.
	- The `IMAGE_TAG` is a combination of a label and the short commit SHA.

3. **Configure AWS credentials**
	- Uses `aws-actions/configure-aws-credentials` to authenticate with AWS using OIDC and the provided role.

4. **Login to Amazon ECR and push image**
	- Logs in to ECR using the AWS CLI.
	- Pushes the built Docker image to the specified ECR repository.

## Environment-specific Jobs

- **DEV**: Runs when pushing to the `dev` branch.
- **STAGING**: Runs when pushing to the `staging` branch.
- **PROD**: Runs when pushing to the `prod` branch.

Each job uses its own environment and can be customized further as needed.

---
For more details, see the workflow file at `.github/workflows/workflow.yml`.
