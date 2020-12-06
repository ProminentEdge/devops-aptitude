# Prominent Edge DevOps Aptitude Terraform

Terraform (IaC) for PE DevOps Aptitude interview through codeanywhere.


## How To Use


### Start

Once you are both logged into the paired programming platform. Start by doing the
basic terraform plan and apply. There is a `Makefile` for convenience. But see
if they can manually do this.

Note: It does take a while for it to stand up the infrastructure. So don't spend
too much time on this step.


### After

Once the infrastructure is stood up. You should have a new interview iam user with
their own aws keys, and a newly created ssh key which you will use to ssh into
the EC2 instance. Terraform will also output the EC2 instance IP.

You will need to retrieve the private ssh key in the terraform local state file.


#### Before SSH

Before you can just right into the ssh EC2 instance. You will need to provision
it with `ansible`. There is a playbook in a sibling directory. It will install
necessary tools, such as aws cli, jq, docker, etc.

Once that is done, you can proceed with the interview inside the EC2 instance.
