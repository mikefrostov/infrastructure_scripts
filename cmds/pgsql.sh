mkdir /usr/local/pgsql
chown postgres /usr/local/pgsql
su postgres
postgres$ initdb -D /usr/local/pgsql/data
