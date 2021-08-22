# Terraform Basics

### To enter terraform console
```
$ terraform console
```
### Initialise the folder to add all the dependencies & configurations
```
$ terraform init
```
### To format & validate the configurations
```
$ terraform fmt
$ terraform validate
```
### Get blueprint of configurations
```
$ terraform plan
$ terraform plan -out=<filename>.out
```
### To apply the configurations
```
$ terraform apply
```
### Inspect state of configuration
```
$ terraform show
$ terraform state list
```
### To destroy the config.
```
$ terraform destroy
```