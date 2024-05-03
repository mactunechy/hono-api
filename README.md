# Deployment.

1. push repo to codecomit
2. Lunch an ec2 instance with the cloudformation template
  - the template creates a new VPC, IGW, Public submit.
  - you will need to manually update the RT to point the the IGW, (I will fix the template later)
3. Installing nginx on the ec2 instance. 
4. configure ssh keys with your githup account. # no need since the repo is public.
5. Install git, docker, docker-compose
6. update nginx with so that it reverse proxies to the app (I used the auto assigned IP for now. will update with an elastic IP)
7. copy env file to ec2 instance.
8. clean up volumes and build again
9. run migrations and seed.