# STAGE 1 : Build the base image
FROM node:15.4 as build

WORKDIR /app
# COPY PACKAGE.JSON AND PACKAGE-LOCK.JSON TO /app
COPY package*.json .
# INSTALL DEPENDENCIES
RUN npm install
# COPY NODE MODULE TO /app
COPY . .
# BUILD NESTJS APPLICATION
RUN npm run build

# STAGE 2 : 
FROM node:15.4 

WORKDIR /app
# COPY PACKAGE.JSON AND PACKAGE-LOCK.JSON TO /app
COPY package*.json .
# RUN ONLY PRODUCTION DEPENDENCIES
RUN npm install --only=production
# COPY NODE MODULE TO /app
COPY --from=build ./app/dist ./dist
# LANCER EN PRODUCTION AVEC UN POID MOINDRE
CMD npm run start:prod
