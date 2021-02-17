# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>

FROM centos:centos7
MAINTAINER Arnab Kumar Nandy

RUN yum -y update; yum clean all
RUN yum -y install sudo epel-release; yum clean all
RUN yum -y install https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
RUN yum -y install postgresql96-server postgresql96 postgresql96-contrib supervisor pwgen; yum clean all
#RUN yum -y install postgresql-server postgresql postgresql-contrib supervisor pwgen; yum clean all


#ADD ./postgresql-setup /usr/bin/postgresql-setup
ADD ./postgresql96-setup /usr/bin/postgresql96-setup
ADD ./supervisord.conf /etc/supervisord.conf
ADD ./start_postgres.sh /start_postgres.sh

#Sudo requires a tty. fix that.
RUN sed -i 's/.*requiretty$/#Defaults requiretty/' /etc/sudoers
#RUN chmod +x /usr/bin/postgresql-setup
RUN chmod +x /usr/bin/postgresql96-setup
RUN chmod +x /start_postgres.sh

RUN /usr/bin/postgresql96-setup initdb

ADD ./postgresql96.conf /var/lib/pgsql/9.6/data/postgresql.conf

RUN chown -v postgres.postgres /var/lib/pgsql/9.6/data/postgresql.conf

RUN echo "host    all             all             0.0.0.0/0               md5" >> /var/lib/pgsql/9.6/data/pg_hba.conf

VOLUME ["/var/lib/pgsql"]

EXPOSE 5432

CMD ["/bin/bash", "/start_postgres.sh"]
