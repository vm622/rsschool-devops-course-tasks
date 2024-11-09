data "aws_availability_zones" "zones" {
  state = "available"

}

locals {
  zones = data.aws_availability_zones.zones.names
}

