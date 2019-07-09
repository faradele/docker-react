# This will be build the image we will use for production
# We are using a multi step build process so we can use different base 
# images to build different stages of our application
# define the 'build' phase...
FROM node:alpine as builder

WORKDIR /app

COPY package.json .

RUN npm install 

COPY . . 

RUN npm run build 

# End of the build phase which we named as 'builder'
# also we don't need the volume, port mapping etc since we 
# just want to get the production build result

# The 'run' phase where we can use another image
# by just adding a new FROM statement, docker automatically starts a new phase
FROM nginx

# Let's copy over the files generated from the previous base
COPY --from=builder /app/build /usr/share/nginx/html

# The default command on the nginx image will automatically start nginx for us so we don't need to add the CMD command to start it