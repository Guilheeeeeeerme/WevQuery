
FROM node:10

ARG MONGO_INITDB_ROOT_USERNAME
ARG MONGO_INITDB_ROOT_PASSWORD
ARG MONGO_INITDB_DATABASE
ARG WEVQUERY_HOST

WORKDIR /app
COPY UCIVIT-WebIntCap .

# Then the file dbAccessData.js needs to be completed. 
# The content (below) has default options for a deployment of a server in the local computer. 
# DBUSERNAME and DBPASSWORD can be completed if required. 
# They can be left unmodified if MongoDB has not been configured to require credentials.
WORKDIR /app/database

RUN touch rename.sh
RUN echo "sed -i 's/DBUSERNAME/${MONGO_INITDB_ROOT_USERNAME}/g' dbAccessData.js" >> rename.sh
RUN echo "sed -i 's/DBPASSWORD/${MONGO_INITDB_ROOT_PASSWORD}/g' dbAccessData.js" >> rename.sh
RUN echo "sed -i 's/testdb/${MONGO_INITDB_DATABASE}/g' dbAccessData.js" >> rename.sh
RUN echo "sed -i 's/ucivittest/${MONGO_INITDB_DATABASE}test/g' dbAccessData.js" >> rename.sh
RUN echo "sed -i 's/localhost/wevquery-mongo/g' dbAccessData.js" >> rename.sh
RUN bash rename.sh


WORKDIR /app


RUN echo "options.bindIP = '0.0.0.0';" >> options.js

# RUN echo "sed -i 's/CAPTURESERVERADDRESS/${WEVQUERY_HOST}/g' deploymentScript.html" > rename.sh
# RUN bash rename.sh

RUN npm install

CMD npm start