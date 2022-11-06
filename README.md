# AWS Naming

This module helps you to keep consistency on your resources names for Terraform The goal of this module it is that for each resource that requires a name in Terraform you would be easily able to compose this name using this module and this will keep the consistency in your repositories.

# Usage

For every resource in `terraform_aws` just remove the `aws` part of the module and use the `name` property of this output.

example for `aws_s3_bucket` you can use :

```tf
module "aws_naming" {
  source                 = "github.com/Nimbus-Networks/Aws-Tf-Mod-aws-naming"
  prefix                 = [local.resource_prefix]
  iteration              = [local.resource_iteration]
  suffix                 = [local.resource_suffix]
  unique-seed            = "random"
  unique-length          = 2
  unique-include-numbers = false
}

resource "aws_s3_bucket" "example" {
  bucket = module.aws_naming.s3_bucket.name
}
```

if you want this to be unique for this module and not shared with other instances of this module you can use `name_unique`

```tf
resource "aws_s3_bucket" "example_unique" {
  bucket = module.aws_naming.s3_bucket.name_unique
}
```
Other advanced usages will be explained in the [Advanced usage](#advanced-usage) part of this docs.

## Output

Each one of the resources emits the name of the resource and other properties:

| Property | Type | Description |
| ----- |----- | ---- |
| name | string | name of the resource including respective suffixes and prefixes applied |
| name_unique | string | same as the name but with random chars added for uniqueness |
| dashes | bool | if these resources support dashes |
| slug | string | letters to identify this resource among others |
| min_length | integer | Minimum length required for this resource name |
| max_length | integer | Maximum length allowed for this resource name |
| scope | string | scope which this name needs to be unique, such as `resourcegroup` or `global`  |
| regex | string | Terraform compatible version of the regex |

### Example Output

Every resource will have an output with the following format:

```go
postgresql_server = {
      name        = "pre-fix-psql-su-fix"
      name_unique = "pre-fix-psql-su-fix-asdfg"
      dashes      = true
      slug        = "psql"
      min_length  = 3
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]$"
    }
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.3.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.3.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_string.first_letter](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [random_string.main](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_prefix"></a> [prefix](#input\_prefix) | It is not recommended that you use prefix by azure you should be using a suffix for your resources. | `list(string)` | `[]` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | It is recommended that you specify a suffix for consistency. please use only lowercase characters when possible | `list(string)` | `[]` | no |
| <a name="input_unique-include-numbers"></a> [unique-include-numbers](#input\_unique-include-numbers) | If you want to include numbers in the unique generation | `bool` | `true` | no |
| <a name="input_unique-length"></a> [unique-length](#input\_unique-length) | Max length of the uniqueness suffix to be added | `number` | `4` | no |
| <a name="input_unique-seed"></a> [unique-seed](#input\_unique-seed) | Custom value for the random characters to be used | `string` | `""` | no |

## Outputs
