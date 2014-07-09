```
docker build -t=codecraig/docker-glu .
docker run -p 80:80 -t -i codecraig/docker-glu /bin/bash
```

Once in...

```
/data/org.linkedin.glu.packaging-all-5.5.1/bin/tutorial.sh start
nginx
```

Now you can hit http://<ip>/console to see Glu.
