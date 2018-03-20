FROM dkuida/oracle-java8
MAINTAINER Dan Kuida < dan@kuida.org >
ENV REFRESHED_AT 2017-08-10


RUN useradd -r tomcat9 --shell /bin/false


RUN apt-get install unzip


WORKDIR /opt
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.0.M26/bin/apache-tomcat-9.0.0.M26.zip

RUN unzip apache-tomcat-9.0.0.M26
RUN ln -s apache-tomcat-9.0.0.M26 tomcat-latest

RUN chown -hR tomcat9: tomcat-latest apache-tomcat-9.0.0.M26


RUN chmod +x tomcat-latest/bin/catalina.sh

ENV CATALINA_HOME /opt/tomcat-latest
ENV CATALINA_PID $CATALINA_HOME/bin/catalina.pid
ENV CATALINA_SH /opt/tomcat-latest/bin/catalina.sh
ENV CATALINA_TMPDIR /tmp/tomcat9-tomcat9-tmp
ENV GEOSERVER_DATA_DIR /mnt/geoserver-data
ENV GEOSERVER_LOG_PATH /mnt/logs
ENV GEOSERVER_LOG_LOCATION $GEOSERVER_LOG_PATH/geoserver.log
ENV GEOSERVER_TMP_DIR /tmp/tomcat9-tomcat9-tmp
RUN mkdir -p $ CATALINA_TMPDIR


RUN mkdir $GEOSERVER_DATA_DIR

RUN mkdir /mnt/logs
RUN mkdir /mnt/ortophoto
RUN mkdir /mnt/cache
RUN mkdir $GEOSERVER_TMP_DIR


RUN chown -Rf tomcat9:tomcat9 /mnt/logs
RUN chown -Rf tomcat9:tomcat9 $GEOSERVER_DATA_DIR
RUN chown -Rf tomcat9:tomcat9 $GEOSERVER_LOG_PATH
RUN chown -Rf tomcat9:tomcat9 /mnt/ortophoto
RUN chown -Rf tomcat9:tomcat9 /mnt/cache
RUN chown -Rf tomcat9:tomcat9 $GEOSERVER_TMP_DIR


USER tomcat9

WORKDIR /tmp

RUN wget https://netix.dl.sourceforge.net/project/geoserver/GeoServer/2.11.2/geoserver-2.11.2-war.zip
#RUN wget https://netcologne.dl.sourceforge.net/project/geoserver/GeoServer/2.11.2/extensions/geoserver-2.11.2-vectortiles-plugin.zip
RUN wget https://10gbps-io.dl.sourceforge.net/project/geoserver/GeoServer/2.11.2/extensions/geoserver-2.11.2-pyramid-plugin.zip
#RUN wget https://10gbps-io.dl.sourceforge.net/project/geoserver/GeoServer/2.11.2/extensions/geoserver-2.11.2-gdal-plugin.zip

RUN unzip geoserver-2.11.2-war.zip *.war -d $CATALINA_HOME/webapps/

WORKDIR $CATALINA_HOME

RUN unzip webapps/geoserver.war -d $CATALINA_HOME/webapps/geoserver

WORKDIR /tmp

RUN unzip geoserver-2.11.2-pyramid-plugin.zip -d $CATALINA_HOME/webapps/geoserver/WEB-INF/lib/



USER tomcat9

VOLUME ["/mnt/geoserver-data", "/mnt/logs/", "/mnt/ortophoto", "/mnt/cache"]

EXPOSE 8080

#RUN cp -R $CATALINA_HOME/webapps/geoserver/data/* $GEOSERVER_DATA_DIR/

RUN rm -rf /opt/tomcat-latest/webapps/geoserver/data/*


#enable CORS
#COPY web.xml /opt/tomcat-latest/webapps/geoserver/WEB-INF/
#RUN chown -f tomcat9:tomcat9 /opt/tomcat-latest/webapps/geoserver/WEB-INF/web.xml



CMD [ "/opt/tomcat-latest/bin/catalina.sh", "run" ]




