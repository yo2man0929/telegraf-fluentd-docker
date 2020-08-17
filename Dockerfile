FROM centos:7
EXPOSE 4080

ARG NAMESPACE
ENV NAMESPACE $NAMESPACE

RUN yum update -y && \
      yum install -y yum-utils

RUN yum-config-manager --add-repo \
      https://artifactory.ouroath.com/artifactory/yamas_rpms/yamas_rpms.repo && \
      yum install -y --disablerepo=* --enablerepo=yamas_rpms-latest --releasever=7Server telegraf

RUN yum install -y https://artifactory.ouroath.com/artifactory/athens_rpms/rhel/7Server/current/x86_64/Packages/sia-2.33.4-1.el7.x86_64.rpm
RUN rm /etc/telegraf/telegraf.d/*
COPY files/telegraf.conf /etc/telegraf/
COPY files/outputs.yamas.conf /etc/telegraf/telegraf.d/
COPY files/inputs.http_listener_v2.conf /etc/telegraf/telegraf.d/

#RUN echo YAMAS_NAMESPACE=$NAMESPACE | tee /etc/default/telegraf
#RUN echo YAMAS_TLS_KEY=$TLS_KEY | tee /etc/default/telegraf
#RUN echo YAMAS_TLS_CERT=$TLS_CERT | tee /etc/default/telegraf
#RUN echo YAMAS_TLS_CA=$TLS_CA| tee /etc/default/telegraf

CMD siad
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD telegraf \
            --config /etc/telegraf/telegraf.conf \
            --config-directory /etc/telegraf/telegraf.d

#CMD tail -f /dev/null

