FROM golang:latest

ARG AWS_Default_Region
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG KOPS_STATE_BUCKETNAME
ARG CLOUD_PRIVATE_DNS
ARG CLOUD_PRIVATE_ROUTE53_ID
ARG CLOUD_PUBLIC_ROUTE53_ID
ARG CLOUD_CERTIFICATE_AWS_ARN

ENV TERRAFORM_VERSION=0.11.14
ENV KUBECTL_VERSION=v1.17.0
ENV KOPS_VERSION=1.15.0

# Install tools required for mattermost
#   RUN apt-get update && apt-get install -y \
#      curl

# terraform build dev mode - only build for current environment
ENV TF_DEV=true
# Terraform build Release mode - no debug information in binary
ENV TF_RELEASE=true

WORKDIR /usr/src/github.com/hashicorp/terraform
RUN git clone https://github.com/hashicorp/terraform.git ./ && \
    git checkout v${TERRAFORM_VERSION} && \
    /bin/bash scripts/build.sh

# Set working directory
WORKDIR /usr/src/

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    /bin/bash ./get_helm.sh

RUN curl -Lo kops https://github.com/kubernetes/kops/releases/download/${KOPS_VERSION}/kops-linux-amd64 && \
    chmod +x ./kops && \
    mv ./kops /usr/local/bin/

WORKDIR /usr/src/github.com/mattermost

# add cloned repositry to container
RUN mkdir cloud
ADD ./ cloud/
RUN go install ./cloud/cmd/cloud
