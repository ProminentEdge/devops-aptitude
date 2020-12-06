# Prominent Edge DevOps Aptitude

This repository is meant for paired programming sessions for interviewing potential
DevOps candidates through paired programming platforms such as codeanywhere.com.

### Important Notice!

This is still very much a Work In Progress. This may not be complete and is subject
to change.


## How to use


### Terraform

Once you are both logged onto paired programming platform. Pull this repository.
Next use `Terraform` to stand up an EC2 instance that you will then ssh into.


### Ansible

After the infrastructure is available and you have the EC2 instance IP (`terraform
output`). You can provision the instance with some basic tools necessary for the
interview using the ansible playbook.


### Interview

Now that you are both ssh'd into the EC2 instance and we have all the necessary
tools setup in the instance. Once again pull this repository, and you can begin
with the interview.

Right now the actual interview challenges are still being fleshed out. So please
check back for more specific details. But the general idea is to have an application
which is intentionally failing, and you task them with fixing it.
