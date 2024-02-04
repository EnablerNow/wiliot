#!/bin/bash

# Stop execution if any command fails
set -e

# script source
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

create_infra(){
 cd $SCRIPT_DIR/iac
 terraform apply -auto-approve
}

build_and_upload(){
    
    cd $SCRIPT_DIR/server
    
    # Define variables
    AWS_REGION="eu-west-1"
    AWS_ACCOUNT_ID="092988563851"
    ECR_REPOSITORY="wiliot-ecr-repo"
    IMAGE_TAG="latest"

    # Authenticate Docker with the ECR Registry
    echo "Authenticating Docker with the ECR Registry..."
    aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

    # Build the Docker image
    echo "Building the Docker image..."
    docker build -t $ECR_REPOSITORY .

    # Tag the Docker image
    echo "Tagging the Docker image..."
    docker tag $ECR_REPOSITORY:$IMAGE_TAG $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:$IMAGE_TAG

    # Push the image to the ECR repository
    echo "Pushing the image to the ECR repository..."
    docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:$IMAGE_TAG

    echo "Docker image pushed successfully to ECR."
}

add_eks_to_config(){
    # add cluster to kubeconfig
    aws eks --region eu-west-1 update-kubeconfig --name "Wiliot-EKS-Cluster" --alias williot 
}


deploy_app(){
    helm upgrade --install wiliot $SCRIPT_DIR/helm/myapp
    url=`kubectl get services williot-myapp  -n default -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'`
    echo "The external url is: $url"
}

create_infra
build_and_upload
add_eks_to_config
deploy_app
