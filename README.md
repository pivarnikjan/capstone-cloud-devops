[![Build Status](http://ec2-35-166-30-226.us-west-2.compute.amazonaws.com:8080/buildStatus/icon?job=capstone-cloud-devops%2Fmaster)](http://ec2-35-166-30-226.us-west-2.compute.amazonaws.com:8080/job/capstone-cloud-devops/job/master/)
# Capstone Project for Cloud DevOps Nanodegree program

- Jenkins address:
http://ec2-52-10-25-175.us-west-2.compute.amazonaws.com


### Tracking progress: <br>
[X] Create Github repository with project code. <br>
[ ] Use image repository to store Docker images. <br>
[X] Execute linting step in code pipeline. <br>
[ ] Build a Docker container in a pipeline. <br>
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

`Pyenv Pipeline`

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
    sudo usermod -aG docker $USER
    ```