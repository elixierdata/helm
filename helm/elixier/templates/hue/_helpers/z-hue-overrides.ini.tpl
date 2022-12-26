# vim: set syntax=dosini:

{{ define "hue-config-overrides" }}
# Lightweight Hue configuration file
# ==================================

[desktop]

# Set this to a random string, the longer the better.
secret_key=kasdlfjknasdfl3hbaksk3bwkasdfkasdfba23asdf

# Webserver listens on this address and port
http_host=0.0.0.0
http_port=8888

# Time zone name
time_zone={{ .Values.timezone }}

# Enable or disable debug mode.
django_debug_mode=false

# Enable or disable backtrace for server error
http_500_debug_mode=false

app_blacklist=search,hbase,security,impala,hive,jobbrowser,oozie,liboozie,indexer,metastore

# Use gunicorn or not
use_cherrypy_server=false

# Gunicorn work class: gevent or evenlet, gthread or sync.
gunicorn_work_class=sync
gunicorn_number_of_workers=1

# Configuration options for specifying the Desktop Database. For more info,
# see http://docs.djangoproject.com/en/1.11/ref/settings/#database-engine
# ------------------------------------------------------------------------
[[database]]
# Database engine is typically one of:
# postgresql_psycopg2, mysql, sqlite3 or oracle.
#
# Note that for sqlite3, 'name', below is a path to the filename. For other backends, it is the database name
# Note for Oracle, options={"threaded":true} must be set in order to avoid crashes.
# Note for Oracle, you can use the Oracle Service Name by setting "host=" and "port=" and then "name=<host>:<port>/<service_name>".
# Note for MariaDB use the 'mysql' engine.

engine=postgresql_psycopg2
host={{ include "elixier.hue.db_host" . }}
port=5432
user={{ .Values.hue.db_user }}
password={{ .Values.hue.db_password }}
name={{ .Values.hue.db_name }}

# engine=mysql
# host=database
# port=3306
# user=root
# password=secret
# name=hue

###########################################################################
# Settings to configure the snippets available in the Notebook
###########################################################################

[notebook]

enable_sql_indexer=false

# One entry for each type of snippet.
[[interpreters]]

# Define the name and how to connect and execute the language.
# https://docs.gethue.com/administrator/configuration/editor/

# Example for Docker compose
# [[[mysql]]]
# name = MySQL
# interface=sqlalchemy
# ## https://docs.sqlalchemy.org/en/latest/dialects/mysql.html
#  options='{"url": "mysql://root:secret@database:3306/hue"}'
# ## options='{"url": "mysql://${USER}:${PASSWORD}@localhost:3306/hue"}'

# [[[hive]]]
# name=Hive
# interface=hiveserver2

# [[[impala]]]
# name=Impala
# interface=hiveserver2

# [[[sparksql]]]
#  name = Spark Sql
#  interface=sqlalchemy
#  options='{"url": "hive://user:password@localhost:10000/database"}'

# [[[sparksql]]]
# name=SparkSql
# interface=livy

# [[[spark]]]
# name=Scala
# interface=livy

# [[[pyspark]]]
# name=PySpark
# interface=livy

# [[[r]]]
# name=R
# interface=livy

# [[jar]]]
# name=Spark Submit Jar
# interface=livy-batch

# [[[py]]]
# name=Spark Submit Python
# interface=livy-batch

# [[[text]]]
# name=Text
# interface=text

# [[[markdown]]]
# name=Markdown
# interface=text

# [[[sqlite]]]
# name = SQLite
# interface=rdbms

# [[[postgresql]]]
# name = PostgreSQL
# interface=rdbms

# [[[oracle]]]
# name = Oracle
# interface=rdbms

# [[[solr]]]
# name = Solr SQL
# interface=solr
# ## Name of the collection handler
# # options='{"collection": "default"}'

# [[[pig]]]
# name=Pig
# interface=oozie

# [[[java]]]
# name=Java
# interface=oozie

# [[[spark2]]]
# name=Spark
# interface=oozie

# [[[mapreduce]]]
# name=MapReduce
# interface=oozie

# [[[sqoop1]]]
# name=Sqoop1
# interface=oozie

# [[[distcp]]]
# name=Distcp
# interface=oozie

# [[[shell]]]
# name=Shell
# interface=oozie

# [[[presto]]]
# name=Presto SQL
# interface=presto
# ## Specific options for connecting to the Presto server.
# ## The JDBC driver presto-jdbc.jar need to be in the CLASSPATH environment variable.
# ## If 'user' and 'password' are omitted, they will be prompted in the UI.
# options='{"url": "jdbc:presto://{{ include "elixier.fullname" . }}-presto:8080/catalog/schema", "driver": "io.prestosql.jdbc.PrestoDriver", "user": "root", "password": "root"}'

# [[[clickhouse]]]
# name=ClickHouse
# interface=jdbc
# ## Specific options for connecting to the ClickHouse server.
# ## The JDBC driver clickhouse-jdbc.jar and its related jars need to be in the CLASSPATH environment variable.
# options='{"url": "jdbc:clickhouse://localhost:8123", "driver": "ru.yandex.clickhouse.ClickHouseDriver", "user": "readonly", "password": ""}'

[[[presto]]]
name = Presto
interface=sqlalchemy
options='{"url": "presto://user@{{ include "elixier.fullname" . }}-presto:8080/default/default"}'


