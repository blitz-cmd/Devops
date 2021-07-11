FROM tomcat:8.0
COPY --from=build **.*.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]