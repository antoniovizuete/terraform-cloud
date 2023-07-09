locals {
  suffix = "${var.tags["Project"]}-${var.tags["Environment"]}"
}

resource "random_string" "random_suffix_s3" {
  length  = 8
  special = false
  upper   = false
}

locals {
  s3_suffix = "${lower(var.tags.Project)}-${random_string.random_suffix_s3.result}"
}
