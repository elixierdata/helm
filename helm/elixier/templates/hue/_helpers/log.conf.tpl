{{- define "hue-log-config" }}
# Just log to stdout for Docker
[logger_root]
handlers=stdout

[logger_access]
handlers=stdout
qualname=access

[logger_django_auth_ldap]
handlers=stdout
qualname=django_auth_ldap

[logger_kazoo_client]
handlers=stdout
qualname=kazoo.client

[logger_djangosaml2]
handlers=stdout
qualname=djangosaml2

[logger_django_db]
handlers=stdout
qualname=django.db.backends

# Handlers
[handler_stdout]
level=INFO
class=StreamHandler
formatter=default
args=(sys.stdout,)

[formatter_default]
class=desktop.log.formatter.Formatter
format=[%(asctime)s] %(module)-12s %(levelname)-8s %(message)s
datefmt=%d/%b/%Y %H:%M:%S %z

[loggers]
keys=root,access,django_auth_ldap,kazoo_client,djangosaml2,django_db

[handlers]
keys=stdout

[formatters]
keys=default

{{- end }}
