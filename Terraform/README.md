# Nano Node 
![Nano Logo](/Images/nano.png)


## Installing Terraform
You can find the guide to install terraform at the below link:
https://www.terraform.io/intro/getting-started/install.html


## Deploying Terraform Modules
The only updates to the Terraform modules you will have to make is the access credentials.

**AWS**  
To deploy to AWS you must configure a AWS Shared Credentials file and specify the path and profile name in the top level main.tf file.
Guide to configure aws credentials file can be found at - https://www.terraform.io/docs/providers/aws/

**Azure**  
To deploy to Azure you must login via the Azure CLI prior to the terraform deployment.
Guide for logging in via the Azure CLI can be found at - https://www.terraform.io/docs/providers/azurerm/authenticating_via_azure_cli.html 

**DigitalOcean**  
To deploy to DigitalOcean you just create an API token and specify this in the top level variables.tf file.
Guide to create a API token can be found at  - https://www.digitalocean.com/community/tutorials/how-to-use-the-digitalocean-api-v2 

**Guide**  
Deploying the modules can be broken down in to 5 easy steps:  
- Clone GitHub Respository.  
- Update your access credentials in the module as described above.  
- Change Directory to the Terraform Module you wish to deploy.  
- Run the command 'terraform init'  
- Run the command 'terraform apply'  