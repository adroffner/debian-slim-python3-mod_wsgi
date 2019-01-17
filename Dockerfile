# Debian Slim - Python 3 and Apache/MOD_WSGI (See mod_wsgi-express)
# =============================================================================
FROM dockercentral.it.example.com:5100/com.example.dev.argos/debian-slim-python3:3.6.6

# HTTP Proxy Settings
ENV http_proxy="http://one.proxy.example.com:8080"
ENV https_proxy="http://one.proxy.example.com:8080"
ENV HTTP_PROXY="http://one.proxy.example.com:8080"
ENV HTTPS_PROXY="http://one.proxy.example.com:8080"

USER root

# =============================================================================
# Debian: Ensure we have an up to date package index.
# =============================================================================
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update

# Install Apache2 for use from port 80.
# =============================================================================
RUN apt-get -y install apache2 apache2-dev

# Install mod_wsgi-express over Apache2.
# =============================================================================
RUN /usr/local/bin/pip3 install mod_wsgi

# "www-data" runs a sample "hello world" WSGI script.
# =============================================================================
WORKDIR /home/www-data
COPY ./hello.wsgi ./hello.wsgi

# Start an "application container"
EXPOSE 8001
ENTRYPOINT /usr/local/bin/mod_wsgi-express start-server hello.wsgi \
    --user www-data --maximum-requests=250 \
    --access-log \
    --access-log-format "[hello-world][%>s] %h %l %u %b \"%{Referer}i\" \"%{User-agent}i\" \"%r\"" \
    --error-log-format  "[hello-world][%l] %M" \
    --log-to-terminal --log-level DEBUG \
    --host 0.0.0.0 --port 8001

# =============================================================================
# Clean up the package index.
# =============================================================================
RUN rm -r /var/lib/apt/lists/*