[dashboard]

# Activate the SQL Dashboard (beta).
has_sql_enabled=true

is_enabled=false

[hadoop]

# Configuration for HDFS NameNode
# ------------------------------------------------------------------------
[[hdfs_clusters]]
# HA support by using HttpFs

[[[default]]]

# Enter the filesystem uri
## fs_defaultfs=hdfs://localhost:8020

# Use WebHdfs/HttpFs as the communication mechanism.
# Domain should be the NameNode or HttpFs host.
# Default port is 14000 for HttpFs.
webhdfs_url=http://{{ include "elixier.fullname" . }}-httpfs:14000/webhdfs/v1

is_enabled=true

# Configuration for YARN (MR2)
# ------------------------------------------------------------------------
[[yarn_clusters]]

# [[[default]]]

# Enter the host on which you are running the ResourceManager
## resourcemanager_host=localhost

# The port where the ResourceManager IPC listens on
## resourcemanager_port=8032

# URL of the ResourceManager API
## resourcemanager_api_url=http://localhost:8088

# URL of the ProxyServer API
## proxy_api_url=http://localhost:8088

# URL of the HistoryServer API
## history_server_api_url=http://localhost:19888

# URL of the Spark History Server
## spark_history_server_url=http://localhost:18088


###########################################################################
# Settings to configure Beeswax with Hive
###########################################################################

[beeswax]

# Host where HiveServer2 is running.
# If Kerberos security is enabled, use fully-qualified domain name (FQDN).
## hive_server_host=localhost

# Port where HiveServer2 Thrift server runs on.
## hive_server_port=10000


###########################################################################
# Settings to configure Impala
###########################################################################

[impala]
# Host of the Impala Server (one of the Impalad)
## server_host=localhost

# Port of the Impala Server
## server_port=21050


###########################################################################
# Settings to configure the Spark application.
###########################################################################

[spark]
# The Livy Server URL.
## livy_server_url=http://localhost:8998

# Configure Livy to start in local 'process' mode, or 'yarn' workers.
## livy_server_session_kind=yarn

# Whether Livy requires client to perform Kerberos authentication.
## security_enabled=false

# Host of the Sql Server
## sql_server_host=localhost

# Port of the Sql Server
## sql_server_port=10000

# Choose whether Hue should validate certificates received from the server.
## ssl_cert_ca_verify=true


###########################################################################
# Settings to configure HBase Browser
###########################################################################

[hbase]
# Comma-separated list of HBase Thrift servers for clusters in the format of '(name|host:port)'.
## hbase_clusters=(Cluster|localhost:9090)


###########################################################################
# Settings to configure Solr Search
###########################################################################

[search]

# URL of the Solr Server
## solr_url=http://localhost:8983/solr/


###########################################################################
# Settings to configure liboozie
###########################################################################

[liboozie]
# The URL where the Oozie service runs on. This is required in order for
# users to submit jobs. Empty value disables the config check.
## oozie_url=http://localhost:11000/oozie


###########################################################################
# Settings for the AWS lib
###########################################################################

[aws]
[[aws_accounts]]
# Default AWS account

[[[default]]]
# AWS credentials
#
#access_key_id={{ .Values.s3a.access_key }}
#secret_access_key={{ .Values.s3a.secret_key }}
#
## security_token=

# Execute this script to produce the AWS access key ID.
## access_key_id_script=/path/access_key_id.sh

# Execute this script to produce the AWS secret access key.
## secret_access_key_script=/path/secret_access_key.sh

# Allow to use either environment variables or
# EC2 InstanceProfile to retrieve AWS credentials.
## allow_environment_credentials=yes

# AWS region to use, if no region is specified, will attempt to connect to standard s3.amazonaws.com endpoint
## region=us-east-1
#region=ap-northeast-2
#
## Endpoint overrides
#host={{ include "elixier.s3a.host" . }}
#
# Proxy address and port
## proxy_address=
## proxy_port=8080
## proxy_user=
## proxy_pass=

# Secure connections are the default, but this can be explicitly overridden:
# is_secure=false

[filebrowser]
# remote_storage_home={{ .Values.hive.metastore_warehouse_dir }}

###########################################################################
# Settings for the Azure lib
###########################################################################
[azure]
[[azure_accounts]]
# [[[default]]]
# client_id=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx
# client_secret=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# tenant_id=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx

# [[abfs_clusters]]
# [[[default]]]
# fs_defaultfs=abfs://account@account.dfs.core.windows.net
# webhdfs_url=https://account.dfs.core.windows.net/


###########################################################################
# Settings to configure Metadata
###########################################################################

[metadata]

[[navigator]]
# Navigator API URL (without version suffix).
## api_url=http://localhost:7187/api

# Which authentication to use: CM or external via LDAP or SAML.
## navmetadataserver_auth_type=CMDB

# Username of the CM user used for authentication.
## navmetadataserver_cmdb_user=hue
# CM password of the user used for authentication.
## navmetadataserver_cmdb_password=
# Execute this script to produce the CM password. This will be used when the plain password is not set.
# navmetadataserver_cmdb_password_script=

# [[atlas]]
#  interface=atlas
#  api_url=http://localhost:21000/api/atlas/v2
#  server_user=admin
#  server_password=admin
{{- end }}
