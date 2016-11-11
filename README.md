# Representantes Pati.to

http://representantes.pati.to

## Cómo echarlo a andar (con docker)
1) Corre una instancia de mongo:
```bash
docker run \
  --name representantes-patito-db \
  --volume representantes-patito:/data/db \
  -d mongo
```

2) Baja el respaldo (dump) de la [base de datos][dbdump].

3) Descomprime el respaldo:
```bash
tar xvfz representantes.pati.tar.gz
```

4) Obten la dirección IP de tu contenedor de Mongo:
```bash
MONGO_IP=$(
  docker inspect \
    -f '{{ .NetworkSettings.IPAddress }}' \
    representantes-patito-db
)
```

5) Restaura el respaldo en tu contenedor:
```bash
mongorestore \
  --host $MONGO_IP \
  -d representantes \
  rep2/representantes2    # Donde `rep2/` es el respaldo

# O si no tienes mongodb instalado localmente...
docker run \
--rm \
-v /path/to/rep2:/backup -it \
mongo \
/bin/bash -c mongorestore /backup --host your_mongo_ip

# Espera unos 2 o 3 minutos...
```

6) Clona el proyecto de GitHub:
```bash
git clone git@github.com:unRob/representantes.pati.to.git

# Si no tienes SSH configurado usa HTTP
git clone https://github.com/unRob/representantes.pati.to.git
```

7) Corre el proyecto con docker-compose:
```bash
docker-compose up

# Si no quieres estar viendo los logs, puedes
# correrlo como un background process
docker-compose up -d
```

8) Entra a `localhost:2222`, _(sí, el puerto son puros patitos...)_

[dbdump]: http://representantes.pati.to/representantes.pati.tar.gz

## Como contribuir

En corto, con los distritos electorales de tu estado, en formato [GeoJSON](http://geojson.org), así como la información de tu congreso local.

### Distritos electorales y Secciones
Corriendo `./bin/distritos` podemos tomar el [Marco Geográfico Nacional](https://github.com/unRob/informacion-publica) que me dió el IFE, e ingestarlo a MongoDB.


### Crawler
con este script iniciamos la base de datos, corriendo `bin/crawl`

```text
usage: ./crawl camara:accion [test]
Cámaras:
  - diputados
  - senado
Acciones:
  actores, comisiones, asistencias
```

La explicación larga está en el [wiki](../../wiki/Como-contribuir), y para echar a andar tu entorno de desarrollo, puedes leer [los primeros pasos](../../wiki/First-RUN,-Forrest!-RUN!)

## Licencia
Licenciado bajo la flamantemente nueva (as of 2014-09) [Licencia Patito](LICENSE.md)
