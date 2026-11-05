# Output VPC ID
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

# Output VPC CIDR block
output "vpc_cidr_block" {
  description = "IPv4 CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

# Output public subnet IDs
output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

# Output private subnet IDs
output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = [for subnet in aws_subnet.private : subnet.id]
}

# Output NAT gateway public IP
output "nat_public_ip" {
  description = "Public IP address used for outbound traffic from private subnets"
  value       = aws_eip.nat.public_ip
}