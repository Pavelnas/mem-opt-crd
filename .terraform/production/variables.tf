
variable "env" {
  description = "Value of the environment variable"
  type        = string
  default     = "production"
}

variable "enable-custom-vpc" {
  description = "Enable custom VPC"
  type        = bool
  default     = false
}

variable "custom-vpc" {
  description = "Custom VPC ID"
  type        = string
  default     = "vpc-XXXXXXXXXXXX"
}
variable "custom-subnets" {
  type = object({
    private-a = string
    private-b = string
    public-a  = string
    public-b  = string
  })
  default = {
    private-a = "subnet-XXXXXXXXXXX"
    private-b = "subnet-XXXXXXXXXXX"
    public-a = "subnet-XXXXXXXXXXX"
    public-b = "subnet-XXXXXXXXXXX"
  }
}