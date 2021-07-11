FROM tomcat:8.0
ADD /var/lib/jenkins/jobs/build_tomcat_docker_image/builds/${env.BUILD_ID}/**/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]