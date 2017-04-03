# onlyoffice-documentserver-docker-from-manual
This docker is created from command from manual http://helpcenter.onlyoffice.com/server/linux/document/compile-source-code.aspx

```
BUILD_BRANCH=master && \
ufw disable && \
git clone https://github.com/onlyoffice-testing-robot/documentserver-docker-from-manual.git && \
docker build --build-arg build_branch=$BUILD_BRANCH -t documentserver documentserver-docker-from-manual && \
docker run -itd -p 8080:80 documentserver && \
git clone https://github.com/onlyoffice-testing-robot/documentserver-nodejs-example-docker.git && \
vim documentserver-nodejs-example-docker/local.json && \
docker build --build-arg build_branch=$BUILD_BRANCH -t test-example documentserver-nodejs-example-docker && \
docker run -itd -p 80:80 test-example 
```
