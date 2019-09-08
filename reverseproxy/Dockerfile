
# Pull base image.
#FROM dockerfile/ubuntu
FROM ubuntu:16.04

# Install Nginx.
RUN \
#  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

RUN rm /etc/nginx/sites-available/default
COPY nginx.conf /etc/nginx/sites-available/default

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 80

