Docker volumes on the command line

-v $(pwd):/app -> this maps the /app on the container to the folder returned by pwd on the local machine

If the container tries to access something on the local machine that does not exist but which exists in the container, we can use a syntax like below to fix that so that the container uses its own version of the said folder
farayola$ docker run -p 3000:3000 -v /app/node_modules -v $(pwd):/app 5d09d6ebab46

We can use the volumes option in the docker-compose file to encapsulate this complicated syntax for volume mapping

Now that we know how to use volume mounting, it begs the question, do we still need to use the COPY command to copy files into the container?
We can technically get away with removing the COPY command but it doesn't hurt to leave it there because we might need it in say a production Dockerfile

We can run a test process in a node container by providing the test command as the default command for the container to run on boot

Attach to a running container by using 
docker exec -it container-id sh/bash 
docker run -it container-id/image-name command to run -> this way we can override the default command for a container and make it run the provided command instead

When we need to run tests for an app running in a container and we need the test to pick up live changes to the application test files, we can use a simple approach of running the app in a container already setup with volume mounting and then we can just sh into that container and run our tests directly from inside it. The other approach will be to create a new service for running tests in the docker-compose file for the project

docker-compose up (you can add --build if you've made changes recently)

docker attach container-id -> this allows us to attach our terminal to the stdin of a running container

It is possible to create a multi stage docker file that can go through multiple build stages. This way we can use two different base images one for build and the other the base image for the final image that will be created https://www.udemy.com/docker-and-kubernetes-the-complete-guide/learn/lecture/11437094#content

We utilize travis ci to run automated tests for our app once we push to github. Travis ci can run our tests and if they were successful, it can move to the next step which will be deploying the application itself.

For hosting the application, we will be using AWS Elastic Beanstalk. It is the easiest way to host a docker application if we are running one container at a time.

Elastic beanstalk automatically spin up new instances - essentially automatically scaling up our application to handle excess loads