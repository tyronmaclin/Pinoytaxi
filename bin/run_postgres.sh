#!/bin/bash

CID=$(
	docker run -d -v sakayka:/var/lib/postgresql/data \
	-p 127.0.0.1:5432:5432 -e POSTGRES_USER=pinoytaxi -e POSTGRES_TEMPLATE_EXTENSIONS=true \
	-e POSTGRES_PASS=sakayka -e POSTGRES_DBNAME=pinoytaxi -e POSTGRES_MULTIPLE_EXTENSIONS=postgis,hstore,postgis_topology \
	kartoza/postgis:12.0
)
IPADDR=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CID)

cat << EOF
=== DOCKER INFO: ===
IP/PORT: $IPADDR:5432
=== COMMANDS HELP: ===
psql -U pinoytaxi -h localhost -p 5432 -d pinoytaxi
	Run PostgreSQL CLI (password is pinoytaxi)
\c pinoytaxi
	Connect to the database
\dt+
	List tables in the database
exit
	Exit from PostgreSQL CLI
EOF

docker exec -ti $CID bash
