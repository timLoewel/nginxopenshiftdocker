#!/bin/bash -e
# The run script executes the server that runs your application.cat d

echo "initializing the nginx.conf with environment"

id
ls -la /etc/nginx
# prepare the config from environment variables, nginx does not know env vars
sed "s/%PROJECT_NAME%/$PROJECT_NAME/" /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf


# We will turn off daemonizing for the nginx process so that the container
# doesn't exit after the process runs.
exec /usr/sbin/nginx -g "daemon off;"
