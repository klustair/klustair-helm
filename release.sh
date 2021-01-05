#!/bin/bash
helm lint klustair 
helm package -d docs klustair
helm repo index docs --url https://klustair.github.io/klustair-helm
