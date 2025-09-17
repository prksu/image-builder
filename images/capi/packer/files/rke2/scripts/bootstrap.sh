#!/usr/bin/env bash
#
# This script installs RKE2 artifacts to be used to airgap bootstraping RKE2.

set -o errexit
set -o nounset
set -o pipefail

function install::rke2_components {
    RKE2_VERSION=$1
    echo "Install RKE2 components"

    # We're using wget here to avoid download failure on slow internet, since Github Token will expires in 5m
    mkdir -p /opt/rke2-artifacts
    until wget -c https://github.com/rancher/rke2/releases/download/${RKE2_VERSION}/rke2-images.linux-amd64.tar.zst -O /opt/rke2-artifacts/rke2-images.linux-amd64.tar.zst; do :; done
    until wget -c https://github.com/rancher/rke2/releases/download/${RKE2_VERSION}/rke2.linux-amd64.tar.gz -O /opt/rke2-artifacts/rke2.linux-amd64.tar.gz; do :; done
    until wget -c https://github.com/rancher/rke2/releases/download/${RKE2_VERSION}/sha256sum-amd64.txt -O /opt/rke2-artifacts/sha256sum-amd64.txt do :; done
    until wget -c https://get.rke2.io -O /opt/install.sh; do :; done
}

install::rke2_components $1
