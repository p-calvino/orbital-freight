output "state_bucket_final_name" {
  value = aws_s3_bucket.tf_state.bucket
}

output "lock_table" {
  value = aws_dynamodb_table.tf_lock.name
}

output "ecr_repository_url" {
  value = module.registry.repository_url
}
