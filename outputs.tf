output "unique-seed" {
  value = coalesce(var.unique-seed, local.random_safe_generation)
}
output "validation" {
  value = local.validation
}
output "autoscaling_group" {
  value       = local.aws.autoscaling_group
  description = "Autoscaling Group"
}
output "autoscaling_policy" {
  value       = local.aws.autoscaling_policy
  description = "Autoscaling Policy"
}
output "autoscaling_schedule" {
  value       = local.aws.autoscaling_schedule
  description = "Autoscaling Schedule"
}
output "cloudwatch_event_rule" {
  value       = local.aws.cloudwatch_event_rule
  description = "Cloudwatch Event Rule"
}
output "cloudwatch_log_group" {
  value       = local.aws.cloudwatch_log_group
  description = "Cloudwatch Log Group"
}
output "cloudwatch_metric_alarm" {
  value       = local.aws.cloudwatch_metric_alarm
  description = "Cloudwatch Metric Alarm"
}
output "cloudwatch_metric_stream" {
  value       = local.aws.cloudwatch_metric_stream
  description = "Cloudwatch Metric Stream"
}
output "codebuild_project" {
  value       = local.aws.codebuild_project
  description = "Codebuild Project"
}
output "codecommit_repository" {
  value       = local.aws.codecommit_repository
  description = "Codecommit Repository"
}
output "codepipeline" {
  value       = local.aws.codepipeline
  description = "Codepipeline"
}
output "db_instance" {
  value       = local.aws.db_instance
  description = "DB Instance"
}
output "db_parameter_group" {
  value       = local.aws.db_parameter_group
  description = "DB Parameter Group"
}
output "dms_endpoint" {
  value       = local.aws.dms_endpoint
  description = "DMS Endpoint"
}
output "dms_replication_instance" {
  value       = local.aws.dms_replication_instance
  description = "DMS Replication Instance"
}
output "dms_replication_task" {
  value       = local.aws.dms_replication_task
  description = "DMS Replication Task"
}
output "dynamodb_table" {
  value       = local.aws.dynamodb_table
  description = "DynamoDB Table"
}
output "ecr_repository" {
  value       = local.aws.ecr_repository
  description = "ECR Repository"
}
output "ecs_cluster" {
  value       = local.aws.ecs_cluster
  description = "ECS Cluster"
}
output "ecs_service" {
  value       = local.aws.ecs_service
  description = "ECS Service"
}
output "ecs_task_definition" {
  value       = local.aws.ecs_task_definition
  description = "ECS Task Definition"
}
output "elasticache_cluster" {
  value       = local.aws.elasticache_cluster
  description = "Elasticache Cluster"
}
output "elasticache_parameter_group" {
  value       = local.aws.elasticache_parameter_group
  description = "Elasticache Parameter Group"
}
output "elasticsearch_domain" {
  value       = local.aws.elasticsearch_domain
  description = "Elasticsearch Domain"
}
output "glue_job" {
  value       = local.aws.glue_job
  description = "Glue Job"
}
output "iam_instance_profile" {
  value       = local.aws.iam_instance_profile
  description = "IAM Instance Profile"
}
output "iam_role" {
  value       = local.aws.iam_role
  description = "IAM Role"
}
output "instance" {
  value       = local.aws.instance
  description = "Instance"
}
output "key_pair" {
  value       = local.aws.key_pair
  description = "Key Pair"
}
output "kinesis_firehose_delivery_stream" {
  value       = local.aws.kinesis_firehose_delivery_stream
  description = "Kinesis Firehose Delivery Stream"
}
output "lambda_function" {
  value       = local.aws.lambda_function
  description = "Lambda Function"
}
output "launch_configuration" {
  value       = local.aws.launch_configuration
  description = "Launch Configuration"
}
output "lb" {
  value       = local.aws.lb
  description = "Load Balancer"
}
output "lb_target_group" {
  value       = local.aws.lb_target_group
  description = "Load Balancer Target Group"
}
output "s3_bucket" {
  value       = local.aws.s3_bucket
  description = "S3 Storage Bucket"
}
output "secretsmanager_secret" {
  value       = local.aws.secretsmanager_secret
  description = "Secrets Manager Secret"
}
output "security_group" {
  value       = local.aws.security_group
  description = "Security Group"
}
output "sns_topic" {
  value       = local.aws.sns_topic
  description = "SNS Topic"
}
output "sns_queue" {
  value       = local.aws.sns_queue
  description = "SNS Topic"
}
output "step_function" {
  value       = local.aws.step_function
  description = "Step Function"
}
output "waf_byte_match_set" {
  value       = local.aws.waf_byte_match_set
  description = "WAF Byte Match Set"
}
output "waf_geo_match_set" {
  value       = local.aws.waf_geo_match_set
  description = "WAF Geo Match Set"
}
output "waf_ipset" {
  value       = local.aws.waf_ipset
  description = "WAF IP Set"
}
output "waf_rate_based_rule" {
  value       = local.aws.waf_rate_based_rule
  description = "WAF Rate Based Rule"
}
output "waf_regex_match_set" {
  value       = local.aws.waf_regex_match_set
  description = "WAF Regex Match Set"
}
output "waf_regex_pattern_set" {
  value       = local.aws.waf_regex_pattern_set
  description = "WAF Regex Pattern Set"
}
output "waf_rule" {
  value       = local.aws.waf_rule
  description = "WAF Rule"
}
output "waf_rule_group" {
  value       = local.aws.waf_rule_group
  description = "WAF Rule Group"
}
output "waf_size_constraint_set" {
  value       = local.aws.waf_size_constraint_set
  description = "WAF Size Constraint Set"
}
output "waf_sql_injection_match_set" {
  value       = local.aws.waf_sql_injection_match_set
  description = "WAF SQL Injection Match Set"
}
output "waf_web_acl" {
  value       = local.aws.waf_web_acl
  description = "WAF Web ACL"
}
output "waf_xss_match_set" {
  value       = local.aws.waf_xss_match_set
  description = "WAF XSS Match Set"
}
output "wafregional_byte_match_set" {
  value       = local.aws.wafregional_byte_match_set
  description = "WAF Regional Byte Match Set"
}
output "wafregional_geo_match_set" {
  value       = local.aws.wafregional_geo_match_set
  description = "WAF Regional Geo Match Set"
}
output "wafregional_ipset" {
  value       = local.aws.wafregional_ipset
  description = "WAF Regional IP Set"
}
output "wafregional_rate_based_rule" {
  value       = local.aws.wafregional_rate_based_rule
  description = "WAF Regional Rate Based Rule"
}
output "wafregional_regex_match_set" {
  value       = local.aws.wafregional_regex_match_set
  description = "WAF Regional Regex Match Set"
}
output "wafregional_regex_pattern_set" {
  value       = local.aws.wafregional_regex_pattern_set
  description = "WAF Regional Regex Pattern Set"
}
output "wafregional_rule" {
  value       = local.aws.wafregional_rule
  description = "WAF Regional Rule"
}
output "wafregional_rule_group" {
  value       = local.aws.wafregional_rule_group
  description = "WAF Regional Rule Group"
}
output "wafregional_size_constraint_set" {
  value       = local.aws.wafregional_size_constraint_set
  description = "WAF Regional Size Constraint Set"
}
output "wafregional_sql_injection_match_set" {
  value       = local.aws.wafregional_sql_injection_match_set
  description = "WAF Regional SQL Injection Match Set"
}
output "wafregional_web_acl" {
  value       = local.aws.wafregional_web_acl
  description = "WAF Regional Web ACL"
}
output "wafregional_xss_match_set" {
  value       = local.aws.wafregional_xss_match_set
  description = "WAF Regional XSS Match Set"
}
output "global_accelerator" {
  value       = local.aws.global_accelerator
  description = "Global Accelerator"
}
