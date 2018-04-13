FROM node:8
RUN mkdir -p /opt/app

ARG NODE_ENV=dev
ENV NODE_ENV $NODE_ENV

# default to port 80 for node, and 5858 or 9229 for debug
ARG PORT=8081
ENV PORT $PORT
EXPOSE $PORT 5858 9229

# check every 30s to ensure this service returns HTTP 200
HEALTHCHECK CMD curl -fs http://localhost:$PORT/healthz || exit 1

# install dependencies first, in a different location for easier app bind mounting for local development
# WORKDIR /opt
# COPY app/package.json app/package-lock.json* ./
# RUN npm install && npm cache clean --force
# ENV PATH /opt/node_modules/.bin:$PATH

# copy in our source code last, as it changes the most
WORKDIR /opt/app
COPY app /opt/app
RUN npm install && npm cache clean --force
ENV PATH /opt/node_modules/.bin:$PATH

CMD [ "node", "index.js" ]
