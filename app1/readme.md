# Create a Node JS App
Create a new directory where all the files would live. 
## package.json
In this directory create a package.json file that describes your app and its dependencies:
```
{
  "name": "docker_web_app",
  "version": "1.0.0",
  "description": "Node.js on Docker",
  "author": "First Last <first.last@example.com>",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.16.1"
  }
} 
```
## npm install
With your new package.json file, run npm install. If you are using npm version 5 or later, this will generate a package-lock.json file which will be copied to your Docker image.
## server.js
Create a server.js file that defines a web app using the Express.js framework:
```
'use strict';

const express = require('express');

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';

// App
const app = express();
app.get('/', (req, res) => {
  res.send('Hello World');
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
```

## Source
https://nodejs.org/de/docs/guides/nodejs-docker-webapp/

## Docker
``` touch Dockerfile ```
Your app binds to port 8080 so you'll use the EXPOSE instruction to have it mapped by the docker daemon


## .dockerignore file
``` touch .dockerignore ```
Create a .dockerignore file in the same directory as your Dockerfile with following content:
```
node_modules
npm-debug.log
```
This will prevent your local modules and debug logs from being copied onto your Docker image and possibly overwriting modules installed within your image.

## Docker build
Go to the directory that has your Dockerfile and run the following command to build the Docker image.
* -t flag lets you tag your image so it's easier to find later using the docker images command
```
docker build -t <your username>/node-web-app .
```