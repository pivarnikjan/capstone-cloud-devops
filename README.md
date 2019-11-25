[![Build Status](http://ec2-54-190-22-180.us-west-2.compute.amazonaws.com:8080/buildStatus/icon?job=capstone-cloud-devops%2Fmaster)](http://ec2-35-166-30-226.us-west-2.compute.amazonaws.com:8080/job/capstone-cloud-devops/job/master/)
# Capstone Project for Cloud DevOps Nanodegree program

- Jenkins address:
http://ec2-54-190-22-180.us-west-2.compute.amazonaws.com:8080


### Tracking progress: <br>
[X] Create Github repository with project code. <br>
[X] Use image repository to store Docker images. <br>
[X] Execute linting step in code pipeline. <br>
[X] Build a Docker container in a pipeline. <br>
[ ] The Docker container is deployed to a Kubernetes cluster. <br>
[ ] Use Blue/Green Deployment or a Rolling Deployment successfully. <br>

---

### Installation steps:

#### `Jenkins`:
`Embeddable Build Status`
1. Configure Global Security
2. Matrix-based security
3. Add permission for Anonymous Users to `ViewStatus`
4. Add permissions to your active user
5. Go to project and copy embedded link for markup language


#### `Docker`:

- Remove old Docker
    ```bash
    sudo apt-get remove docker docker-engine docker.io containerd runc
    ```
- Update the apt package index:
    ```bash
    sudo apt-get update
    ```
- Install packages to allow apt to use a repository over HTTPS:
    ```bash
    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common
    ```
- Add Docker’s official GPG key:
    ```bash
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    ```
- Use the following command to set up the stable repository.
    ```bash
    sudo add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"
    ```
- Update the apt package index.
    ```bash
    sudo apt-get update
    ```
- Install the latest version of Docker
    ```bash
    sudo apt-get -y  install docker-ce docker-compose
    ```
- Add your normal user to the group to run docker commands as non-privileged user.
    ```bash
    sudo usermod -aG docker $USER && \
    sudo usermod -aG docker jenkins
    ```

#### `AWS EKS`
Follow steps on the link below:
https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html


#### `kubectl`
You must use a kubectl version that is within one minor version difference of your Amazon EKS cluster
control plane . For example, a 1.12 kubectl client should work with Kubernetes 1.11, 1.12, and 1.13
clusters.
- Download the Amazon EKS-vended kubectl binary for your cluster's Kubernetes version from Amazon S3:
    ```bash
    curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/kubectl
    ```
- Apply execute permissions to the binary.
    ```bash
    chmod +x ./kubectl
    ```
- Move the binary in to your PATH.
    ```bash
    sudo mv ./kubectl /usr/local/bin/kubectl
    ```
- Verify kubectl version
    ```bash
    kubectl version --short --client
    ```

#### `aws-iam-authenticator`
- Download the Amazon EKS-vended aws-iam-authenticator binary from Amazon S3:
    ```bash
    curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator
    ```
- Apply execute permissions to the binary.
    ```bash
    chmod +x ./aws-iam-authenticator
    ```
- Move the binary in to your PATH.
    ```bash
    sudo mv ./aws-iam-authenticator /usr/local/bin/aws-iam-authenticator
    ```
- Test that the aws-iam-authenticator binary works.
    ```bash
    aws-iam-authenticator help
    ```

#### `aws-cli`
- Create Virtualenv
    ```bash
    mkvirtualenv capstone-cloud-devops -p /usr/local/bin/python3.7 -a $(pwd)
    ```
- Install aws-cli
    ```bash
    pip3 install awscli --upgrade
    ```
- Setup aws-cli
    ```bash
    aws configure
    ```
- Use the AWS CLI update-kubeconfig command to create or update your kubeconfig for your cluster.
    ```bash
    aws eks --region us-west-2 update-kubeconfig --name capstone-cloud-devops
    ```

### Deploying application:
- Create pods
    ```bash
    kubectl apply -f cloudformation/k8s/deployment.yml
    ```
- Expose them as LoadBalancer service
    ```bash
    kubectl apply -f cloudformation/k8s/service.yml
    ```
- List hostname to which was application exposed
    ```bash
    kubectl get svc service-blockchain -o yaml
    ```