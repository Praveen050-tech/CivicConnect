FROM tomcat:9.0-jre17-alpine

# Remove default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy application files to ROOT context
COPY . /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080

CMD ["catalina.sh", "run"]
