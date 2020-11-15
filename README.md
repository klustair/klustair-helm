<p align="center"><img src="https://raw.githubusercontent.com/klustair/klustair-frontend/master/docs/img/klustair.png" width="200"></p>

# <a href='https://github.com/klustair/klustair'>KlustAIR Helm chart</a>
The Klustair scanner scanns your Kubernetes namespaces for the used images and submits them to Anchore. This is the helm part. 

### Related Klustair projects: 
- <a href="https://github.com/klustair/klustair-frontend">Klustair Frontend</a> to view the scanner results
- <a href="https://github.com/klustair/klustair">Klustair Runner</a> to scan all your used images with trivy

### Related opensource projects
- <a href="https://github.com/aquasecurity/trivy">trivy</a> A Simple and Comprehensive Vulnerability Scanner for Containers and other Artifacts
- (DEPRECATED) <a href="https://github.com/anchore/anchore-engine">anchore-engine</a> A service that analyzes docker images and applies user-defined acceptance policies to allow automated container image validation and certification
- <a href="https://github.com/Shopify/kubeaudit">kubeaudit</a> kubeaudit helps you audit your Kubernetes clusters against common security controls

## Installation

### add repository
```
$ helm repo add klustair https://klustair.github.io/klustair-helm
$ helm search repo klustair
$ helm install my-klustair klustair
```

### git installation
```
$ git clone git@github.com:klustair/klustair-helm.git
$ cd klustair-helm
$ helm install -f values.yaml my-klustair klustair
```

## Generate laravel key
Chose one of the following commands
```
$ dd if=/dev/urandom bs=1 count=32 2>/dev/null | base64
```
```
$ date +%s | md5 | base64 | head -c 64 ; echo
```
```
$ openssl rand -base64 32
```

## Chart Configuration

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
