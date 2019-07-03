


# nginx-centos7
# Here you can use whatever base image is relevant for your application.
FROM centos:centos7

# Here you can specify the maintainer for the image that you're building
LABEL maintainer="tim loewel <tim.loewel@wuerth-it.com>"

# Export an environment variable that provides information about the application version.
# Replace this with the version for your application.
ENV NGINX_VERSION=1.12.2

# Set the labels that are used for OpenShift to describe the builder image.
LABEL io.k8s.description="Nginx proxy" \
    io.k8s.display-name="Nginx $NGINX_VERSION" \
    io.openshift.expose-services="8080:http" \
    io.openshift.tags="proxy,webserver,html,nginx" 


# Install the nginx web server package and clean the yum cache
RUN yum install -y epel-release && \
    yum install -y --setopt=tsflags=nodocs nginx && \
    yum clean all


COPY ./src/dockerScripts/entrypoint.sh /usr/local/bin/
RUN chown nginx:root /usr/local/bin/entrypoint.sh

COPY src/nginx.conf.template /etc/nginx

RUN chown -R nginx:root /usr/share/nginx
RUN chown -R nginx:root /var/log/nginx
RUN chown -R nginx:root /var/lib/nginx
RUN touch /run/nginx.pid
RUN chown -R nginx:root /run/nginx.pid
RUN chown -R nginx:root /etc/nginx
RUN chmod g+w /etc/nginx
# RUN chmod g+w /var/lib/nginx

USER nginx:root

# Set the default port for applications built using this image
EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["run"]%