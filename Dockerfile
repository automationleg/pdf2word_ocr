FROM nikolaik/python-nodejs:python3.10-nodejs24

# changing user `pn` to `node`
RUN usermod --login node --move-home --home /home/node pn
RUN groupmod --new-name node pn

ARG N8N_VERSION=1.114.2

RUN if [ -z "$N8N_VERSION" ] ; then echo "The N8N_VERSION argument is missing!" ; exit 1; fi

RUN \
    apt-get update && \
    # Add tesseract-ocr and its language packs to the installation
    apt-get -y install graphicsmagick gosu git poppler-utils tesseract-ocr tesseract-ocr-pol

# Install python requirements
RUN mkdir /requirements
COPY requirements.txt /requirements/requirements.txt
RUN python -m pip install --upgrade pip setuptools wheel
RUN pip install -r /requirements/requirements.txt

# Set a custom user to not have n8n run as root
USER root

# Install n8n globally and then install n8n-nodes-python
RUN npm_config_user=root npm install -g full-icu n8n@${N8N_VERSION} && \
    npm_config_user=root npm install -g n8n-nodes-python

ENV NODE_ICU_DATA /usr/lib/node_modules/full-icu


RUN mkdir /scripts

# Install your Python dependencies
COPY requirements.txt /scripts/requirements.txt
RUN pip3 install --no-cache-dir -r /scripts/requirements.txt

# Copy your script into the container
COPY ./pdf2word /scripts/pdf2word
COPY ./app.py /app.py

# store html web interface
RUN mkdir -p /html
COPY ./index.html /index.html

# Create data directory and set permissions
RUN mkdir -p /data && chown -R node:node /data

WORKDIR /data


COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5000/tcp
EXPOSE 5678/tcp