FROM node:12-alpine3.12


# make Zscaler cert available globally
COPY ./ZscalerRootCA.cer /usr/local/share/ca-certificates/
RUN apk add --no-cache ca-certificates
RUN ln -sf /etc/ssl/certs/ca-certificates.crt /etc/ssl/cert.pem # some apps use /etc/ssl/cert.pem
 
#WORKDIR /src
#COPY . .
 
# make Zscaler cert (+ the normal certs) available for yarn or npm (delete whichever you don't use)
ENV NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt



# add from local file into the root dir in the image
ADD app.js /app.js

# this command will be executed when somebody runs the image 
ENTRYPOINT [ "node", "app.js" ]
