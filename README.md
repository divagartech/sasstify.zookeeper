# sasstify.zookeeper
Setup your own Zookeeper command in one command

## Pre-request
Following should be up and running already
1. Docker
2. Kubernetes

## Configuration
Change replicas and ZOO_SERVERS values, as per your requirement currently its configured as 3

## Command
1. Navigate to project base directory
2. kubectl apply -k8s/

## Command for Debugging and exploring
1. For checking running pods - kubectl get pods 
2. For logging into shell - kubectl exec -it POD-NAME bash
3. For checking pod logs - kubectl logs -f POD-NAME

