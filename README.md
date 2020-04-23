# onlyoffice-documentserver-run-compiled

This docker files used to check compiled DocumentServer after building
it using [build_tools](https://github.com/ONLYOFFICE/build_tools)

**Attention** This project is not compiling DocumentServer, it just run it

## ubuntu 18.04

```bash
DOCUMENT_SERVER_RESULTS="~/sources/build_tools/out"
docker build --tag documentserver Ubuntu18.04
docker run -itd -p 80:80 -v ${DOCUMENT_SERVER_RESULTS}:/out documentserver
```

## Other systems

Replace `ubuntu18.04` in `docker build` command to another
