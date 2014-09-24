capbash-postgres
==============

Scripts for installing postgres, should be used in conjunction with capbash

# How to Install #

Install capbash first, more details at:
https://github.com/aforward/capbash

```
curl -s https://raw.githubusercontent.com/aforward/capbash/master/capbash-installer | bash
capbash new YOUR_REPO_ROOT
cd YOUR_REPO_ROOT
```

Now you can install postgres into your project

```
capbash install postgres
```

# Configurations #

The available configurations include:

```
POSTGRES_LAUNCHER_DIR=${POSTGRES_LAUNCHER_DIR-/var/local/postgres}
POSTGRES_DATA_DIR=${POSTGRES_DATA_DIR-${POSTGRES_LAUNCHER_DIR}/data}
POSTGRES_PORT=${POSTGRES_PORT-3306}
POSTGRES_ADMIN_USERNAME=${POSTGRES_ADMIN_USERNAME-admin}
POSTGRES_ADMIN_PASSWORD=${POSTGRES_ADMIN_PASSWORD-yth3fn0t}
```

# Deploy to Remote Server #

To push the postgres script to your server, all you need if the IP or hostname of your server (e.g. 192.167.0.48) and your root password.

```
capbash deploy <IP> postgres
```

For example,

```
capbash deploy 127.0.0.1 postgres
```
