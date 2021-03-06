#!/bin/bash

if [ -d target ]; then
    rm -rf target
fi

mkdir target

VERSION="$(git rev-parse --short HEAD)"

# toaster.txt
echo "version=${VERSION}"
echo "${VERSION}" > target/toaster.txt
echo "v2-${VERSION}" > target/toaster-v2.txt
echo "v3-${VERSION}" > target/toaster-v3.txt

# web
cp -rf web/* target/

# install.sh
cp -rf install-v2.sh target/install
cp -rf install-v2.sh target/install-v2
cp -rf install-v3.sh target/install-v3

# toaster v2
pushd v2
tar -czf ../target/toaster-v2.tar.gz extra install package *.sh
popd

# toaster v3
pushd v3
tar -czf ../target/toaster-v3.tar.gz install *.sh
popd
