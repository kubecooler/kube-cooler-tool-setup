#!/usr/bin/env bash

set -euo pipefail

GOLANG_VERSION=1.16.5
GO_OS=linux
GO_ARC=amd64

#download golang
mkdir -p /tmp/tools
cd /tmp/tools
wget https://golang.org/dl/go${GOLANG_VERSION}.${GO_OS}-${GO_ARC}.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go${GOLANG_VERSION}.${GO_OS}-${GO_ARC}.tar.gz

export PATH=$PATH:/usr/local/go/bin

#golangci-lint
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b "$(go env GOPATH)"/bin v1.41.1

#goimports
go get -v golang.org/x/tools/cmd/goimports

# download kubebuilder and install locally.
curl -L -o kubebuilder https://go.kubebuilder.io/dl/latest/"$(go env GOOS)"/"$(go env GOARCH)"
chmod +x kubebuilder && mv kubebuilder /usr/local/bin/