## Terraform introduction

Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.


## Terraform versions

For Terraform 0.12 use version v2.* of this module.

If you are using Terraform 0.11 you can use versions v1.*.


## AWS authentification
The AWS provider is used to interact with the many resources supported by AWS. The provider needs to be configured with the proper credentials before it can be used.

```
provider "aws" {
  access_key = "secret"
  secret_key = "secret"
  region     = "us-east-1"
}
```

## Getting Started

Before terraform apply you must download provider plugin:

```
terraform init
```

Display plan before apply manifest
```
terraform plan
```

Apply manifest
```
terraform apply
```

Destroy stack
```
terraform destroy
```

## Documentation
[https://www.terraform.io/docs/providers/aws//](https://www.terraform.io/docs/providers/aws/)

[https://github.com/terraform-providers/terraform-provider-aws/tree/master/examples](https://github.com/terraform-providers/terraform-provider-aws/tree/master/examples)
