FROM node:10

ARG MONGO_INITDB_ROOT_USERNAME
ARG MONGO_INITDB_ROOT_PASSWORD
ARG MONGO_INITDB_DATABASE

WORKDIR /app
COPY . .

# In the folder mongoDAO, there is a file called dbAccessDataTemplate.js. 
# Copy or rename that file to dbAccessData.js, and, if necessary, 
# modify it with the credentials to your MongoDB installation. 
# If no authentication is required, there is no need to modify this file.

WORKDIR /app/mongoDAO
RUN cp dbAccessDataTemplate.js dbAccessData.js

RUN touch rename.sh
RUN echo "sed -i 's/DBUSERNAME/${MONGO_INITDB_ROOT_USERNAME}/g' dbAccessData.js" >> rename.sh
RUN echo "sed -i 's/DBPASSWORD/${MONGO_INITDB_ROOT_PASSWORD}/g' dbAccessData.js" >> rename.sh
RUN echo "sed -i 's/ucivitdb/${MONGO_INITDB_DATABASE}/g' dbAccessData.js" >> rename.sh
RUN echo "sed -i 's/localhost/wevquery-mongo/g' dbAccessData.js" >> rename.sh
RUN bash rename.sh


# In the root folder, copy or rename the file userCredentialsTemplate.js to userCredentials.js. 
# This file enables basic HTTP authentication. 
# You just need to add another line to the userList with the desired user and password. 
# By default the HTTP authentication is off.
WORKDIR /app
COPY ./userCredentialsTemplate.js userCredentials.js

# The Readme file shows that the apllication should run on 2929, but the source code was setted to 3030
# Then, replace 3030 by 2929
RUN sed -i 's/3030/2929/g' options.js

RUN npm install

CMD npm start