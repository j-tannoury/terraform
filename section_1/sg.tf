data "aws_ip_ranges" "useast_ip_range" {
    regions = ["us-east-1","us-east-2"]
    services = ["ec2"]
}

resource "aws_security_group" "custom_us_east" {
    name = "custom_us_east"

    ingress {
        from_port = "443"
        to_port = "443"
        protocol = "TCP"
        cidr_blocks = [data.aws_ip_ranges.useast_ip_range.cidr_blocks[0]]
    }

    tags = {
        CreateDate = data.aws_ip_ranges.useast_ip_range.create_date
        SyncToken = data.aws_ip_ranges.useast_ip_range.sync_token
    }
}