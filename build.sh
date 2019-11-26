#!/bin/bash
set -ex
cd `dirname $0`

function yarn_check {
  echo "检查yarn"
  if ! which yarn -v &> /dev/null ;then
    echo "安装yarn"
    npm i -g yarn
  fi
}

function buildZip {
  echo "压缩项目"
  cd dist
  tar -czf ../$APP_NAME-v$VERSION.tar.gz .
  cd ..
}

# 检查yarn
yarn_check

echo "build project"
yarn --frozen-lockfile && yarn build

if [[ ${BUILD_TYPE} = "image" ]];
  then
    # 构建镜像
    docker build -t ${APP_NAME}:v${VERSION} .
  else
    # 构建zip包
    buildZip
fi
