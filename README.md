## What is this?

This is a basic terraform repository that builds a fleet of EC2 instances to host a web application behind an ALB

### Initialization

This line is used to scan the code, figure out what providers are being used, and download the code for them. It is safe to run this command multiple times

`terraform init`

### Deploying resources

`terraform plan` (optional)

`terraform apply`

### Fetch the index.html content

`curl http://54.165.125.42:0321`

### Cleanup

`terraform destroy`

#### Ref.
https://blog.gruntwork.io/an-introduction-to-terraform-f17df9c6d180