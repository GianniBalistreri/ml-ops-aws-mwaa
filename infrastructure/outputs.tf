output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnets_ids" {
  description = "List with the IDs of the public subnets"
  value       = aws_subnet.public_subnets.*.id
}

output "private_subnets_ids" {
  description = "List with the IDs of the private subnets"
  value       = aws_subnet.private_subnets.*.id
}

output "s3_bucket_id" {
  description = "ID of S3 bucket"
  value       = aws_s3_bucket.airflow.id
}

output "mwaa_environment_arn" {
  description = "ARN of MWAA environment"
  value       = aws_mwaa_environment.mwaa_environment.arn
}
