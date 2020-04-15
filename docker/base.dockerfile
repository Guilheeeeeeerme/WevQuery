FROM ubuntu

RUN apt-get update \
    && apt-get install wget unzip -y

WORKDIR /var/lib/base

# WORKDIR /app

# Download the data from http://www.cs.man.ac.uk/~apaolaza/wevquery/ucivitdb.zip
RUN wget http://www.cs.man.ac.uk/~apaolaza/wevquery/ucivitdb.zip

# Unzip the downloaded file.
RUN unzip ucivitdb.zip
RUN rm -rf ucivitdb.zip