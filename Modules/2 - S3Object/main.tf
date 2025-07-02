locals {
  export_dir = "${path.module}/out"
  static_files = fileset(local.export_dir, "**/*")

  # Only JS, MJS, JSX and CSS for now,
  # but you can extend this map as needed.
  mime_map = {
    js   = "application/javascript"
    mjs  = "application/javascript"
    jsx  = "application/javascript"
    css  = "text/css"
    html = "text/html"
  }
}

resource "aws_s3_object" "nextjs_assets" {
  for_each = { for f in local.static_files : f => f }

  bucket = var.fnf_s3_static_bucket_name
  key    = each.value
  source = "${local.export_dir}/${each.value}"
  acl    = "public-read"

  # extract extension and look up its mime type
  content_type = lookup(
    local.mime_map,
    lower(regex("\\.([^.]+)$", each.value)[1]),
    "application/octet-stream"
  )
}
