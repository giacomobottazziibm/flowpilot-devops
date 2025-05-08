# System Requirements

- Ubuntu 24
- Postgres 17
- Redis
- Elastic Search 8
- Nginx 1.24
- Python 3.12.3
- Npm 9.2
- Node 21

# Dependencies

## Postgres

```
sudo apt install -y postgresql-common
sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
sudo apt install postgresql-17-pgvector
```

```
sudo -u postgres psql
CREATE EXTENSION vector;
```

```
sudo systemctl enable postgresql
sudo service postgresql start
```

```
sudo -u postgres createuser flowpilotuser
sudo -u postgres createdb flowpilot
sudo -u postgres psql -c "alter user flowpilotuser with encrypted password  'flowpilotuser1' ";
sudo -u postgres psql -c 'grant all privileges on database flowpilot to flowpilotuser';
sudo -u postgres psql -c 'GRANT ALL ON ALL TABLES IN SCHEMA public TO flowpilotuser';
sudo -u postgres psql -c 'ALTER DATABASE flowpilot OWNER TO flowpilotuser';
```

## Redis

`sudo apt install redis-server`


## Elastic Search


https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-elasticsearch-on-ubuntu-22-04


```
vi /etc/elasticsearch/elasticsearch.yml
action.auto_create_index: +*
```

Create the index

`curl -XPUT 'http://localhost:9200/nl2insights'`


## poetry

```
sudo apt install pipx
#poetry config http-basic.nl2insights_pypi <username>
pipx install poetry
```


## Node

```
curl -fsSL https://deb.nodesource.com/setup_21.x -o nodesource_setup.sh
sudo -E bash nodesource_setup.sh
sudo apt-get install -y nodejs npm
```


## Nginx
define path


# Application components

## nl2insights/api

`poetry install`

define .env

`poetry run uvicorn --host 0.0.0.0 --port 9000 api.main:app --reload`


## DB service

```
poetry config http-basic.nl2insights_pypi <username>
poetry install
```

define .env


export DB_PROXY_REDIS_URI=redis://localhost:6379/0
export UPLOADS_PATH=/opt/flowpilot/ui/uploads/

`poetry run python -m database_proxy_service.main`


## evaluator service

`poetry install`


```
export PYTHONPATH=/home/ubuntu/.cache/pypoetry/virtualenvs/evaluator-service-4ApNwGWJ-py3.12/lib/python3.12/site-packages/
./app.sh
```

## Ui

### Database schema creation
```
export DATABASE_URI=postgres://<USERNAME>:<PASSWORD>@localhost:5432/flowpilot
npx prisma db push
npx zenstack generate
```

### Start the application

Build the production package
```
npm install
npm run build
```

Start the server
```
cd .next/standalone
node server.js
```

# Configurations

## Account and apiKey

```
INSERT INTO public."User" (id,"name",email,"emailVerified",image,"role") VALUES
	 ('1','pmadmin','giacomo.bottazzi@ibm.com','2025-04-22 19:10:25',NULL,'admin');
INSERT INTO public."ApiKey" (apikey,"usage","userId",priority,concurrency) VALUES
	 ('fp_1234567890aaaa',0,'1',10,10);

```

-------- 

### Links
- https://github.ibm.com/nl2insights/text2sql
- https://github.ibm.com/flowpilot/ui
- https://github.ibm.com/flowpilot/db-service
- https://github.ibm.com/flowpilot/evaluator-service
- https://github.ibm.com/nl2insights/api

- https://flowpilot.res.ibm.com/docs





