#--------------------------
# Utilizing Nginx to assit in spinning
# up a web application
#--------------------------

FROM smebberson/alpine-nginx 
#ENV WEBROOT=/var/www/html/
RUN apk -U upgrade && apk add alpine-sdk python nodejs 
  
# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
RUN npm install -g gulp bower

# Install app dependencies
ADD package.json bower.json /usr/src/app/
RUN npm install && bower install --allow-root

# Bundle app source
COPY . /usr/src/app

# Build out files
RUN npm run start

# Put all our code inside that directory that lives in the container
RUN cp -r /usr/src/app/dist/* /usr/html/

# Expose the ports for nginx
EXPOSE 80
