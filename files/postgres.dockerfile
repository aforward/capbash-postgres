FROM ubuntu:14.10

RUN groupadd -r postgres && useradd -r -g postgres postgres

# ENSURE UTF-8
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV PG_VERSION 9.4

# grab gosu for easy step-down from root
# make the "en_US.UTF-8" locale so postgres will be utf-8 enabled by default
RUN apt-get update && apt-get install -y curl wget && rm -rf /var/lib/apt/lists/* \
  && curl -o /usr/local/bin/gosu -SL 'https://github.com/tianon/gosu/releases/download/1.1/gosu' \
  && chmod +x /usr/local/bin/gosu \
  && apt-get purge -y --auto-remove curl && \
  apt-get install -y locales ca-certificates && \
  rm -rf /var/lib/apt/lists/* && \
  localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - && \
  apt-get update && \
  apt-get upgrade && \
  apt-get install -y postgresql-$PG_VERSION pgadmin3 && \
  mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql

ENV LANG en_US.utf8
ENV PATH /usr/lib/postgresql/$PG_VERSION/bin:$PATH
ENV PGDATA /var/lib/postgresql/data

VOLUME /var/lib/postgresql/data

ADD config/psqlentry /usr/local/bin/psqlentry
RUN chmod +x /usr/local/bin/psqlentry

ENTRYPOINT ["/usr/local/bin/psqlentry"]

RUN echo "psql -h \$PSQLDB_PORT_5432_TCP_ADDR -p \$PSQLDB_PORT_5432_TCP_PORT -U postgres \$@" > /usr/local/bin/psqldb && \
    chmod 755 /usr/local/bin/psqldb

EXPOSE 5432
CMD ["postgres"]
