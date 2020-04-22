# onlyoffice-documentserver-docker-from-manual

This docker files used to check compiled DocumentServer after building
it using `build_tools`

## ubuntu 18.04

```bash
DOCUMENT_SERVER_RESULTS="~/sources/build_tools/out"
docker build --tag documentserver Ubuntu18.04
docker run -itd -p 80:80 -v ${DOCUMENT_SERVER_RESULTS}/out:/out documentserver
```
