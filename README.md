<p align="center"><img src="https://raw.githubusercontent.com/klustair/klustair-frontend/master/docs/img/klustair.png" width="200"></p>

# <a href='https://github.com/klustair/klustair'>KlustAIR Helm chart</a>
[![Artifact HUB](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/klustair)](https://artifacthub.io/packages/search?repo=klustair)
[![Helm validate](https://github.com/klustair/klustair-helm/actions/workflows/helm.yml/badge.svg?branch=main)](https://github.com/klustair/klustair-helm/actions/workflows/helm.yml)

Klustair collects all the used images your Kubernetes namespaces and runs a trivy scan on them. 

### Related Klustair projects: 
- <a href="https://github.com/klustair/klustair-frontend">Klustair Frontend</a> to view the scanner results
- <a href="https://github.com/klustair/klustair">Klustair Runner</a> to collect and scan all your used images with trivy

### Related opensource projects
- <a href="https://github.com/aquasecurity/trivy">trivy</a> A Simple and Comprehensive Vulnerability Scanner for Containers and other Artifacts
- <a href="https://github.com/Shopify/kubeaudit">kubeaudit</a> kubeaudit helps you audit your Kubernetes clusters against common security controls
- <a href="https://github.com/anchore/anchore-engine">anchore-engine</a> (DEPRECATED) A service that analyzes docker images and applies user-defined acceptance policies to allow automated container image validation and certification

## Screenshots
<a href="https://github.com/klustair/klustair-frontend/blob/master/docs/screenshots/0.3.0/SCREENSHOTS.md">Finde more screenshots here</a>

<img src="https://raw.githubusercontent.com/klustair/klustair-frontend/master/docs/screenshots/0.3.0/vulnerabilities.details.png" width="500" alt="vulnerabilities details">


## Installation

## Run a local Kubernetes Cluster with kind

### Installation with helm
```
export RELEASENAME=my-klustair
kind create cluster --config kind.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
helm install $RELEASENAME ./klustair -f ./klustair/values.yaml -n $RELEASENAME --create-namespace
```

### Uninstall
```
helm list 
helm uninstall $RELEASENAME
kind delete cluster klustair
```

## Generate Laravel key
The key consists of 32 random characters

Chose one of the following commands to generate one or copy the Laravel key from https://wwww.keygen.io
```
dd if=/dev/urandom bs=1 count=32 2>/dev/null | base64
```
or
```
date +%s | md5 | base64 | head -c 32 ; echo
```
of
```
openssl rand -base64 32
```

### Helm chart repo installation
`trivy.repoCredentials` and `klustair.gcloudCredentials` are optional

```
export RELEASENAME=my-klustair
helm repo add klustair https://klustair.github.io/klustair-helm
helm install \
--set klustairfrontend.url=your.klustair.domain.com \
--set klustairfrontend.appkey=base64:<put your generated Laravel key here> \
--set-file klustair.kubeconfig=/path/to/your/kubeconfig \
--set-file trivy.repoCredentials=/path/to/your/repocredentials.json \
--set-file klustair.gcloudCredentials=/path/to/your/gcloudcredentials.json \
$RELEASENAME klustair/klustair 
```

### Git installation
```
export RELEASENAME=my-klustair
git clone git@github.com:klustair/klustair-helm.git
cd klustair-helm
helm install -f ./klustair/values.yaml $RELEASENAME ./klustair
```
### Update/Configure secrets
Follow this instruction to generate Google Serviceaccount and credentials

https://ahmet.im/blog/authenticating-to-gke-without-gcloud/


```
export RELEASENAME=$(helm list | grep klustair | awk '{print $1}')
kubectl delete secrets $RELEASENAME-configs
kubectl create secret generic $RELEASENAME-configs \
--from-file=kube.config=/path/to/your/kubeconfig \
--from-file=repo-credentials.json=/path/to/your/repocredentials.json \
--from-file=gcloud-credentials.json=/path/to/your/gcloudcredentials.json
```
#### Example credentials
https://github.com/klustair/klustair/blob/master/repo-credentials.json.example

## Chart Configuration
You find a full list of all Chart values here: 

https://artifacthub.io/packages/helm/klustair/klustair?modal=values-schema 


| Key                                    | Type             | Default             | Description  |
|----------------------------------------|------------------|---------------------|--------------|
| image.repository                       | string           | `klustair/klustair` | repository of the klustiar runner |
| image.repositoryFrontend               | string           | `klustair/klustair-frontend` | repository of the klustair frontend |
| image.tag                              | string           | `v0.2.2`            |              |
| image.pullPolicy                       | string           | `Always`            |              |
| klustairfrontend.appkey                | string           | example key         | Laravel App Key |
| klustairfrontend.url                   | string           | example URL         | Frontend URL |
| klustair.kubeconfig                    | multiline string | example config      | kubectl configuration |
| trivy.enabled                          | boolean          | `true`              |              |
| trivy.timeout                          | string           | `"2m0s"`            |              |
| trivy.repoCredentials                  | multiline string | example JSON        |              |
| postgresql.postgresqlUsername          | string           | `klustair`          |              |
| postgresql.postgresqlDatabase          | string           | `klustair`          |              |
| postgresql.persistence.storageClass    | string           | `"-"`               |              |
| postgresql.persistence.size            | string           | `1Gi`               |              |
| postgresql.resources.requests.memory   | string           | `256Mi`             |              |
| postgresql.resources.requests.cpu      | string           | `250m`              |              |
