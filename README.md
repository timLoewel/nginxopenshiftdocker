
# nginx server to be the front of all services in our cloud

no scaling is implemented yet

Requests are proxied and distributed to the respective services.

The docker container only works in the openshift professional environment and needs a #PROJECT_NAME environment variable set.

TODO: use this more complete nginx configuration 
https://github.com/nginxinc/nginx-openshift-router/tree/master/src/nginx/conf