FROM wevquery/base AS builder

FROM mongo:3.6

ARG MONGO_INITDB_ROOT_USERNAME
ARG MONGO_INITDB_ROOT_PASSWORD
ARG MONGO_INITDB_DATABASE

COPY --from=builder /var/lib/base/* /base
RUN echo "mongorestore -u ${MONGO_INITDB_ROOT_USERNAME} -p \"${MONGO_INITDB_ROOT_PASSWORD}\" --authenticationDatabase admin ." > /base/entrypoint.sh
RUN chmod +x /base/entrypoint.sh

# RUN echo "#!/bin/bash" > entrypoint.sh
# RUN echo "set -e" >> entrypoint.sh
# RUN echo "mongorestore -u ${MONGO_INITDB_ROOT_USERNAME} -p \"${MONGO_INITDB_ROOT_PASSWORD}\" --authenticationDatabase admin ." >> entrypoint.sh
# RUN echo "exec \"\$@\"" >> entrypoint.sh

# RUN chmod +x entrypoint.sh

# CMD ["./entrypoint.sh"]

# Open a command line where the uncompressed folder is located, and execute the following command: mongorestore ucivitdb/. 
# RUN mongorestore ucivitdb/. 

# If credentials are needed to access your database, you will have to run the 
# command in this manner: mongorestore -u USER -p "PASSWORD" --authenticationDatabase admin ucivitdb/. 
# More information about restoring a database in mongoDB can be found here https://docs.mongodb.com/manual/reference/program/mongorestore/.
# RUN mongorestore -u USER -p "PASSWORD" --authenticationDatabase admin ucivitdb/. 